#!/bin/bash
set -e

NAMESPACE="kserve-test"

echo "Création du namespace $NAMESPACE (toutes les ressources d'inférences seront déployées dedans)..."
kubectl create namespace "$NAMESPACE"
kubectl apply -f secret.yaml -n "$NAMESPACE"
kubectl apply -f inference_test_cpu.yaml -n "$NAMESPACE"