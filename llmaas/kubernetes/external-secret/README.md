1) Installer ESO:
```
helm repo add external-secrets https://charts.external-secrets.io
helm repo update
helm install external-secrets external-secrets/external-secrets \
  -n external-secrets --create-namespace --set installCRDs=true
```

2) Ajouter le token hashicorp requis pour utiliser vault dans le manifest secret.yaml et lacher un big apply:
```
kubectl apply -f vault-token-secret.yaml
```

3) Ajuste le cluster secret store puis apply:
