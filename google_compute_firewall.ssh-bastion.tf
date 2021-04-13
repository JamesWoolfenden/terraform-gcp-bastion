resource "google_compute_firewall" "ssh-bastion" {
  # checkov:skip=CKV_GCP_2:
  count       = var.firewall
  name        = var.name
  description = "firewall to bastion"
  network     = var.network_interface["network"]
  project     = var.network_interface["subnetwork_project"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.source_cidrs
  target_tags   = [google_compute_instance.bastion.name]
}
