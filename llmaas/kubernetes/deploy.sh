#!/bin/bash

set -e

echo "=== LLMaaS Deployment Script (Kubernetes Native) ==="
echo "This script will deploy a Kind cluster with Run-AI and KServe for vLLM"

# Check prerequisites
echo "Checking prerequisites..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check kubectl
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed. Please install kubectl and try again."
    exit 1
fi

# Check Helm
if ! command -v helm &> /dev/null; then
    echo "Error: Helm is not installed. Please install Helm and try again."
    exit 1
fi

# Check Kind
if ! command -v kind &> /dev/null; then
    echo "Error: kind is not installed. Please install kind and try again."
    echo "You can install kind using: "
    echo "  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64"
    echo "  chmod +x ./kind"
    echo "  sudo mv ./kind /usr/local/bin/kind"
    exit 1
fi

echo "All prerequisites are met."

# Create Kind cluster
echo "Creating Kind cluster..."
cd kind
./create-cluster.sh
cd ..

# Install Run-AI
# echo "Installing Run-AI..."
# cd runai
# ./install-runai.sh
# cd ..

# TODO: Add KServe installation
echo "KServe installation will be added in a future update."

echo ""
echo "=== Deployment Summary ==="
echo "Run-AI Dashboard: http://localhost/runai-ui"
echo ""
echo "Note: It may take some time for all components to be fully ready."
echo "Use 'kubectl get pods -A' to check the status of all pods."
echo ""
echo "Deployment completed!"