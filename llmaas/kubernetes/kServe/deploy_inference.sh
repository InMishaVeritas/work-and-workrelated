#!/bin/bash
set -e

kubectl create namespace kserve-test
kubectl apply -n kserve-test -f pvc_cache.yaml
kubectl apply -n kserve-test -f secret.yaml
kubectl apply -n kserve-test -f inference_test_cpu.yaml