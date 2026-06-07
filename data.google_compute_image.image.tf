data "google_compute_image" "bastion" {
  family  = var.image["family"]
  project = var.image["project"]
}
