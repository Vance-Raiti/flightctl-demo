kind create cluster --name tekton

kubectl apply --filename \
	https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply --filename \
	https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
	https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

python wait-for-install.py

kubectl apply --filename yaml/hello-world.yaml
kubectl apply --filename yaml/hello-world-run.yaml
kubectl apply --filename yaml/goodbye-world.yaml
kubectl apply --filename yaml/hello-goodbye-pipeline.yaml
kubectl apply --filename yaml/hello-goodbye-pipeline-run.yaml
kubectl apply --filename yaml/trigger-template.yaml

tkn pipelinerun logs hello-goodbye-run -f -n default
