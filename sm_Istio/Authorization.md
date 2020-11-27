# Istio Authorization

**Istio Authorization Policy** enables access control on workloads in the mesh. To configure an authorization policy, you create an `AuthorizationPolicy` custom resource. It is **highly customizable**, allows you to match from namespace wide to specific workloads and investigate each request source and destination.

An authorization policy includes a selector, an action, and a list of rules:

* The `selector` field specifies the target of the policy
* The `action` field specifies whether to allow or deny the request
* The `rules` specify when to trigger the action
  * The `from` field in the rules specifies the sources of the request
  * The `to` field in the rules specifies the operations of the request
  * The `when` field specifies the conditions needed to apply the rule

[Here you can inspect](https://istio.io/latest/docs/reference/config/security/authorization-policy/) all the knobs and controls also [authorization policy conditions](https://istio.io/latest/docs/reference/config/security/conditions/), where you can specifies a list of additional conditions of a request.

TODO !!!!! https://raw.githubusercontent.com/istio/istio/release-1.8/samples/bookinfo/platform/kube/bookinfo.yaml
!!! I may need to create service account for each service, in order to be used with `principals`
!!! I may have to copy the manifests local and modify them

## Simple Authorization Policy

The below policy allows the services from the `default` namespace to communicate on port `7000` with `currencyservice`.

```yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: checkoutservice-to-paymentservice
  namespace: default
spec:
  selector:
    matchLabels:
      app: currencyservice
  action: ALLOW
  rules:
  # - from:
  #   - source:
  #       principals: ["cluster.local/ns/default/sa/checkoutservice"]
  #   - source:
  #       principals: ["cluster.local/ns/default/sa/frontendservice"]
  - to:
    - operation:
        ports: ["7000"]
```

TODO: Investigate why is not working when the from source is defined

## Another Authorization Policy with different details

**[Back to Main Page](../README.md)**
