locals {
  env       = terraform.workspace
  all_items = fileset("${path.module}/applications/environments/${local.env}/", "*/terraform.tfvars")
  app_dirs  = toset([for file in local.all_items : regex("([^/]+)/terraform.tfvars$", file)[0]])

  all_apps = { for app in local.app_dirs :
    app => yamldecode(file("${path.module}/applications/environments/${local.env}/${app}/terraform.tfvars"))
  }

  apps = { for k, v in local.all_apps : k => v if lookup(v, "enabled", true) }
}

