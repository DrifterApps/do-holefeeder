locals {
  cert_manager_template = "${path.module}/templates/cert-manager-config.tftpl"
  portainer_template = "${path.module}/templates/portainer-config.tftpl"
  traefik_template = "${path.module}/templates/traefik-config.tftpl"
}

resource "null_resource" "deploy_cert_manager_config" {
  depends_on = [
    ssh_resource.k3s_installation_complete
  ]
  triggers = {
    policy_sha1 = "${sha1(file(local.cert_manager_template))}"
  }
  provisioner "file" {
    content = templatefile(local.cert_manager_template, {
      domain      = var.domain
    })

    destination = "/var/lib/rancher/k3s/server/manifests/cert-manager-config.yaml"
    
    connection {
      type        = "ssh"
      host        = var.node_public_ip
      user        = var.node_username
      private_key = var.ssh_private_key_pem
    }
  }
}

resource "null_resource" "deploy_portainer_config" {
  depends_on = [
    ssh_resource.k3s_installation_complete
  ]
  triggers = {
    policy_sha1 = "${sha1(file(local.portainer_template))}"
  }
  provisioner "file" {
    content = templatefile(local.portainer_template, {
      domain      = var.domain
    })

    destination = "/var/lib/rancher/k3s/server/manifests/portainer-config.yaml"
    
    connection {
      type        = "ssh"
      host        = var.node_public_ip
      user        = var.node_username
      private_key = var.ssh_private_key_pem
    }
  }
}

resource "null_resource" "deploy_traefik_config" {
  depends_on = [
    ssh_resource.k3s_installation_complete
  ]
  triggers = {
    policy_sha1 = "${sha1(file(local.traefik_template))}"
  }
  provisioner "file" {
    content = templatefile(local.traefik_template, {
      auth_secret = var.admin_password
      domain      = var.domain
    })

    destination = "/var/lib/rancher/k3s/server/manifests/traefik-config.yaml"
    
    connection {
      type        = "ssh"
      host        = var.node_public_ip
      user        = var.node_username
      private_key = var.ssh_private_key_pem
    }
  }
}
