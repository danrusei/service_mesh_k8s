# Istio Security

Security in Istio involves multiple components:

* A Certificate Authority (CA) for key and certificate management
* The configuration API server distributes to the proxies:
  * authentication policies
  * authorization policies
  * secure naming information
* Sidecar and perimeter proxies work as Policy Enforcement Points (PEPs) to secure communication between clients and servers.

A set of Envoy proxy extensions to manage telemetry and auditing
Checkout [Istio Security High-Level architecture](https://istio.io/latest/docs/concepts/security/#high-level-architecture) for in depth details details.

Next:

* [Authentication](Authentication.md)
* [Authorizaion](Authorization.md)

**[Back to Main Page](../README.md)**
