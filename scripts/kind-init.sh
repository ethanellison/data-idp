#!/bin/bash
set -euo pipefail

CLUSTER_NAME="data-idp-dev"
K8S_VERSION="1.27" # Use a stable, recent version

echo "Starting kind cluster: ${CLUSTER_NAME} (Kubernetes v${K8S_VERSION})"

# 1. Create kind cluster
kind create cluster --name "${CLUSTER_NAME}" --image "kindest/node:v${K8S_VERSION}"

echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready node/${CLUSTER_NAME}-control-plane --timeout=300s

echo "Installing ArgoCD..."
# 2. Install ArgoCD
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD to be ready..."
kubectl wait --for=condition=Available deployment/argocd-server -n argocd --timeout=300s

echo "ArgoCD is installed. To get the initial admin password, run:"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
echo "To forward the ArgoCD UI, run: kubectl port-forward svc/argocd-server -n argocd 8080:443"

echo "Applying the Backstage ArgoCD Application definition..."
# 3. Apply the Backstage Application definition
# NOTE: This assumes the current repository is the source of truth (GitOps repo)
# You will need to configure ArgoCD to trust this repository first.
kubectl apply -f apps/backstage.yaml

echo "Local development environment setup complete."
echo "Run 'k9s' to view the cluster dashboard."
