#!/bin/bash
set -e

NAMESPACE="kserve-test"

echo "Suppression du namespace $NAMESPACE (toutes les ressources associées seront supprimées)..."
kubectl delete namespace "$NAMESPACE"

echo "Vérification de la suppression du namespace..."
while kubectl get namespace "$NAMESPACE" &> /dev/null; do
  echo "En attente de la suppression complète du namespace..."
  sleep 3
done

echo "Namespace $NAMESPACE supprimé avec succès."
