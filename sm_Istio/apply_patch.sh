#!/bin/bash

kubectl patch deployment adservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"ad"}}}}'
kubectl patch deployment cartservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"cart"}}}}'
kubectl patch deployment checkoutservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"checkout"}}}}'
kubectl patch deployment currencyservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"currency"}}}}'
kubectl patch deployment emailservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"email"}}}}'
kubectl patch deployment frontend -p '{"spec":{"template":{"spec":{"serviceAccountName":"frontend"}}}}'
kubectl patch deployment loadgenerator -p '{"spec":{"template":{"spec":{"serviceAccountName":"loadgenerator"}}}}'
kubectl patch deployment paymentservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"payment"}}}}'
kubectl patch deployment productcatalogservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"productcatalog"}}}}'
kubectl patch deployment recommendationservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"recommendation"}}}}'
kubectl patch deployment redis-cart -p '{"spec":{"template":{"spec":{"serviceAccountName":"redis"}}}}'
kubectl patch deployment shippingservice -p '{"spec":{"template":{"spec":{"serviceAccountName":"shipping"}}}}'