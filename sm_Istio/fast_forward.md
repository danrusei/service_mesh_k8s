# Fast Forward

If you would like to focus on testing out the Service Mesh features and move fast through the `setup process`, then follow the below steps:

* Make sure that you have installed the [Tools](.../README.md#Tools)
* Clone the [Github repository](https://github.com/danrusei/service_mesh_k8s)
* Create the kind cluster (3 nodes - 1 controller plane and two worker nodes) with `make cluster`

```bash
$ make cluster
kind create cluster --config setup-kind/kind_config.yaml --name kind-istio
Creating cluster "kind-istio" ...
 ✓ Ensuring node image (kindest/node:v1.19.1) 🖼
 ✓ Preparing nodes 📦 📦 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
 ✓ Joining worker nodes 🚜 
Set kubectl context to "kind-kind-istio"
You can now use your cluster with:

kubectl cluster-info --context kind-kind-istio

Have a nice day! 👋
```

* Install Istio Service Mesh with `make istio_install`

```bash
$ make istio_install 
./istio-1.7.4/bin/istioctl install --set profile=demo --set values.global.proxy.privileged=true
Detected that your cluster does not support third party JWT authentication. Falling back to less secure first party JWT. See https://istio.io/docs/ops/best-practices/security/#configure-third-party-service-account-tokens for details.
✔ Istio core installed
✔ Istiod installed
✔ Ingress gateways installed
✔ Egress gateways installed
✔ Installation complete
```

* Label default namespace with istio-inject `make istio_prepare`

```bash
$ make istio_prepare
kubectl label namespace default istio-injection=enabled	
namespace/default labeled
```

* Install Prometheus and Grafana (using Istio integrations) with `make istio_integrations`

```bash
$ make istio_integrations
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml
serviceaccount/prometheus created
configmap/prometheus created
Warning: rbac.authorization.k8s.io/v1beta1 ClusterRole is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRole
clusterrole.rbac.authorization.k8s.io/prometheus created
Warning: rbac.authorization.k8s.io/v1beta1 ClusterRoleBinding is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRoleBinding
clusterrolebinding.rbac.authorization.k8s.io/prometheus created
service/prometheus created
deployment.apps/prometheus created
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml
serviceaccount/grafana created
configmap/grafana created
service/grafana created
deployment.apps/grafana created
configmap/istio-grafana-dashboards created
configmap/istio-services-grafana-dashboards created
```

* Check if everything was installed and working

```bash
$ kubectl get pods --all-namespaces
NAMESPACE            NAME                                               READY   STATUS    RESTARTS   AGE
istio-system         grafana-57bb676c4c-6dm9r                           1/1     Running   0          29m
istio-system         istio-egressgateway-844fd8c8c6-tc994               1/1     Running   0          48m
istio-system         istio-ingressgateway-67fc4949df-xdg7s              1/1     Running   0          48m
istio-system         istiod-766d57484-9nxwp                             1/1     Running   0          48m
istio-system         prometheus-7c8bf6df84-25mz9                        2/2     Running   0          29m
kube-system          coredns-f9fd979d6-bmk4c                            1/1     Running   0          55m
kube-system          coredns-f9fd979d6-bzs62                            1/1     Running   0          55m
kube-system          etcd-kind-istio-control-plane                      1/1     Running   0          55m
kube-system          kindnet-5v2ct                                      1/1     Running   0          54m
kube-system          kindnet-gkf2f                                      1/1     Running   0          55m
kube-system          kindnet-rgdhb                                      1/1     Running   0          54m
kube-system          kube-apiserver-kind-istio-control-plane            1/1     Running   0          55m
kube-system          kube-controller-manager-kind-istio-control-plane   1/1     Running   0          55m
kube-system          kube-proxy-jw5l4                                   1/1     Running   0          54m
kube-system          kube-proxy-tj7cn                                   1/1     Running   0          54m
kube-system          kube-proxy-z26sm                                   1/1     Running   0          55m
kube-system          kube-scheduler-kind-istio-control-plane            1/1     Running   0          55m
local-path-storage   local-path-provisioner-78776bfc44-hzd6q            1/1     Running   0          55m
```

Now you can Skip the Istio Installation detailed process and move to application deployment and test out Istio features.

**[Back to Main Page](../README.md)**
