1) Installation de l'Ingress Controller Nginx:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.1/deploy/static/provider/kind/deploy.yaml
```

2) Editer la configmap déployée pour insérer la gestion de clefs API
```
kubectl edit -n ingress-nginx configmap ingress-nginx-controller
```
et mettre la config suivante:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-ingress-controller
  namespace: ingress-nginx
data:
  allow-snippet-annotations: "true"
  annotations-risk-level: "Critical"   # Ajoute cette ligne
  http-snippet: |
    map $http_apikey $api_key_owner {
      default "";
      "key_A" "key_owner_A";
      "key_B" "key_owner_B";
    }
```

On oublie pas de redémarrer l'ingress controller pour appliquer le changement de la nouvelle configmap

```
kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
```

3) Port forward le controller:
```
kubectl port-forward -n ingress-nginx pod/ingress-nginx-controller-5c74fc5fb8-6tt45 8080:80
```

4) Dans /etc/hosts ajouter:
```
127.0.0.1   llama.demo.cluster
```

5) Test avec:
```
curl -X POST http://localhost:8080/v1/chat/completions \
  -H "Host: llama.demo.cluster" \
  -H "apikey: key_A" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {
        "role": "user",
        "content": "Bonjour, Llama ! "
      }
    ],
    "max_tokens": 100
  }'
```