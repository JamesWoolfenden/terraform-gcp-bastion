module "bastion" {
  source             = "../../"
  image              = var.image
  project            = var.project
  source_cidrs       = var.source_cidrs
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  network            = var.network
  zone               = var.zone
  name               = var.name
}
