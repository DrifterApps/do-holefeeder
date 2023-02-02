# DO infrastructure resources
resource "tls_private_key" "global_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_sensitive_file" "ssh_private_key_pem" {
  filename        = "${path.module}/id_rsa"
  content         = tls_private_key.global_key.private_key_pem
  file_permission = "0600"
}

resource "local_file" "ssh_public_key_openssh" {
  filename = "${path.module}/id_rsa.pub"
  content  = tls_private_key.global_key.public_key_openssh
}

# Temporary key pair used for SSH accesss
resource "digitalocean_ssh_key" "quickstart_ssh_key" {
  name       = "${var.prefix}-droplet-ssh-key"
  public_key = tls_private_key.global_key.public_key_openssh
}

# DO droplet for creating a single node RKE cluster and installing the k3s server
resource "digitalocean_droplet" "k3s_server" {
  name       = "${var.prefix}-cluster"
  image      = "ubuntu-20-04-x64"
  region     = var.do_region
  size       = var.droplet_size
  monitoring = true
  ipv6       = true
  ssh_keys   = [digitalocean_ssh_key.quickstart_ssh_key.fingerprint]

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}

# k3s resources
module "k3s_common" {
  source = "./k3s-common"

  node_public_ip      = digitalocean_droplet.k3s_server.ipv4_address
  node_internal_ip    = digitalocean_droplet.k3s_server.ipv4_address_private
  node_username       = local.node_username
  ssh_private_key_pem = tls_private_key.global_key.private_key_pem

  k3s_kubernetes_version = var.k3s_kubernetes_version
  cert_manager_version   = var.cert_manager_version

  portainer_version = var.portainer_version
  k3s_version       = var.k3s_version

  k3s_server_dns = join(".", ["k3s", digitalocean_droplet.k3s_server.ipv4_address, "sslip.io"])
  admin_password = var.k3s_server_admin_password
  domain         = var.domain
}

module "domains" {
  source     = "./domains"
  domain     = var.domain
  subdomains = var.subdomains
  ipv4       = digitalocean_droplet.k3s_server.ipv4_address
  ipv6       = digitalocean_droplet.k3s_server.ipv6_address
}

module "firewall" {
  source      = "./firewall"
  prefix      = var.prefix
  droplet_ids = [digitalocean_droplet.k3s_server.id]
}
