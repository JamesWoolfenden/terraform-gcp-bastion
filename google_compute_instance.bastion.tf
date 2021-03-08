resource "google_compute_instance" "bastion" {
#checkov:skip=CKV_GCP_31
  project      = var.project
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    disk_encryption_key_raw = google_kms_crypto_key.pd.self_link
    initialize_params {
      image = data.google_compute_image.image.name
    }
  }

  network_interface {
    subnetwork_project = var.network_interface["subnetwork_project"]
    subnetwork         = var.network_interface["subnetwork"]
    network            = var.network_interface["network"]
    access_config {
      nat_ip = var.nat_ip
    }
  }

  metadata = {
    startup-script         = file("${path.module}/template/install-kube.sh")
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = true
  }

  service_account {
    email  = var.service_email
    scopes = var.service_scope
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  allow_stopping_for_update = true
}
