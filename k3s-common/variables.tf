# Variables for k3s common module

# Required
variable "node_public_ip" {
  type        = string
  description = "Public IP of compute node for k3s cluster"
}

variable "node_internal_ip" {
  type        = string
  description = "Internal IP of compute node for k3s cluster"
  default     = ""
}

# Required
variable "node_username" {
  type        = string
  description = "Username used for SSH access to the k3s server cluster node"
}

# Required
variable "ssh_private_key_pem" {
  type        = string
  description = "Private key used for SSH access to the k3s server cluster node"
}

variable "k3s_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for k3s server cluster"
  default     = "v1.21.4+k3s1"
}

variable "portainer_version" {
  type        = string
  description = "Version of Portainer to install (format: 0.0.0)"
  default     = "1.0.38"
}

variable "k3s_version" {
  type        = string
  description = "k3s server version (format v0.0.0)"
  default     = "v2.6.2"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.11.0"
}

# Required
variable "k3s_server_dns" {
  type        = string
  description = "DNS host name of the k3s server"
}

# Required
variable "admin_password" {
  type        = string
  description = "Admin password to use for k3s server bootstrap"
}

variable "domain" {
  type        = string
  description = "The root domain to setup DNS records for the droplet"
}
