output "application_name" {
  description = "Name of the deployed Helm release"
  value       = helm_release.application.name
}

output "application_version" {
  description = "version of the helm release"
  value       = helm_release.application.version
}

output "application_cluster" {
  description = "cluster of the helm release"
  value = terraform.workspace
}

output "application_namespace" {
  description = "namespace of the helm release"
  value = helm_release.application.namespace
}
