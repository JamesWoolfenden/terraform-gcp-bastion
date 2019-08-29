// FIREWALL RULES
resource "google_compute_firewall" "ssh-bastion" {
  name        = "${var.name}-ssh-bastion"
  description = "firewall to bastion"
  network     = var.vpc_name
  project     = var.project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.source_cidrs
  target_tags   = [google_compute_instance.bastion.name]
}
