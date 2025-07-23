#!/bin/bash
set -e

kubectl delete -n kserve-test -f secret.yaml
kubectl delete -n kserve-test -f key-auth.yaml
kubectl delete -n kserve-test -f consummer.yaml
kubectl delete -n kserve-test -f ingress.yaml

# kubectl delete  -f secret.yaml
# kubectl delete  -f key-auth.yaml
# kubectl delete  -f consummer.yaml
# kubectl delete  -f ingress.yaml