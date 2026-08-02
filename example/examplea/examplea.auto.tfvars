account_id = "pike-bastion"
zone       = "europe-west2-a"
name       = "bastion"

iap_members = ["user:james.woolfenden@gmail.com"]
image = {
  family  = "ubuntu-minimal-2204-lts"
  project = "ubuntu-os-cloud"
}
environment = "dev"
team        = "examplea"

network_interface = {
  network            = "default"
  subnetwork         = ""
  subnetwork_project = ""
}
