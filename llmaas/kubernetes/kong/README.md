# Déploiement de kong

Le déploiement de kong se fait par chart helm.
1) Ajout et déploiement du controller
```
helm repo add kong https://charts.konghq.com
helm repo update
helm install kong kong/kong -n kong --create-namespace --version 2.47.0 --set proxy.type=NodePort
```
2) Récupérer le nodeport:
```
kubectl get svc -n kong 
NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
kong-kong-manager              NodePort    10.96.103.199   <none>        8002:30943/TCP,8445:31393/TCP   52s
kong-kong-metrics              ClusterIP   10.96.193.2     <none>        10255/TCP,10254/TCP             52s
kong-kong-proxy                NodePort    10.96.48.201    <none>        80:30829/TCP,443:32302/TCP      52s
kong-kong-validation-webhook   ClusterIP   10.96.178.201   <none>        443/TCP                         52s
```
(ici 30829)

3) Récupérer le node ip
```
kubectl get nodes -o wide
NAME                   STATUS   ROLES           AGE    VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION     CONTAINER-RUNTIME
llmaas-control-plane   Ready    control-plane   176m   v1.32.0   172.18.0.4    <none>        Debian GNU/Linux 12 (bookworm)   6.8.0-57-generic   containerd://1.7.24
llmaas-worker          Ready    <none>          176m   v1.32.0   172.18.0.3    <none>        Debian GNU/Linux 12 (bookworm)   6.8.0-57-generic   containerd://1.7.24
llmaas-worker2         Ready    <none>          176m   v1.32.0   172.18.0.2    <none>        Debian GNU/Linux 12 (bookworm)   6.8.0-57-generic   containerd://1.7.24
llmaas-worker3         Ready    <none>          176m   v1.32.0   172.18.0.5    <none>        Debian GNU/Linux 12 (bookworm)   6.8.0-57-generic   containerd://1.7.24
```
Toutes les ips hors control plane fonctionnent

On se servira de tout ça pour envoyer nos requettes curl nodeIP:NodePort (ex 172.18.0.2:30829)
3) Deployer les ressources k8s avec le script bash
```
./deploy_kong.sh
```