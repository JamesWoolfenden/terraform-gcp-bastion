output "bastion_node_ip" {
  value = google_compute_instance.bastion.network_interface.0.network_ip
}


output "external_ip" {
  value = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
}

output "bastion" {
  description = "The Attributes of the Bastion"
  value       = google_compute_instance.bastion
}

output "firewall" {
  description = "The Attributes of the firewall"
  value       = google_compute_firewall.ssh-bastion
}

output "image" {
  description = "The Attributes of the Image"
  value       = data.google_compute_image.image
}
