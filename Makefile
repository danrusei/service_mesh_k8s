.DEFAULT_GOAL := help
cluster_name = kind-istio

## cluster: creates a new Kind cluster (3 nodes - 1 controller plane and 2 workers) 
cluster:
	kind create cluster --config setup-kind/kind_config.yaml --name $(cluster_name)

## destroy: destroy the Kind cluster
destroy:
	kind delete cluster --name $(cluster_name)

## istio_install: installs Istio Service Mesh (demo profile)
# global.proxy.privileged is set to TRUE so I can use tcpdump to verify if traffic is encrypted or not.
istio_install:
	./istio-1.7.4/bin/istioctl install --set profile=demo --set values.global.proxy.privileged=true

## istio_prepare: labels the default namespace with istio-injection=enabled 
istio_prepare:
	kubectl label namespace default istio-injection=enabled	

## istio_integrations: installs prometheus and grafana, Istio custom instalation 
istio_integrations:
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml
	# kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.8/samples/addons/kiali.yaml

## deploy: deploy the microservices App
deploy:
	skaffold run

## port_forward: forwards the port 8080 to deployment/frontend 
port_forward:
	kubectl port-forward deployment/frontend 8080:8080

## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
