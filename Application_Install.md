# Install the distributed App in the cluster

This demo App was created by Google to showcase the use of technologies like Kubernetes/GKE, Istio, Stackdriver, gRPC and others. It worth to mention that the services are communicating between each other with gRPC and the entry point is the Frontend Go App. The services are written in a number of languages.

## Application Architecture (cloned from the GCP repository)

***<a href="https://github.com/GoogleCloudPlatform/microservices-demo#service-architecture" target="_blank">Check Out The App Architecture Here</a>***

## Deploy the application

If you don't want o build all the images, there is a faster and easy way by using Pre-Built Container Images, which are hosted on the gcr.io/google-samples/microservices-demo/ repository. The manifest file can be find in the `realease` directory under `micorservices-app`. Unfortunately this is not an option for me as I would like to test out some deployment strategies and to eventually modify the App.

The application is already initilized with skaffold for easy development and deployment.
The skaffold yaml file looks like this and basicaly include 2 things:

* the service image and the location where the Dockerfile is defined
* the deployment type and the path to the kubernetes manifests

If you are using an remote cluster, should images be pushed to a registry. If not specified, images are pushed only if the current Kubernetes context connects to a remote cluster. In my case I'm using a local Kind cluster, but if you face any issue, [read this doc](https://skaffold.dev/docs/environment/local-cluster/).

```yaml
apiVersion: skaffold/v1beta2
kind: Config
build:
  artifacts:
  - image: emailservice
    context: src/emailservice
  - image: productcatalogservice
    context: src/productcatalogservice
  - image: recommendationservice
    context: src/recommendationservice
  - image: shippingservice
    context: src/shippingservice
  - image: checkoutservice
    context: src/checkoutservice
  - image: paymentservice
    context: src/paymentservice
  - image: currencyservice
    context: src/currencyservice
  - image: cartservice
    context: src/cartservice
  - image: frontend
    context: src/frontend
  - image: loadgenerator
    context: src/loadgenerator
  - image: adservice
    context: src/adservice
  tagPolicy:
    gitCommit: {}
  local:
    useBuildkit: true
deploy:
  kubectl:
    manifests:
    - ./kubernetes-manifests/**.yaml
```

When Skaffold deploys your application, it goes through these steps:

* the Skaffold deployer renders the final Kubernetes manifests: Skaffold replaces untagged image names in the Kubernetes manifests with the final tagged image names. It also might go through the extra intermediate step of expanding templates (for helm) or calculating overlays (for kustomize).
* the Skaffold deployer deploys the final Kubernetes manifests to the cluster

Skaffold supports kubectl, helm, kustomize for deploying applications and can be run by:

* Use `skaffold dev` to build and deploy your app every time your code changes,
* Use `skaffold run` to build and deploy your app once, similar to a CI/CD pipeline

I copied the skaffold file from microservices-app to the root directory so I can customize it for my needs, as I don't want to modify anything in the cloned GCP repository.

Run `skaffold run` to build and deploy the application in the cluster. First time you run this can take up to 10 to 15 minutes to build all images and create the deployments. Once ready, you should see something similar to:

```bash
Generating tags...
...................
Checking cache...
...................
Building [adservice]...
...................
Loading images into kind cluster nodes...
 - emailservice:602dafec0d07d5da2492964fee61dd73f7005ed5d1a786491319c3fd583a0319 -> Loaded
 - productcatalogservice:4fb6a27500e0aeed2fdb32ab156a60a3cf5d34457ebbbac7b26e98f7eef03177 -> Loaded
 - recommendationservice:6bcca0507828df66c81102b4835f641fca74acc3d4b248aca92fee9f167225bc -> Loaded
....................
....................
Starting deploy...
 - deployment.apps/adservice created
 - service/adservice created
 - deployment.apps/cartservice created
 - service/cartservice created
...................
...................
Waiting for deployments to stabilize...
 - deployment/adservice: creating container server
    - pod/adservice-d67c75668-psvqj: creating container server
 - deployment/cartservice: creating container server
    - pod/cartservice-75957fbd95-4lzgz: creating container server
 - deployment/checkoutservice: creating container server
...................
...................
Deployments stabilized in 49.698352703s
```

### With NO Service Mesh Installed

If this runs succefully, you should be able to see the deployments and their respective services created in the cluster.

```bash
$ kubectl get deployments
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
adservice               1/1     1            1           13m
cartservice             1/1     1            1           13m
checkoutservice         1/1     1            1           13m
currencyservice         1/1     1            1           13m
emailservice            1/1     1            1           13m
frontend                1/1     1            1           13m
loadgenerator           1/1     1            1           13m
paymentservice          1/1     1            1           13m
productcatalogservice   1/1     1            1           13m
recommendationservice   1/1     1            1           13m
redis-cart              1/1     1            1           13m
shippingservice         1/1     1            1           13m

$ kubectl get services
NAME                    TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
adservice               ClusterIP      10.96.188.231   <none>        9555/TCP       13m
cartservice             ClusterIP      10.96.107.128   <none>        7070/TCP       13m
checkoutservice         ClusterIP      10.96.74.148    <none>        5050/TCP       13m
currencyservice         ClusterIP      10.96.208.35    <none>        7000/TCP       13m
emailservice            ClusterIP      10.96.207.228   <none>        5000/TCP       13m
frontend                ClusterIP      10.96.76.114    <none>        80/TCP         13m
frontend-external       LoadBalancer   10.96.148.23    <pending>     80:31665/TCP   13m
kubernetes              ClusterIP      10.96.0.1       <none>        443/TCP        5h56m
paymentservice          ClusterIP      10.96.64.98     <none>        50051/TCP      13m
productcatalogservice   ClusterIP      10.96.38.181    <none>        3550/TCP       13m
recommendationservice   ClusterIP      10.96.133.71    <none>        8080/TCP       13m
redis-cart              ClusterIP      10.96.143.45    <none>        6379/TCP       13m
shippingservice         ClusterIP      10.96.149.166   <none>        50051/TCP      13m
```

Kind does not provision an IP address for the service. So in order to access the frontend you hvae to port forward to the deployment.

```bash
kubectl port-forward deployment/frontend 8080:8080
```

Now you should be able to see the **Online Boutique** demo site running in your cluster by accessing the **http://localhost:8080** address.

### With Istio installed in the cluster

```bash
$ kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
adservice-55d889c994-w7dst               2/2     Running   0          69s
cartservice-7fb6cdbcc-rldhw              2/2     Running   1          69s
checkoutservice-54685dc7d6-gnz7d         2/2     Running   0          69s
currencyservice-5c676f49d6-7rtbp         2/2     Running   0          69s
emailservice-869b9868dd-ls26v            2/2     Running   0          69s
frontend-5fb4985c95-ztbfk                2/2     Running   0          69s
loadgenerator-6478df4495-b69v8           2/2     Running   2          68s
paymentservice-7588996856-8mmfd          2/2     Running   0          68s
productcatalogservice-6f7797b86c-wmwf5   2/2     Running   0          68s
recommendationservice-548f887d46-ffzxd   2/2     Running   0          68s
redis-cart-8d6c9c564-mpnc4               2/2     Running   0          68s
shippingservice-5784df8c-hdlsg           2/2     Running   0          68s
```

Notice that now there are 2 container in each pod. One is the actual application and the other is the sidecar container inserted by Istio.

```bash
$ kubectl describe pod frontend-5fb4985c95-ztbfk | grep Image:
    Image:         docker.io/istio/proxyv2:1.7.4
    Image:         frontend:e65e60d4d7232d15edf2e6b0760c6c56f5ece56e8c1084864de91bac86b3ffb1
    Image:         docker.io/istio/proxyv2:1.7.4

```

And you can now check if all the proxies are connected to the Pilot instance so it can receive the configuration.

```bash
$ istioctl proxy-status
NAME                                                   CDS        LDS        EDS        RDS          ISTIOD                     VERSION
adservice-55d889c994-w7dst.default                     SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
cartservice-7fb6cdbcc-rldhw.default                    SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
checkoutservice-54685dc7d6-gnz7d.default               SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
currencyservice-5c676f49d6-7rtbp.default               SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
emailservice-869b9868dd-ls26v.default                  SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
frontend-5fb4985c95-ztbfk.default                      SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
istio-egressgateway-844fd8c8c6-gr48m.istio-system      SYNCED     SYNCED     SYNCED     NOT SENT     istiod-766d57484-c9l5q     1.7.4
istio-ingressgateway-67fc4949df-8m9d9.istio-system     SYNCED     SYNCED     SYNCED     NOT SENT     istiod-766d57484-c9l5q     1.7.4
loadgenerator-6478df4495-b69v8.default                 SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
paymentservice-7588996856-8mmfd.default                SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
productcatalogservice-6f7797b86c-wmwf5.default         SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
recommendationservice-548f887d46-ffzxd.default         SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
redis-cart-8d6c9c564-mpnc4.default                     SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
shippingservice-5784df8c-hdlsg.default                 SYNCED     SYNCED     SYNCED     SYNCED       istiod-766d57484-c9l5q     1.7.4
```

And you can go to the `Grafana dashboard` and be able to see the traffic generated by the loadgenerator pod.

```bash
istioctl dashboard grafana
http://localhost:3000
```

Pictures from Grafana:

![grafana general](grafana_general.png "Grafana General")
![grafana inbound](grafana_inbound.png "Grafana Inbound")
![grafana general](grafana_outbound.png "Grafana Outbound")
