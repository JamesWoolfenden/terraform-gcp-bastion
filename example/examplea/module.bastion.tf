module "bastion" {
  source            = "../../"
  account_id        = var.account_id
  image             = var.image
  name              = var.name
  network_interface = var.network_interface
  project           = var.project
  service_email     = var.service_email
  source_cidrs      = var.source_cidrs
  zone              = var.zone
  keyring           = var.keyring
}
