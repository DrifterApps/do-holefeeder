terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.25.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "2.3.0"
    }
  }
  required_version = ">= 1.0.0"
}
