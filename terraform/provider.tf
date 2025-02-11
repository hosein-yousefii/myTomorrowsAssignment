provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  #registry {
  #    url      = "oci://ghcr.io"
  #    username = "hosein-yousefii"
  #    password = "notneeded"
  #  }
}

