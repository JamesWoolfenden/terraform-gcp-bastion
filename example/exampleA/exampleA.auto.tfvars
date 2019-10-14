zone          = "europe-west2-a"
name          = "bastion"
project       = "examplea"
service_email = ""
region        = "europe-west1"
source_cidrs  = ["0.0.0.0/0"]
image = {
  family  = "centos-7"
  project = "gce-uefi-images"
}


network_interface = {
  network            = "default"
  subnetwork         = ""
  subnetwork_project = ""
}
