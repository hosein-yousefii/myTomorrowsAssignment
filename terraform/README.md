# Terraform-deployment
**Please do not consider it as final approach, there is always room to make it better**
Use this repository to deploy your application in k8s.
one module is provided to deploy helm releases into k8s.
There are dev, test and prod environments and for each application variables could be different.
environments are separated using Terraform workspaces and by changing workspaces, terraform also read the related variables for each present application. In order not to implement an unwanted application, it's possible to disable application from tfvar file, but disabling means also removing if it's implemented.
If you want to deploy a specific application follow -target option.

on each stage there is a env-common.tfvar which is responsible to hold common variables for all applications. The logic because of the time is not implemented.

with this Terraform module it's also possible to change any variable in values.yaml of application. **So Helm centralization is possible.**

## Usage
add your applications like the existing one and run terraform plan and apply.
This is the structure of terraform:
applications/
└── environments
    ├── common.tfvars
    ├── dev
    │   ├── dev-common.tfvars
    │   ├── flask-auth-app
    │   │   └── terraform.tfvars
    │   ├── flask-config-app
    │   │   └── terraform.tfvars
    │   └── flask-stream-app
    │       └── terraform.tfvars
    ├── prod
    │   ├── flask-auth-app
    │   │   └── terraform.tfvars
    │   ├── flask-config-app
    │   │   └── terraform.tfvars
    │   ├── flask-stream-app
    │   │   └── terraform.tfvars
    │   └── prod-common.tfvars
    └── test

The output is similar to:
applications = {
  "flask-config-app" = {
    "cluster" = "dev"
    "namespace" = "default"
    "version" = "1.1.0"
  }
}

Depending on the company, number of applications, time to deliver and CICD pipelines this approach can be changed.

~                 
