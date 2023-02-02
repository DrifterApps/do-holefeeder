terraform {
  # required_version = ">= 0.12"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.25.2"
    }
  }
}

# resource "digitalocean_domain" "domain" {
#   name = var.domain
# }

resource "digitalocean_record" "AAAA-records" {
  domain   = var.domain
  # domain   = digitalocean_domain.domain.name
  for_each = var.subdomains
  name     = each.key
  value    = var.ipv6
  type     = "AAAA"
}

resource "digitalocean_record" "A-records" {
  domain   = var.domain
  # domain   = digitalocean_domain.domain.name
  for_each = var.subdomains
  name     = each.key
  value    = var.ipv4
  type     = "A"
}
