#run same test as before to see it loadbalancing 

echo "****************************"
echo " GENERATING REQUEST FROM CLUSTER1 & CLUSTER2 "
echo "****************************"

kubectl config use-context kind-cluster1
kubectl exec -ti deployments/x-wing -- /bin/sh -c 'for i in $(seq 1 10); do curl rebel-base; done'

kubectl config use-context kind-cluster2
kubectl exec -ti deployments/x-wing -- /bin/sh -c 'for i in $(seq 1 10); do curl rebel-base; done'