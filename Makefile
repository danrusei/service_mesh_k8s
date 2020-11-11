.DEFAULT_GOAL := help
cluster_name = kind-istio

## cluster: cluster creates a new Kind cluster 
cluster:
	kind create cluster --config setup-kind/kind_config.yaml --name $(cluster_name)

## destroy: destroy the cluster
destroy:
	kind delete cluster --name $(cluster_name)

## istio_install: install Istio Service Mesh (demo profile)
istio_install:
	./istio-1.7.4/bin/istioctl install --set profile=demo

## istio_prepare: labels default namespace with istio-injection=enabled 
istio_prepare:
	kubectl label namespace default istio-injection=enabled	

## istio_integrations: prometheus and grafana custom instalation, maintained by Istio 
istio_prepare:
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml

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