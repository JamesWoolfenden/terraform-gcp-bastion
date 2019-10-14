resource "google_compute_instance" "bastion" {
  project      = var.project
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork_project = var.subnetwork_project
    subnetwork         = var.subnetwork

    access_config {}
  }

  metadata = {
    startup-script     = "${file("${path.module}/template/install-kube.sh")}"
    enable-oslogin = "TRUE"
  }

  service_account {
    email = var.service_email
    scopes= var.service_scope
  }
  
  allow_stopping_for_update = true
}
