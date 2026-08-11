output "server_id" {
  description = "ID of the provisioned CX23 server."
  value       = module.hetzner_cx23.server_id
}

output "server_name" {
  description = "Name of the provisioned server."
  value       = module.hetzner_cx23.server_name
}

output "server_ipv4_address" {
  description = "Public IPv4 address of the server."
  value       = module.hetzner_cx23.ipv4_address
}
