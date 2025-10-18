1) Installer la chart Helm:
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
```

2) Déployer Hashicorp Vault
```
helm install vault hashicorp/vault -n vault --create-namespace 
```

3) Préparer le vault
```
kubectl -n vault exec -it vault-0 -- vault operator init
kubectl -n vault exec -it vault-0 -- vault operator unseal <clé_unseal_1>
kubectl -n vault exec -it vault-0 -- vault operator unseal <clé_unseal_2>
kubectl -n vault exec -it vault-0 -- vault operator unseal <clé_unseal_3>
```