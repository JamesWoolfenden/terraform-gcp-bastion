resource "google_compute_firewall" "ssh-bastion" {
  count       = var.firewall
  name        = var.name
  description = "Allow SSH to the bastion via Identity-Aware Proxy TCP forwarding only"
  network     = var.network_interface["network"]
  project     = var.network_interface["subnetwork_project"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # 35.235.240.0/20 is Google's fixed, documented range for IAP TCP forwarding —
  # a GCP constant, not a per-deployment choice. With no external IP on the
  # instance, this is the only path SSH traffic can take.
  source_ranges = ["35.235.240.0/20"]
  target_tags   = var.tags

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
