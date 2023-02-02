variable "ipv4" {
  description = "The IPv4 to point DNS A records to."
  default     = "127.0.0.1"
  type        = string
}

variable "ipv6" {
  description = "The IPv6 to point DNS AAAA records to."
  default     = "::1"
  type        = string
}

variable "domain" {
  description = "The root domain to setup DNS for"
  type        = string
}

variable "subdomains" {
  description = "All subdomains to setup DNS for"
  type        = set(string)
}