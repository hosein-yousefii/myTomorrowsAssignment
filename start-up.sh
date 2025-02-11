#!/bin/bash

read -p "I suggest running this script on a VM without any important data. Do YOU want to CONTINUE? (yes/no): " choice

if [[ "$choice" != "yes" ]]; then
    echo "Aborting script."
    exit 1
fi

./minikube/setup.sh
if [[ $? -ne 0 ]]; then
    echo "Minikube setup failed. Exiting."
    exit 1
fi

cd terraform || { echo "Failed to change directory to terraform."; exit 1; }
terraform workspace new dev
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
if [[ $? -ne 0 ]]; then
    echo "Terraform deployment failed. Exiting."
    exit 1
fi

# Add Load Balancer IP to VM's /etc/hosts
LB_IP="192.168.56.160"
DOMAIN="flask-config-app.dev.mytomorrows.com"
echo "$LB_IP $DOMAIN" | sudo tee -a /etc/hosts

echo "Updated /etc/hosts with Load Balancer IP."

# Try to resolve the application path
curl $DOMAIN/config
