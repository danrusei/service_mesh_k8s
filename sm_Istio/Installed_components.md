# Istio install components

This section can be skipped, it's main goal is to visualize the components installed in the cluster during Istio install process. `Istioctl` permits to generate the manifest file, which can be manually deployed in the cluster. `This is not the recommended way to install Iatio as it has a [number of caveats](https://istio.io/latest/docs/setup/install/istioctl/#generate-a-manifest-before-installation).

Generate the manifest file and apply with `kapp` as it order the resources nicer.

```bash
./istio-1.7.4/bin/istioctl manifest generate --set profile=demo > generated-manifest.yaml
kapp deploy -a istio -f generated-manifest.yaml
```


```bash
Namespace     Name                                      Kind                            Conds.  Age  Op      Op st.  Wait to    Rs  Ri  
(cluster)     adapters.config.istio.io                  CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             attributemanifests.config.istio.io        CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             authorizationpolicies.security.istio.io   CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             destinationrules.networking.istio.io      CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             envoyfilters.networking.istio.io          CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             gateways.networking.istio.io              CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             handlers.config.istio.io                  CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             httpapispecbindings.config.istio.io       CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             httpapispecs.config.istio.io              CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             instances.config.istio.io                 CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             istio-reader-istio-system                 ClusterRole                     -       -    create  -       reconcile  -   -  
^             istio-reader-istio-system                 ClusterRoleBinding              -       -    create  -       reconcile  -   -  
^             istio-sidecar-injector                    MutatingWebhookConfiguration    -       -    create  -       reconcile  -   -  
^             istiod-istio-system                       ClusterRole                     -       -    create  -       reconcile  -   -  
^             istiod-istio-system                       ValidatingWebhookConfiguration  -       -    create  -       reconcile  -   -  
^             istiod-pilot-istio-system                 ClusterRoleBinding              -       -    create  -       reconcile  -   -  
^             istiooperators.install.istio.io           CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             peerauthentications.security.istio.io     CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             quotaspecbindings.config.istio.io         CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             quotaspecs.config.istio.io                CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             requestauthentications.security.istio.io  CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             rules.config.istio.io                     CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             serviceentries.networking.istio.io        CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             sidecars.networking.istio.io              CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             templates.config.istio.io                 CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             virtualservices.networking.istio.io       CustomResourceDefinition        -       -    create  -       reconcile  -   -  
^             workloadentries.networking.istio.io       CustomResourceDefinition        -       -    create  -       reconcile  -   -  
istio-system  istio                                     ConfigMap                       -       -    create  -       reconcile  -   -  
^             istio-egressgateway                       Deployment                      -       -    create  -       reconcile  -   -  
^             istio-egressgateway                       PodDisruptionBudget             -       -    create  -       reconcile  -   -  
^             istio-egressgateway                       Service                         -       -    create  -       reconcile  -   -  
^             istio-egressgateway-sds                   Role                            -       -    create  -       reconcile  -   -  
^             istio-egressgateway-sds                   RoleBinding                     -       -    create  -       reconcile  -   -  
^             istio-egressgateway-service-account       ServiceAccount                  -       -    create  -       reconcile  -   -  
^             istio-ingressgateway                      Deployment                      -       -    create  -       reconcile  -   -  
^             istio-ingressgateway                      PodDisruptionBudget             -       -    create  -       reconcile  -   -  
^             istio-ingressgateway                      Service                         -       -    create  -       reconcile  -   -  
^             istio-ingressgateway-sds                  Role                            -       -    create  -       reconcile  -   -  
^             istio-ingressgateway-sds                  RoleBinding                     -       -    create  -       reconcile  -   -  
^             istio-ingressgateway-service-account      ServiceAccount                  -       -    create  -       reconcile  -   -  
^             istio-reader-service-account              ServiceAccount                  -       -    create  -       reconcile  -   -  
^             istio-sidecar-injector                    ConfigMap                       -       -    create  -       reconcile  -   -  
^             istiod                                    Deployment                      -       -    create  -       reconcile  -   -  
^             istiod                                    PodDisruptionBudget             -       -    create  -       reconcile  -   -  
^             istiod                                    Service                         -       -    create  -       reconcile  -   -  
^             istiod-istio-system                       Role                            -       -    create  -       reconcile  -   -  
^             istiod-istio-system                       RoleBinding                     -       -    create  -       reconcile  -   -  
^             istiod-service-account                    ServiceAccount                  -       -    create  -       reconcile  -   -  
^             metadata-exchange-1.6                     EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             metadata-exchange-1.7                     EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             stats-filter-1.6                          EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             stats-filter-1.7                          EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             tcp-metadata-exchange-1.6                 EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             tcp-metadata-exchange-1.7                 EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             tcp-stats-filter-1.6                      EnvoyFilter                     -       -    create  -       reconcile  -   -  
^             tcp-stats-filter-1.7                      EnvoyFilter                     -       -    create  -       reconcile  -   -
```

## Istio-System

## Cluster namespace