

#NOTE:
#The opposite effect can be obtained by using "remote" as the annotation value.

kubectl config use-context kind-cluster1

#kubectl annotate service rebel-base service.cilium.io/affinity=global --overwrite

kubectl annotate service rebel-base service.cilium.io/affinity-