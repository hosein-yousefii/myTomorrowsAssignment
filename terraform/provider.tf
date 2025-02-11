provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
  #registry {
  #    url      = "oci://ghcr.io"
  #    username = "hosein-yousefii"
  #    password = "notneeded"
  #  }
}

