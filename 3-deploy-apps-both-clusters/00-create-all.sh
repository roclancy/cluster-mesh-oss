echo "****************************"
echo " DEPLOYING APPS TO CLUSTER 1"
echo "****************************"

kubectl config use-context kind-cluster1

kubectl apply -f 1-deployment.yaml
kubectl apply -f 2-cluster1-config-map.yaml
kubectl apply -f 3-create-service.yaml

source 4-port-forward-hubble-ui.sh
sleep 20
source 5-test-service-from-xwing.sh


#deploying apps to cluster 2
echo "****************************"
echo " DEPLOYING APPS TO CLUSTER 2"
echo "****************************"

kubectl config use-context kind-cluster2

kubectl apply -f 1-deployment-cluster2.yaml
kubectl apply -f 2-cluster2-config-map.yaml
kubectl apply -f 3-create-service-cluster2.yaml


sleep 20
source 4-test-service-from-xwing-cluster2.sh

