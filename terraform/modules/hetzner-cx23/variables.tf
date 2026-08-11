variable "server_name" {
  description = "Name of the Hetzner Cloud server."
  type        = string
}

variable "location" {
  description = "Hetzner Cloud datacenter location (e.g. fsn1, nbg1, hel1)."
  type        = string
  default     = "fsn1"
}

variable "image" {
  description = "OS image to use for the server."
  type        = string
  default     = "ubuntu-24.04"
}

variable "ssh_public_key" {
  description = "Public SSH key to be injected into the server."
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key resource registered in Hetzner Cloud."
  type        = string
  default     = "korp-deploy"
}

variable "labels" {
  description = "Labels attached to the server."
  type        = map(string)
  default     = {}
}
