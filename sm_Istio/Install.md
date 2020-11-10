# Istio install

## Download the Istio release

```bash
curl -L https://istio.io/downloadIstio | sh -
```

The **istioctl** is located within the `istio-1.7.4/bin` directory.

In order to install Istio within the cluster, you should select between the following [configuration profiles](https://istio.io/latest/docs/setup/additional-setup/config-profiles/). By selecting the profiles you enable a number of components. `Default` is recommended for production environment. However `Demo` configuration profile is designed to showcase Istio functionality with modest resource requirements. More important this profile enables high levels of tracing and access loggin. There are other which adress other requirements, like multicluster and test experimental features.

To list available profiles and the difference between them:

```bash
$ istioctl profile list
$ istioctl profile diff demo default
```

### Visualize what istio install in the Cluster

```bash
./istio-1.7.4/bin/istioctl manifest generate --set profile=demo > generated-manifest.yaml
kapp deploy -a test -f generated-manifest.yaml
```

### Install with istioctl install (recommended way)

'kubectl label namespace default istio-injection=enabled'

### Other istioctl commands
analyze         Analyze Istio configuration and print validation messages
dashboard       Access to Istio web UIs
validate        Validate Istio policy and rules files
verify-install  Verifies Istio Installation Status
