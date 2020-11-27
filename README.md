# K8S Service Meshes

Test Kubernetes Service Meshes basic functionalities. The intention is to be able to reproduce pretty fast the below tests of your Service Mesh of choice.  
Contributions are welcomed, so please submit issues and/or PRs.

## Service Messhes

The below steps are documeneted within separate pages, recommended to follow in order.

* **[Kind Cluster - initial setup](./setup-kind/README.md)**
* **[Istio](./sm_Istio/README.md)**
  * [Fast Forward - skip the installation details](./sm_Istio/fast_forward.md)
  * [Install](./sm_Istio/Install.md)
    * [Installed components](./sm_Istio/Installed_components.md)
    * [Integrations](./sm_Istio/Integrations.md)
  * [Deploy the microservice apllication in the cluster](Application_Install.md)
  * [Security](./sm_Istio/Security.md)
    * [Authentication & MTLS](./sm_Istio/Authentication.md)
    * [Authorization](./sm_Istio/Authorization.md)
  * Traffic Management
    * Traffic Shifting
    * Request Routing
* **Linkerd(linkerd.io)** - TODO
* **OpenServiceMesh(openservicemesh.io)** - TODO
* **[Consul](consul.io)** - TODO
* **Kuma(kuma.io)** - TODO
* **TraefikMesh(traefik.io/traefik-mesh)** - TODO

## The Microservice App

Before deploying any Service Mesh in the Kubernetes Cluster we need a microservice application. One option is to write a simple distributed App, but as it is not the main focus of this journey, I would rather use an available example out there. There are  a couple of options, in fact every Service Mesh has it's own example application to demonstrate the Service Mesh capabilities.  
One great example that can be used under the Apache 2.0 license is the [GCP microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo) demo app. It simulates a real world distributed application with services written in **Go**, **Python**, **Java**, **Node.js** and **C#**.  
This is the perfect App to showcase the Service Meshes benefits. It is impractical to incorporate service discovery, load balancing, failure recovery, metrics, and monitoring, A/B testing, canary rollouts, rate limiting, within the application itself especially when the entire stack is written in multiple languages. A solution to this in Kubernetes is the service mesh.  

## Tools

I'm using the following tools:

### [Kind](https://kind.sigs.k8s.io/)

Kind is a tool for running local Kubernetes clusters using Docker container “nodes”.  

```bash
$ kind version
kind v0.9.0 go1.15.2 linux/amd64
```

### [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters. You can use kubectl to deploy applications, inspect and manage cluster resources, and view logs.  
You must use a kubectl version that is within one minor version difference of your cluster. For example, a v1.2 client should work with v1.1, v1.2, and v1.3 master. Using the latest version of kubectl helps avoid unforeseen issues.  

```bash
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.3", GitCommit:"1e11e4a2108024935ecfcb2912226cedeafd99df", GitTreeState:"clean", BuildDate:"2020-10-14T12:50:19Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.1", GitCommit:"206bcadf021e76c27513500ca24182692aabd17e", GitTreeState:"clean", BuildDate:"2020-09-14T07:30:52Z", GoVersion:"go1.15", Compiler:"gc", Platform:"linux/amd64"}
```

### [Skaffold](https://skaffold.dev/)

Skaffold handles the workflow for building, pushing and deploying your application, allowing you to focus on what matters most: writing code.

> Although deploying the App with `skaffold` is preferable in order to see the application changes in real time, I might switch between using it and the [release packages](./microservices-app/release) for faster reproducibility and replicability.

```bash
$ skaffold version
v1.16.0
```

### [Kapp](https://github.com/k14s/kapp)

Kapp is a deployment CLI tool, which focuses on resource diffing, labeling, deployment and deletion.

```bash
$ kapp version
kapp version 0.34.0
```
