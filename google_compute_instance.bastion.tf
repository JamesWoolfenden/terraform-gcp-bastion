resource "google_compute_instance" "bastion" {
  project      = var.project
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image.name
    }
  }

  network_interface {
    subnetwork_project = var.network_interface["subnetwork_project"]
    subnetwork         = var.network_interface["subnetwork"]
    network            = var.network_interface["network"]
    access_config {}
  }

  metadata = {
    startup-script = "${file("${path.module}/template/install-kube.sh")}"
    enable-oslogin = "TRUE"
  }

  service_account {
    email  = var.service_email
    scopes = var.service_scope
  }

  allow_stopping_for_update = true
}
