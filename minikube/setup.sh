#!/bin/bash

set -e
set -o pipefail

MINIKUBE_STATIC_IP="192.168.56.156"
METALLB_IP_RANGE="192.168.56.160-192.168.56.161"

install_minikube() {
    echo "Installing Minikube..."

    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm -f minikube-linux-amd64

    echo "Starting Minikube with static IP: $MINIKUBE_STATIC_IP..."
    minikube start --driver=docker --addons=ingress --addons=metallb --static-ip=$MINIKUBE_STATIC_IP --force
    minikube ip

    echo "Applying MetalLB configuration..."
    minikube kubectl -- apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $METALLB_IP_RANGE
EOF

    echo "Patching Ingress Controller to use LoadBalancer..."
    minikube kubectl -- patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec":{"type":"LoadBalancer"}}'

    echo "Setting NGINX IngressClass as default..."
    minikube kubectl -- patch ingressclass nginx -p '{"metadata":{"annotations":{"ingressclass.kubernetes.io/is-default-class":"true"}}}'

    echo "Saving kubeconfig..."
    minikube kubectl -- config view > kubeconfig

    # Alias kubectl for Minikube
    echo "Setting up kubectl alias..."
    echo "alias kubectl='minikube kubectl --'"

    echo "✅ Minikube installation completed successfully!"
}

remove_minikube() {
    echo "Stopping and deleting Minikube..."
    minikube stop || true
    minikube delete || true

    echo "Removing Minikube binary and data..."
    sudo rm -f /usr/local/bin/minikube
    rm -rf ~/.minikube ~/.kube

    rm -rf minikube/kubeconfig || true
    rm -rf kubeconfig || true
    echo "✅ Minikube removed successfully!"
}

# Display menu
echo "========================="
echo " Minikube Manager Script "
echo "========================="
echo "1) Install Minikube"
echo "2) Remove Minikube"
echo "3) Exit"
echo -n "Select an option [1-3]: "
read OPTION

case $OPTION in
    1)
        install_minikube
        ;;
    2)
        remove_minikube
        ;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Please enter 1, 2, or 3."
        exit 1
        ;;
esac

