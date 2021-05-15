
output "bastion" {
  description = "The Attributes of the Bastion"
  value       = google_compute_instance.bastion
  sensitive   = true
}

output "firewall" {
  description = "The Attributes of the firewall"
  value       = google_compute_firewall.ssh-bastion
}

output "image" {
  description = "The Attributes of the Image"
  value       = data.google_compute_image.image
}
