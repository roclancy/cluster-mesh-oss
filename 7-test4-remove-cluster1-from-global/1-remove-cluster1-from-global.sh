
echo "****************************"
echo " REMOVING CLUSTER1 FROM THE GLOBAL LOAD BALANCING"
echo "****************************"


kubectl config use-context kind-cluster1

kubectl annotate service rebel-base service.cilium.io/shared="false" --overwrite
