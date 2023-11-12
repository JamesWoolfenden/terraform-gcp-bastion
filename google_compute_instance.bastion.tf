resource "google_compute_instance" "bastion" {
  #checkov:skip=CKV_GCP_38:gcp encrypted by default
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
    access_config {
      nat_ip = var.nat_ip
    }
  }

  metadata = {
    startup-script         = var.init_script
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = true
  }

  service_account {
    email  = data.google_service_account.default.email
    scopes = var.service_scope
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  allow_stopping_for_update = true
}
