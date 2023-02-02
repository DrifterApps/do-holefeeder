# Helm provider
provider "helm" {
  kubernetes {
    config_path = local_file.kube_config_server_yaml.filename
  }
}
