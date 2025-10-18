#!/bin/bash
set -e

kubectl apply -n kserve-test -f secret.yaml
kubectl apply -n kserve-test -f key-auth.yaml
kubectl apply -n kserve-test -f consummer.yaml
kubectl apply -n kserve-test -f ingress.yaml

# kubectl apply -f secret.yaml
# kubectl apply -f key-auth.yaml
# kubectl apply -f consummer.yaml
# kubectl apply -f ingress.yaml