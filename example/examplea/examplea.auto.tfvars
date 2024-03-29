account_id    = "pike-service@pike-gcp.iam.gserviceaccount.com"
zone          = "europe-west2-a"
name          = "bastion"
project       = "pike-gcp"
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
