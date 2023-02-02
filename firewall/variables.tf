variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
}

variable "droplet_ids" {
  type        = set(number)
  description = "The ids of the droplet to associate to the firewall"
}
