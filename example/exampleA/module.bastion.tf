module "bastion" {
  source             = "../../"
  image              = var.image
  project            = var.project
  source_cidrs       = var.source_cidrs
  subnetwork         = var.subnetwork
  subnetwork_project = var.subnetwork_project
  vpc_name           = var.vpc_name
  zone               = var.zone
}
