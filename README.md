# K8S Service Meshes

Describe what I want to achieve.....TBD

## The Microservice App

Before deploying any Service Mesh in the Kubernetes Cluster we need a microservice application. One option was to write a simple distributed App, but it is not the main focus of this journey so I would rather use an available example out there. There are  a couple of options, in fact every Service Mesh has it's own example application to demonstrate the Service Mesh functionalities.   
Though, one great example that can be used under the Apache 2.0 license is the [GCP microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo). It simulates a real world distributed application with services written in **Go**, **Python**, **Java**, **Node.js** and **C#**.   
This is the perfect App to show the Service Meshes benefits, as it is impractical to incorporate service discovery, load balancing, failure recovery, metrics, and monitoring, A/B testing, canary rollouts, rate limiting, within the application itself especially when the entire stack is written in multiple languages.    

## Tools & Initial setup

I'm using the following tools:

### [Kind](https://kind.sigs.k8s.io/)
Kind is a tool for running local Kubernetes clusters using Docker container “nodes”.   
[Check out](../setup-kind/README.md), the initial setup of the kind cluster.   

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

### [Kapp](https://github.com/k14s/kapp)
Kapp is a deployment CLI tool, which focuses on resource diffing, labeling, deployment and deletion. 

```bash
$ kapp version
kapp version 0.34.0
```

## Run the application
Follow [these steps](Run_the_App.md) to run the App on the Cluster.

## Istio
### Install - link to document
### mtls
### Traffic split
enumarate below all the test we wanna run
