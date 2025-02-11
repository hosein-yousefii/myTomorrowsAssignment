# Helm Release Deployment
resource "helm_release" "application" {
  name             = var.release_name
  repository       = var.oci_registry
  chart            = var.chart_name
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.create_namespace
  lint             = var.lint
  upgrade_install  = var.upgrade_install

  values = var.values
}

