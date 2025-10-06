#run on BOTH clusters 

kubectl config use-context kind-cluster1

kubectl annotate service rebel-base service.cilium.io/global="true"

kubectl config use-context kind-cluster2

kubectl annotate service rebel-base service.cilium.io/global="true"