
# Configure Kind 

One control plane node and three "workers".
While these will not add more real compute capacity and have limited isolation, this can be useful to simulate a real environtment(ex. testing rolling updates).   
The API-server and other control plane components will be on the control-plane node.

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
```

## What is running on a Kind Cluster ?
TBD (with details about nodes and services from the system namespace)