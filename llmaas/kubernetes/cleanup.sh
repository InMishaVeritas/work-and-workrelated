#!/bin/bash

set -e

echo "=== Cleaning up LLMaaS resources ==="

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    echo "Error: kind is not installed. Please install kind and try again."
    exit 1
fi

# Delete the Kind cluster
echo "Deleting Kind cluster 'llmaas'..."
kind delete cluster --name llmaas

echo "Cleanup completed!"