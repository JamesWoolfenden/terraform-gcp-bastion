module bastion {
  source            = "../../"
  image             = var.image
  name              = var.name
  network_interface = var.network_interface
  project           = var.project
  service_email     = var.service_email
  source_cidrs      = var.source_cidrs
  zone              = var.zone
}
