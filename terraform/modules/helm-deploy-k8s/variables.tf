variable "chart_name" {
  description = "The name of the Helm chart"
  type        = string
}

variable "chart_version" {
  description = "The version of the Helm chart to deploy"
  type        = string
}

variable "oci_registry" {
  description = "OCI registry URL"
  type        = string
}

variable "namespace" {
  description = "Namespace where the application will be deployed"
  type        = string
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
}

variable "release_name" {
  description = "Helm release name"
  type        = string
}

variable "lint" {
  description = "lint helm before install"
  type        = bool
}

variable "upgrade_install" {
  description = "install the release at the specified version even if a release not controlled by the provider is present: this is equivalent to running 'helm upgrade --install'"
  type        = bool
}

variable "values" {
  description = "Override values for the Helm chart"
  type        = list(string)
}
