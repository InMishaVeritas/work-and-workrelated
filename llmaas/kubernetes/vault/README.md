1) Installer la chart Helm:
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
```

2) Déployer Hashicorp Vault
```
helm install vault hashicorp/vault
```

3) Préparer le vault
```
kubectl exec -it vault-0 -- vault operator init
kubectl exec -it vault-0 -- vault operator unseal <clé_unseal_1>
kubectl exec -it vault-0 -- vault operator unseal <clé_unseal_2>
kubectl exec -it vault-0 -- vault operator unseal <clé_unseal_3>
```

