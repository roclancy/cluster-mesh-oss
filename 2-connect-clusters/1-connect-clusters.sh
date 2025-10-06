#must be done where kube config can access both / all clusters

kubectl config use-context kind-cluster1

cilium clustermesh connect \
  --context kind-cluster1 \
  --destination-context kind-cluster2