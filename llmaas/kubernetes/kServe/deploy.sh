#!/bin/bash

set -e

# 1. Installer Knative Serving
echo "Installation de Knative Serving..."
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.15.0/serving-core.yaml

# # 2. Installer Istio
echo "Téléchargement et installation d'Istio..."
ISTIO_VERSION=1.22.8
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$ISTIO_VERSION sh -
cd istio-$ISTIO_VERSION
export PATH=$PWD/bin:$PATH

echo "Déploiement d'Istio sur le cluster..."
istioctl install -y

# 3. Installer Cert Manager (optionnel mais recommandé pour la prod)
echo "Installation de Cert Manager..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml


# 4. Installer KServe
echo "Installation de KServe..."
kubectl apply -f https://github.com/kserve/kserve/releases/download/v0.11.2/kserve.yaml

echo "Installation terminée !"
