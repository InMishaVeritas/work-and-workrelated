# LLMaaS Server with Kind, Run-AI, and KServe

This project sets up a local Kubernetes environment using Kind (Kubernetes in Docker) with Run-AI for AI workload orchestration and KServe for serving large language models (LLMs) using vLLM.

## Architecture

The project deploys:

1. **Kind Cluster**: A local Kubernetes cluster with one control-plane node and three worker nodes
2. **Run-AI**: AI workload orchestration platform for managing GPU resources
3. **KServe**: Serverless inference platform for machine learning models
4. **vLLM**: High-performance inference engine for LLMs

## Prerequisites

- Docker installed and running
- kubectl
- Helm
- At least 16GB RAM available
- (Optional) NVIDIA GPU with appropriate drivers for hardware acceleration

## Installation

### Option 1: Automated Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd llmaas
   ```

2. Run the deployment script:
   ```bash
   cd kubernetes
   ./deploy.sh
   cd ..
   ```

### Option 2: Manual Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd llmaas
   ```

2. Create a Kind cluster:
   ```bash
   cd kubernetes/kind
   ./create-cluster.sh
   cd ../..
   ```

3. Install Run-AI:
   ```bash
   cd kubernetes/runai
   ./install-runai.sh
   cd ../..
   ```

4. Install KServe:
   ```bash
   # TODO: Add KServe installation command
   ```

The deployment will:
- Create a Kind cluster
- Install Run-AI
- Install KServe with vLLM support (coming soon)
- Deploy a sample LLM (Llama-2-7b-chat) (coming soon)

The deployment may take 15-20 minutes to complete. Once finished, you'll have access to:
- The Run-AI dashboard URL: http://localhost/runai-ui
- The KServe gateway URL for the sample model (coming soon)

## Usage

### Accessing the Run-AI Dashboard

The Run-AI dashboard is available at: http://localhost/runai-ui

Default credentials:
- Username: admin
- Password: admin123 (change this in production)

### Deploying a Custom LLM

To deploy your own LLM using vLLM and KServe, create an InferenceService manifest:

```yaml
apiVersion: serving.kserve.io/v1beta1
kind: InferenceService
metadata:
  name: my-custom-llm
  namespace: kserve
spec:
  predictor:
    model:
      modelFormat:
        name: huggingface
      runtime: vllm-runtime
      storageUri: "gs://your-bucket/your-model-path"
      resources:
        limits:
          cpu: "4"
          memory: 8Gi
          nvidia.com/gpu: "1"
        requests:
          cpu: "1"
          memory: 4Gi
          nvidia.com/gpu: "1"
```

Apply the manifest:
```bash
kubectl apply -f your-model.yaml
```

### Testing the LLM

You can test the deployed LLM using curl:

```bash
curl -X POST http://localhost/v1/models/llm-sample:predict \
  -H "Content-Type: application/json" \
  -d '{"instances": [{"prompt": "Hello, how are you?"}]}'
```

## Troubleshooting

### Common Issues

1. **Resource Constraints**: If you encounter resource issues, adjust the resource limits in the Terraform files.

2. **GPU Support**: If you don't have a GPU, modify the vLLM configuration to run in CPU mode by removing the GPU resource requirements.

3. **Port Conflicts**: If ports 80 or 443 are already in use, modify the port mappings in `main.tf`.

4. **Timeout Errors**: Increase the timeout values in the Helm releases if installation times out.

### Logs and Debugging

To check the status of the deployments:
```bash
kubectl get pods -A
```

To view logs for a specific component:
```bash
kubectl logs -n <namespace> <pod-name>
```

## Cleanup

To delete all resources:
```bash
# Using the cleanup script
cd kubernetes
./cleanup.sh
cd ..

# Or manually
kind delete cluster --name llmaas
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
