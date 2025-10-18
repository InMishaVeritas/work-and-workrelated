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



curl -v http://llama-3-2-1b-instruct-predictor-00001-private.kserve-test.svc.cluster.local:8081/


```
curl -X  POST -v http://llama-3-2-1b-instruct-predictor-00001.kserve-test.svc.cluster.local:80/v1/chat/completions \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJmYWJWQUhZa0tBUkdKamZlWjZ4NGNkbElQbnE1aDJxb2tqOXcyMWxJUmF3In0.eyJleHAiOjE3NTM0ODk0MTUsImlhdCI6MTc1MzQ1MzQxNSwianRpIjoidHJydGNjOjY3OGNlZDY1LWJhMDAtYjZmMi1mZDM4LTkxMjViNGRiMWFmNyIsImlzcyI6Imh0dHA6Ly9rZXljbG9hay5sb2NhbC9yZWFsbXMvYXBpLWluZmVyZW5jZSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIwNjBkOWQ5MC1hYjhiLTQ2YjMtYmE5OC01ZGUxZjY5MzRlYTYiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJrc2VydmUtYXBpLWNsaWVudCIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1hcGktaW5mZXJlbmNlIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImNsaWVudEhvc3QiOiIxMjcuMC4wLjEiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInByZWZlcnJlZF91c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1rc2VydmUtYXBpLWNsaWVudCIsImNsaWVudEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJjbGllbnRfaWQiOiJrc2VydmUtYXBpLWNsaWVudCJ9.lMEngEKzc1X9vjIcUwZ4IrakjbuWUhE9sG2s9YSOYkQ-XbdSxWKpuAInymV74LQn0Z5eYKrvGXd0EtTe67kKKyHnvCc2oIJ6zc8L6ZwtkLsoYsIoZUK5HKCJKKs4QrPkmmcFWOERDBlNqwrN7OHXf2qELM0hCq-G3Z-xo-HAu1jIvrhJzT8JA8Aq3VSy6QIk8Ww9uS_fv_ZJlgiXygZG0OGpLQNXG5bw7EokiLv878oo15X8F_GmdWaxTxEeEusHdvg7FvZv49ApxCAuNt4LHlKuzYU0vIRdXSTfLXftJEhnrbhaPJYv5UPu1X6Z1ZVvjOMZSm9Vm0AtV244NsvVrQ" \
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


eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJmYWJWQUhZa0tBUkdKamZlWjZ4NGNkbElQbnE1aDJxb2tqOXcyMWxJUmF3In0.eyJleHAiOjE3NTM0ODk0MTUsImlhdCI6MTc1MzQ1MzQxNSwianRpIjoidHJydGNjOjY3OGNlZDY1LWJhMDAtYjZmMi1mZDM4LTkxMjViNGRiMWFmNyIsImlzcyI6Imh0dHA6Ly9rZXljbG9hay5sb2NhbC9yZWFsbXMvYXBpLWluZmVyZW5jZSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIwNjBkOWQ5MC1hYjhiLTQ2YjMtYmE5OC01ZGUxZjY5MzRlYTYiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJrc2VydmUtYXBpLWNsaWVudCIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1hcGktaW5mZXJlbmNlIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImNsaWVudEhvc3QiOiIxMjcuMC4wLjEiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInByZWZlcnJlZF91c2VybmFtZSI6InNlcnZpY2UtYWNjb3VudC1rc2VydmUtYXBpLWNsaWVudCIsImNsaWVudEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJjbGllbnRfaWQiOiJrc2VydmUtYXBpLWNsaWVudCJ9.lMEngEKzc1X9vjIcUwZ4IrakjbuWUhE9sG2s9YSOYkQ-XbdSxWKpuAInymV74LQn0Z5eYKrvGXd0EtTe67kKKyHnvCc2oIJ6zc8L6ZwtkLsoYsIoZUK5HKCJKKs4QrPkmmcFWOERDBlNqwrN7OHXf2qELM0hCq-G3Z-xo-HAu1jIvrhJzT8JA8Aq3VSy6QIk8Ww9uS_fv_ZJlgiXygZG0OGpLQNXG5bw7EokiLv878oo15X8F_GmdWaxTxEeEusHdvg7FvZv49ApxCAuNt4LHlKuzYU0vIRdXSTfLXftJEhnrbhaPJYv5UPu1X6Z1ZVvjOMZSm9Vm0AtV244NsvVrQ