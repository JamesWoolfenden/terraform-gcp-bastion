output "bastion_node_ip" {
  value = google_compute_instance.bastion.network_interface.0.network_ip
}


output "external_ip" {
  value = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
}
