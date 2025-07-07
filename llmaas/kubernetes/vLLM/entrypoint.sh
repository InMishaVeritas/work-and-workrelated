#!/bin/bash
set -e

# Télécharger le modèle depuis Artifactory (HuggingFaceML)
python3 -c "
from huggingface_hub import snapshot_download
snapshot_download(repo_id='llm', local_dir='/model', resume_download=True)
"

# Lancer vLLM avec le modèle téléchargé
exec python3 -m vllm.entrypoints.api_server --host 0.0.0.0 --port 8000 --model /model
