# Prometheus
1) Installation de prometheus via helm:
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
```
2) Deployer les CRD prometheus:
```
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml
```
3) Deployer un service monitor prometheus:
```
kubectl apply -f service_monitor.yaml
```

4) Port forward:
```
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring
```

# Grafana
1) Installation de grafana via Helm:
```
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install grafana grafana/grafana --namespace monitoring
```

2) Port forward grafana:
```
kubectl port-forward svc/grafana 3000:80 -n monitoring
```