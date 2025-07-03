#!/bin/bash

set -e

echo "=== Creating Kind Cluster ==="

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    echo "Error: kind is not installed. Please install kind and try again."
    echo "You can install kind using: "
    echo "  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64"
    echo "  chmod +x ./kind"
    echo "  sudo mv ./kind /usr/local/bin/kind"
    exit 1
fi

# Create the cluster
echo "Creating Kind cluster 'llmaas'..."
kind create cluster --config=cluster-config.yaml

# Check if the cluster was created successfully
if ! kind get clusters | grep -q "llmaas"; then
    echo "Error: Failed to create Kind cluster."
    exit 1
fi

echo "Kind cluster 'llmaas' created successfully!"
echo "Kubeconfig is updated. You can use 'kubectl' to interact with the cluster."