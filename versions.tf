terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.25.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = ">= 1.0.0"
}
