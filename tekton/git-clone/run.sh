#!/bin/bash

alias apply-file="kubectl apply -f"

kind create cluster --name tekton

apply-file https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

python wait-for-install.py tekton-events-controller tekton-pipelines-controller tekton-pipelines-webhook 

apply-file https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.6/git-clone.yaml

apply-file show-readme.yaml
apply-file pipeline.yaml

kubectl create --filename pipelinerun.yaml

echo "now run \`tkn pipelinerun logs clone-read-run-TAG -f\`"
