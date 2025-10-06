#scale back up rebel base
kubectl config use-context kind-cluster2

kubectl scale deployment rebel-base --replicas 2