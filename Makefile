.DEFAULT_GOAL := help
cluster_name = kind-istio

## cluster: cluster creates a new Kind cluster 
cluster:
	kind create cluster --config setup-kind/kind_config.yaml --name $(cluster_name)

## destroy: destroy the cluster
destroy:
	kind delete cluster --name $(cluster_name)

## deploy: deploy the microservices App
deploy:
	skaffold run

## port_forward: port_forward forwards the port 8080 to deployment/frontend 
port_forward:
	kubectl port-forward deployment/frontend 8080:8080

## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'