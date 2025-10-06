#just on one cluster, and does not matter which cluster context you are connected to 

kubectl config use-context kind-cluster2

kubectl scale deployment rebel-base --replicas 0