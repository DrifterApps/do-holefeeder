# Helm resources

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  repository       = "https://charts.jetstack.io"
  name             = "cert-manager"
  chart            = "cert-manager"
  version          = "v${var.cert_manager_version}"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

# Install portainer helm chart
resource "helm_release" "portainer" {
  repository       = "https://portainer.github.io/k8s/"
  name             = "portainer"
  chart            = "portainer"
  version          = "v${var.portainer_version}"
  namespace        = "portainer"
  create_namespace = true
  wait             = true

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  # set {
  #   name  = "tls.force"
  #   value = "true"
  # }
}
