zone          = "europe-west2-a"
name          = "bastion"
project       = "examplea"
service_email = ""
region        = "europe-west2"
source_cidrs  = ["0.0.0.0/0"]
image = {
  family  = "ubuntu-minimal-2010"
  project = "ubuntu-os-cloud"
}

network_interface = {
  network            = "default"
  subnetwork         = ""
  subnetwork_project = ""
}

keyring = "examplea"
