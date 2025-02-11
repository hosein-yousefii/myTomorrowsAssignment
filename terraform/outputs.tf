output "applications" {
  description = "Structured output of all deployed Helm releases"
  value = { for app, instance in module.helm_deploy_k8s :
    app => {
      cluster   = instance.application_cluster
      namespace = instance.application_namespace
      version   = instance.application_version
    }
  }
}

