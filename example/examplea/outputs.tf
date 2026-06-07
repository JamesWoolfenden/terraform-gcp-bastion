output "bastion" {
  value       = module.bastion.bastion
  sensitive   = true
  description = "The bastion host instance created by the module"
}

output "firewall" {
  value       = module.bastion.firewall
  description = "The firewall rule created by the module"
}

output "image" {
  value       = module.bastion.image
  description = "The image used for the bastion host"
}
