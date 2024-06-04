curl -v \
	-H 'content-Type: application/json' \
	-d '{"username": "Tekton"}' \
	http://localhost:8080

kubectl get pipelineruns
