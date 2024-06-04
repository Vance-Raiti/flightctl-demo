kind create cluster --name tekton

alias add-file="kubectl apply --filename"

add-file https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
add-file https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
add-file https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

python wait-for-install.py \
	tekton-pipelines-controller \
	tekton-pipelines-webhook \
	tekton-triggers-controller \
	tekton-triggers-webhook \
	tekton-triggers-core-interceptors \
	tekton-events-controller 

add-file yaml/hello-world.yaml
add-file yaml/hello-world-run.yaml
add-file yaml/goodbye-world.yaml

add-file yaml/hello-goodbye-pipeline.yaml
add-file yaml/hello-goodbye-pipeline-run.yaml

add-file yaml/trigger-template.yaml
add-file yaml/trigger-binding.yaml
add-file yaml/rbac.yaml
add-file yaml/event-listener.yaml

kubectl port-forward service/el-hello-listener 8080
