resource "google_compute_address" "static" {
  name         = "bastion"
  network_tier = "PREMIUM"
  region       = var.region
}
