# Outputs

output "k3s_url" {
  value = "https://${var.k3s_server_dns}"
}
