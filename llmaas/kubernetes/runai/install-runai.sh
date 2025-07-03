#!/bin/bash

set -e

echo "=== Installing Run-AI ==="

# Create namespace
echo "Creating Run-AI namespace..."
kubectl apply -f namespace.yaml

# Create storage class
echo "Creating standard storage class..."
kubectl apply -f storageclass.yaml

# Add Run-AI Helm repository
echo "Adding Run-AI Helm repository..."
helm repo add runai https://run-ai-charts.storage.googleapis.com
helm repo update

# Install Run-AI using Helm
echo "Installing Run-AI using Helm (this may take some time)..."
helm install runai-repo runai/runai-cluster \
  --namespace runai \
  --version 2.9.0 \
  --values values.yaml \
  --timeout 20m

echo "Run-AI installation completed!"
echo "Run-AI Dashboard URL: http://localhost/runai-ui"