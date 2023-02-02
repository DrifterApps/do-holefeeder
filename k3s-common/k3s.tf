# K3s cluster
resource "ssh_resource" "install_k3s" {
  host = var.node_public_ip
  commands = [
    "bash -c 'curl https://get.k3s.io | INSTALL_K3S_EXEC=\"server --node-external-ip ${var.node_public_ip} --node-ip ${var.node_internal_ip}\" INSTALL_K3S_VERSION=${var.k3s_kubernetes_version} sh -'"
  ]
  user        = var.node_username
  private_key = var.ssh_private_key_pem
}

resource "ssh_resource" "k3s_installation_complete" {
  depends_on = [
    ssh_resource.install_k3s
  ]
  host = var.node_public_ip
  commands = [
    "until systemctl status k3s | grep 'Active: active (running)'; do echo 'Waiting for k3s service to start...'; sleep 2; done"
  ]
  user        = var.node_username
  private_key = var.ssh_private_key_pem
}

resource "ssh_resource" "retrieve_config" {
  depends_on = [
    ssh_resource.k3s_installation_complete
  ]
  host = var.node_public_ip
  commands = [
    "sudo sed \"s/127.0.0.1/${var.node_public_ip}/g\" /etc/rancher/k3s/k3s.yaml"
  ]
  user        = var.node_username
  private_key = var.ssh_private_key_pem
}
