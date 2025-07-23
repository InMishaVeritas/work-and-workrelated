# Déploiement de kong

Le déploiement de kong se fait par chart helm.
1) Ajout des CRDs kong
```
kubectl apply -f charts/charts/kong/crds/
```
2) Ajout et déploiement du controller
```
helm repo add kong https://charts.konghq.com
helm repo update
helm install kong kong/kong --set ingressController.installCRDs=false
```
3) Deployer les ressources k8s avec le script bash
```
./deploy_kong.sh
```