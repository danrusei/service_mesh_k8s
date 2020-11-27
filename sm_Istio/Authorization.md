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


**[Back to Main Page](../README.md)**
