data "google_compute_image" "image" {
  family  = var.image["family"]
  project = var.image["project"]
}
