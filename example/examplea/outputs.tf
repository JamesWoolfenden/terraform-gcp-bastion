output "bastion" {
  value = module.bastion.bastion
}

output "firewall" {
  value = module.bastion.firewall
}

output "image" {
  value = module.bastion.image
}
