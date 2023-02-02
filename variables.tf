# Variables for DO infrastructure module

variable "do_token" {
  type        = string
  description = "DigitalOcean API token used to create infrastructure"
}

variable "domain" {
  type        = string
  description = "The root domain to setup DNS records for the droplet"
}

variable "subdomains" {
  type        = set(string)
  description = "The subdomains to setup DNS records for to the new droplet"
}

variable "do_region" {
  type        = string
  description = "DigitalOcean region used for all resources"
  default     = "tor1"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "k3s-prd"
}

variable "droplet_size" {
  type        = string
  description = "Droplet size used for all droplets"
  default     = "s-1vcpu-1gb"
}

variable "k3s_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for k3s server cluster"
  default     = "v1.26.0+k3s1"
}

variable "portainer_version" {
  type        = string
  description = "Version of Portainer to install (format: 0.0.0)"
  default     = "1.0.38"
}

variable "k3s_version" {
  type        = string
  description = "k3s server version (format: v0.0.0)"
  default     = "v2.6.3"
}

variable "cert_manager_version" {
  type        = string
  description = "Version of cert-manager to install alongside Rancher (format: 0.0.0)"
  default     = "1.11.0"
}

variable "k3s_server_admin_password" {
  type        = string
  description = "Admin password to use for k3s server bootstrap"
}

# Local variables used to reduce repetition
locals {
  node_username = "root"
}
