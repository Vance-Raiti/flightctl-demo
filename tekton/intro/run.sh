
kind get clusters | grep tekton
if [ $? == 1 ]; then
	kind create cluster --name tekton
fi

# Tasks and Pipelines
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Triggers
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

python wait-for-install.py \
	tekton-pipelines-controller \
	tekton-pipelines-webhook \
	tekton-triggers-controller \
	tekton-triggers-webhook \
	tekton-triggers-core-interceptors

kubectl apply --filename yaml/hello-world.yaml
kubectl apply --filename yaml/goodbye-world.yaml
kubectl apply --filename yaml/hello-goodbye-pipeline.yaml
kubectl apply --filename yaml/hello-goodbye-run.yaml


tkn pipelinerun logs hello-goodbye-run -f -n default
