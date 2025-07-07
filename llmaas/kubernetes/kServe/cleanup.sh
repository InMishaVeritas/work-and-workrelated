#!/bin/bash

set -e

echo "Suppression de KServe..."
kubectl delete -f https://github.com/kserve/kserve/releases/download/v0.11.2/kserve.yaml --ignore-not-found

echo "Suppression de Cert Manager..."
kubectl delete -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml --ignore-not-found

echo "Suppression de Knative Serving..."
kubectl delete -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-core.yaml --ignore-not-found
kubectl delete -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-crds.yaml --ignore-not-found

echo "Suppression d'Istio (via istioctl)..."
if command -v istioctl &> /dev/null; then
  istioctl uninstall --purge -y || true
else
  echo "istioctl non trouvé, suppression manuelle du namespace istio-system"
  kubectl delete ns istio-system --ignore-not-found
fi

echo "Suppression des namespaces résiduels (si existants)..."
kubectl delete ns knative-serving --ignore-not-found
kubectl delete ns cert-manager --ignore-not-found
kubectl delete ns istio-system --ignore-not-found

echo "Nettoyage terminé !"
