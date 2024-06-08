kind get clusters | grep tekton
if [ $? == 0 ]; then
	kind delete clusters tekton
fi

kind create cluster --name tekton

kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename \
https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

python3 wait-for-install.py \
	tekton-pipelines-controller \
	tekton-pipelines-webhook \
	tekton-triggers-controller \
	tekton-triggers-webhook \
	tekton-triggers-core-interceptors

kubectl create namespace getting-started

alias apply="kubectl apply -n getting-started"
alias create="kubectl create -n getting-started"
