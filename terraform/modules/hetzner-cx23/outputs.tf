output "server_id" {
  description = "ID of the provisioned CX23 server."
  value       = hcloud_server.cx23.id
}

output "server_name" {
  description = "Name of the provisioned server."
  value       = hcloud_server.cx23.name
}

output "ipv4_address" {
  description = "Public IPv4 address of the server."
  value       = hcloud_server.cx23.ipv4_address
}

output "status" {
  description = "Current status of the server."
  value       = hcloud_server.cx23.status
}
