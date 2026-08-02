# holden:ignore:HLD_GCP_170 — admin jump box, no sensitive in-use workload data to warrant Confidential Computing
# holden:ignore:HLD_GCP_391 — reusable module applied to disposable example/test bastions that must support terraform destroy in CI; add a deletion_protection variable if a specific deployment needs it
resource "google_compute_instance" "bastion" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    kms_key_self_link = var.kms_key_id
    initialize_params {
      image = data.google_compute_image.bastion.name
    }
  }

  # No access_config: this bastion has no external IP. Reachability is via
  # Identity-Aware Proxy TCP forwarding (gcloud compute ssh --tunnel-through-iap),
  # which tunnels SSH to the internal IP through Google's edge — see
  # google_compute_firewall.ssh-bastion and google_iap_tunnel_instance_iam_member.accessor.
  network_interface {
    subnetwork_project = var.network_interface["subnetwork_project"]
    subnetwork         = var.network_interface["subnetwork"]
    network            = var.network_interface["network"]
  }

  metadata = {
    startup-script         = var.init_script
    enable-oslogin         = true
    block-project-ssh-keys = true
  }

  service_account {
    email  = google_service_account.default.email
    scopes = var.service_scope
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  allow_stopping_for_update = true

  resource_policies = var.resource_policies

  # The Compute Engine service agent must hold cloudkms.cryptoKeyEncrypterDecrypter
  # on the CMEK key before instance creation — the only link to that grant is via
  # data.google_project.bastion.number, which doesn't produce a Terraform dependency
  # edge, so it must be explicit.
  depends_on = [google_kms_crypto_key_iam_member.bastion]
}
