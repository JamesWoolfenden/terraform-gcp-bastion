zone          = "europe-west2-a"
name          = "bastion"
project       = "examplea"
service_email = ""
region        = "europe-west2"
source_cidrs  = ["0.0.0.0/0"]
image = {
  family  = "ubuntu-1804-lts"
  project = "gce-uefi-images"
}

network_interface = {
  network            = "default"
  subnetwork         = ""
  subnetwork_project = ""
}
