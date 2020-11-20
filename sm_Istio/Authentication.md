# Istio Authnetication

Istio provides two types of authentication:

* Peer authentication: used for service-to-service authentication to verify the client making the connection. Istio offers mutual TLS as a full stack solution for transport authentication, which can be enabled without requiring service code changes. This solution:
  * Provides each service with a strong identity representing its role to enable interoperability across clusters and clouds.
  * Secures service-to-service communication.
  * Provides a key management system to automate key and certificate generation, distribution, and rotation.
* Request authentication: Used for end-user authentication to verify the credential attached to the request. Istio enables request-level authentication with JSON Web Token (JWT) validation and a streamlined developer experience using a custom authentication provider or any OpenID Connect provider.

I installed Istio with values.global.proxy.privileged set to TRUE in order to use tcpdump to verify if traffic is encrypted or not. Required for this step but not for the other.

```makefile
istio_install:
	./istio-1.7.4/bin/istioctl install --set profile=demo --set values.global.proxy.privileged=true
```

```bash
$ kubectl exec -ndefault "$(kubectl get pod -ndefault -lapp=recommendationservice -ojsonpath={.items..metadata.name})" -c istio-proxy -- sudo tcpdump dst port 8080  -A
```

try to disable mtls and receive unautheticated traffic !!!!!


**[Back to Main Page](../README.md)**
