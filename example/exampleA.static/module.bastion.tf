module "bastion" {
  source            = "../../"
  image             = var.image
  name              = var.name
  network_interface = var.network_interface
  project           = var.project
  service_email     = var.service_email
  source_cidrs      = var.source_cidrs
  nat_ip            = google_compute_address.static.address
  zone              = var.zone
}
