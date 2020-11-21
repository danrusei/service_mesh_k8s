# Istio Authnetication & MTLS

Istio provides two types of authentication:

* Peer authentication: used for service-to-service authentication to verify the client making the connection. Istio offers mutual TLS as a full stack solution for transport authentication, which can be enabled without requiring service code changes. This solution:
  * Provides each service with a strong identity representing its role to enable interoperability across clusters and clouds.
  * Secures service-to-service communication.
  * Provides a key management system to automate key and certificate generation, distribution, and rotation.
* Request authentication: Used for end-user authentication to verify the credential attached to the request. Istio enables request-level authentication with JSON Web Token (JWT) validation and a streamlined developer experience using a custom authentication provider or any OpenID Connect provider.

> The end-user authentication is not covered on this page, only the service-to-service communication.

## MTLS

When a workload sends a request to another workload using mutual TLS authentication, the request is handled as follows:

* Istio re-routes the outbound traffic from a client to the client’s local sidecar Envoy.
* The client side Envoy starts a mutual TLS handshake with the server side Envoy. During the handshake, the client side Envoy also does a secure naming check to verify that the service account presented in the server certificate is authorized to run the target service.
* The client side Envoy and the server side Envoy establish a mutual TLS connection, and Istio forwards the traffic from the client side Envoy to the server side Envoy.
* After authorization, the server side Envoy forwards the traffic to the server service through local TCP connections.

Peer authentication policies specify the mutual TLS mode Istio enforces on target workloads. The following modes are supported:

* PERMISSIVE: Workloads accept both mutual TLS and plain text traffic. This mode is most useful during migrations when workloads without sidecar cannot use mutual TLS. Once workloads are migrated with sidecar injection, you should switch the mode to STRICT.
* STRICT: Workloads only accept mutual TLS traffic.
* DISABLE: Mutual TLS is disabled. From a security perspective, you shouldn’t use this mode unless you provide your own security solution.

When peer authentication policy is unset, the **Permissive** mode is the default. Therefore after the application is deployed with sidecar installed along with the application container the traffic between microservices are secured by default.

To check the above statement I installed Istio with values.global.proxy.privileged set to TRUE in order to use tcpdump to verify if traffic is encrypted or not. Necessary in this case for this step but not for the other.

```makefile
istio_install:
	./istio-1.7.4/bin/istioctl install --set profile=demo --set values.global.proxy.privileged=true
```

## Default deployment with sidecar on each service

Let's examine the traffic between `loadgenerator` and `frontend` service. The reason I took these 2 services as the traffic is http, all the other services are using GRPC, therefore the message is sent in binary format.

```bash
$ kubectl exec -ndefault "$(kubectl get pod -ndefault -lapp=loadgenerator -ojsonpath={.items..metadata.name})" -c istio-proxy -- sudo tcpdump dst port 8080  -A
```

The traffic is encrypted, you'll see some gelbrish like this:

```bash
E..A.3@.@.?o
...
......../...x.....e H.....
F...+. %.................1.	.Z........\s3...z......h..J..C...Y...8....m]ly(K.T+v...Z._2.........I.14.Z.K.f.2..e.....X.....A..
```

## Disable sidecar on frontend service

```yaml
template:
    metadata:
      labels:
        app: frontend
      annotations:
        sidecar.istio.io/rewriteAppHTTPProbers: "true"
        sidecar.istio.io/inject: "false
```



```bash
$ kubectl get pods -n default -o jsonpath="{.items[*].spec.containers[*].image}" | tr -s '[[:space:]]' '\n'
adservice:e08448e3e0673746984378313cb9b7e8b0ed25eeae1ed29eb3791a35ccc2b9a2
docker.io/istio/proxyv2:1.7.4

cartservice:6dc0adc40b3af1ebb240c865fb2682ba901860515dc32329211f930ea896b447
docker.io/istio/proxyv2:1.7.4

checkoutservice:553959b752473a3ff22d1cd5be670286c624ea8e556a84bd81f5b89b07b0599d
docker.io/istio/proxyv2:1.7.4

currencyservice:f321ccfb145e155e630f365d651ddcf2c0b16a145fbec95ee16c3550c9396bdd
docker.io/istio/proxyv2:1.7.4

emailservice:602dafec0d07d5da2492964fee61dd73f7005ed5d1a786491319c3fd583a0319
docker.io/istio/proxyv2:1.7.4

frontend:e65e60d4d7232d15edf2e6b0760c6c56f5ece56e8c1084864de91bac86b3ffb1

loadgenerator:973aaaea6528d561c78a90d604900e13f804d2889bd59e9330de9f3d1f70ccef
docker.io/istio/proxyv2:1.7.4

paymentservice:88927abf369f89beefa1650322a9f281f2c146e7f4e92c9c4643c022bc03e675
docker.io/istio/proxyv2:1.7.4

productcatalogservice:4fb6a27500e0aeed2fdb32ab156a60a3cf5d34457ebbbac7b26e98f7eef03177
docker.io/istio/proxyv2:1.7.4

recommendationservice:6bcca0507828df66c81102b4835f641fca74acc3d4b248aca92fee9f167225bc
docker.io/istio/proxyv2:1.7.4

redis:alpine
docker.io/istio/proxyv2:1.7.4

shippingservice:a4c5224d30c1a800474ddb6cef9d5869bf0b8eb0192d2eee868b4f3fc8dd9259
docker.io/istio/proxyv2:1.7.4
```




```bash
GET /product/L9ECAV7KIM HTTP/1.1
host: frontend
user-agent: python-requests/2.21.0
accept-encoding: gzip, deflate
accept: */*
cookie: shop_session-id=0ae03d9d-e835-49b6-9533-1abfb251a266
x-forwarded-proto: http
x-request-id: 1c34d097-5d5b-910a-9e15-7e68ab2ee027
x-envoy-decorator-operation: frontend.default.svc.cluster.local:80/*
x-envoy-peer-metadata: ChoKCkNMVVNURVJfSUQSDBoKS3ViZXJuZXRlcwo3CgxJTlNUQU5DRV9JUFMSJxolMTAuMjQ0LjIuMTcsZmU4MDo6YTQ3ZDphYWZmOmZlNzk6MWQ1OQraAgoGTEFCRUxTEs8CKswCChYKA2FwcBIPGg1sb2FkZ2VuZXJhdG9yCioKHGFwcC5rdWJlcm5ldGVzLmlvL21hbmFnZWQtYnkSChoIc2thZmZvbGQKGQoMaXN0aW8uaW8vcmV2EgkaB2RlZmF1bHQKIQoRcG9kLXRlbXBsYXRlLWhhc2gSDBoKNmNkOWY0Zjk5OAokChlzZWN1cml0eS5pc3Rpby5pby90bHNNb2RlEgcaBWlzdGlvCjIKH3NlcnZpY2UuaXN0aW8uaW8vY2Fub25pY2FsLW5hbWUSDxoNbG9hZGdlbmVyYXRvcgovCiNzZXJ2aWNlLmlzdGlvLmlvL2Nhbm9uaWNhbC1yZXZpc2lvbhIIGgZsYXRlc3QKPQoTc2thZmZvbGQuZGV2L3J1bi1pZBImGiRkMWE3YzU0Zi0xYzAxLTRlOGQtYTk2Mi1lYjc5MzFiMWQzYjAKGgoHTUVTSF9JRBIPGg1jbHVzdGVyLmxvY2FsCigKBE5BTUUSIBoebG9hZGdlbmVyYXRvci02Y2Q5ZjRmOTk4LTRwNnZ2ChYKCU5BTUVTUEFDRRIJGgdkZWZhdWx0ClEKBU9XTkVSEkgaRmt1YmVybmV0ZXM6Ly9hcGlzL2FwcHMvdjEvbmFtZXNwYWNlcy9kZWZhdWx0L2RlcGxveW1lbnRzL2xvYWRnZW5lcmF0b3IKHAoPU0VSVklDRV9BQ0NPVU5UEgkaB2RlZmF1bHQKIAoNV09SS0xPQURfTkFNRRIPGg1sb2FkZ2VuZXJhdG9y
x-envoy-peer-metadata-id: sidecar~10.244.2.17~loadgenerator-6cd9f4f998-4p6vv.default~default.svc.cluster.local
x-envoy-attempt-count: 1
x-b3-traceid: 42f371a7bff6c107874040844d65ff37
x-b3-spanid: 874040844d65ff37
x-b3-sampled: 1
content-length: 0
```

## Enforce the Strict authentication policy

!!!!!NED TO demonstrate that traffic STOP with security STRICT on istio authentication policy
try to disable mtls and receive unautheticated traffic !!!!!

**[Back to Main Page](../README.md)**
