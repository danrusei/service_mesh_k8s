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

### Install with istioctl install (recommended way)

```bash
$ istioctl install --set profile=demo
Detected that your cluster does not support third party JWT authentication. Falling back to less secure first party JWT.
✔ Istio core installed
✔ Istiod installed
✔ Egress gateways installed
✔ Ingress gateways installed
✔ Installation complete
```

To authenticate with the Istio control plane, the Istio proxy will use a Service Account token. Kubernetes supports two forms of these tokens:

* Third party tokens, which have a scoped audience and expiration.
* First party tokens, which have no expiration and are mounted into all pods.

While most cloud providers support this feature now, many local development tools and custom installations may not.


`Istioctl` is a great tool as can be used not only for install but also to validate in analyze the install.

```bash
$ istioctl analyze
Warn [IST0102] (Namespace default) The namespace is not enabled for Istio injection. Run 'kubectl label namespace default istio-injection=enabled' to enable it, or 'kubectl label namespace default istio-injection=disabled' to explicitly mark it as not needing injection
Error: Analyzers found issues when analyzing namespace: default.
See https://istio.io/docs/reference/config/analysis for more information about causes and resolutions.
```

The above warning shows that I forgot to enable Istio injection, which enable to automatically inject Envoy sidecar proxies when the application will be deployed later in the default namespace.

```bash
$ kubectl label namespace default istio-injection=enabled
```

and the result:

```bash
$ istioctl analyze
✔ No validation issues found when analyzing namespace: default.
```

The following validates that the istio was installed in the cluster. Istiod is a single binary which includes `service discovery (Pilot), configuration (Galley), certificate generation (Citadel)`.

```bash
$ kubectl get pods -n istio-system
NAME                                    READY   STATUS    RESTARTS   AGE
istio-egressgateway-844fd8c8c6-dhbnt    1/1     Running   0          163m
istio-ingressgateway-67fc4949df-bh2gl   1/1     Running   0          163m
istiod-766d57484-bnpqd                  1/1     Running   0          163m
```

You can get an overview of your mesh using the proxy-status (worth to mention that there is no application yet installed):

```bash
$ istioctl proxy-status
NAME                                                   CDS        LDS        EDS        RDS          ISTIOD                     VERSION
istio-egressgateway-844fd8c8c6-dhbnt.istio-system      SYNCED     SYNCED     SYNCED     NOT SENT     istiod-766d57484-bnpqd     1.7.4
istio-ingressgateway-67fc4949df-bh2gl.istio-system     SYNCED     SYNCED     SYNCED     NOT SENT     istiod-766d57484-bnpqd     1.7.4
```

**[Back to Main Page](../README.md)**
