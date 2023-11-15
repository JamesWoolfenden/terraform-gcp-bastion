module "bastion" {
  source            = "../../"
  account_id        = var.account_id
  image             = var.image
  name              = var.name
  network_interface = var.network_interface
  service_email     = var.service_email
  source_cidrs      = var.source_cidrs
  zone              = var.zone
  keyring           = var.keyring
  init_script       = file("install-kube.sh")
}


# data google_projects "pike" {}