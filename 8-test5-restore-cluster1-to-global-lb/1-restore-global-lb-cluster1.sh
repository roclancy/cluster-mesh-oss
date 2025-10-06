
kubectl config use-context kind-cluster1

kubectl annotate service rebel-base service.cilium.io/shared="true" --overwrite 