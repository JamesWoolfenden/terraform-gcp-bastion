account_id    = "test123@pike-361314.iam.gserviceaccount.com"
zone          = "europe-west2-a"
name          = "bastion"
project       = "pike"
service_email = ""
region        = "europe-west2"
source_cidrs  = ["0.0.0.0/0"]
image = {
  family  = "ubuntu-minimal-2204-lts"
  project = "ubuntu-os-cloud"
}

network_interface = {
  network            = "default"
  subnetwork         = ""
  subnetwork_project = ""
}

keyring = "pike"
