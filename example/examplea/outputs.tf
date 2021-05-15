output "bastion" {
  value     = module.bastion.bastion
  sensitive = true
}

output "firewall" {
  value = module.bastion.firewall
}

output "image" {
  value = module.bastion.image
}
