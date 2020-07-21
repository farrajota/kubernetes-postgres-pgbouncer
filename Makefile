K8S_NAMESPACE=database

start:
	minikube start

stop:
	minikube stop

deploy:
	@echo "Create resources in namespace '${K8S_NAMESPACE}'"
	kubectl kustomize > deploy.yaml
	kubectl create -f deploy.yaml
	@echo "Resources created!"

destroy:
	@echo "Destroy everything in namespace '${K8S_NAMESPACE}'"
	kubectl delete -f deploy.yaml
	rm deploy.yaml
	@echo "Resources deleted."