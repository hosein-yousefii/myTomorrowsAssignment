module "helm_deploy_k8s" {
  for_each         = local.apps
  source           = "./modules/helm-deploy-k8s"
  chart_name       = lookup(each.value, "chart_name", "")
  chart_version    = lookup(each.value, "chart_version", "")
  oci_registry     = lookup(each.value, "oci_registry", "oci://ghcr.io/hosein-yousefii/mytomorrows/charts")
  release_name     = lookup(each.value, "release_name", "")
  namespace        = lookup(each.value, "namespace", "")
  create_namespace = lookup(each.value, "create_namespace", "true")
  lint             = lookup(each.value, "lint", "true")
  upgrade_install  = lookup(each.value, "upgrade_install", "true")
  values           = lookup(each.value, "values", {})
}
