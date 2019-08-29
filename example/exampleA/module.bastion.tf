module "bastion" {
    source="../../"
    image             = var.image
    project           = var.project
    subnetwork_project= var.subnetwork_project
    subnetwork        = var.subnetwork
    zone              = var.zone
}
