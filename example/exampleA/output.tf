output "bastion_node_ip" {
  value = module.bastion.bastion_node_ip
}

output external_ip {
  value = module.bastion.external_ip
}
