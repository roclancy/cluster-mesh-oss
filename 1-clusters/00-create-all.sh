#create cluster 1
echo "****************************"
echo " CREATING CLUSTER 1"
echo "****************************"

source 1-create-kind-clusters.sh
source 2-install-cilium-cluster1.sh
source 3-enable-hubble-ui.sh
source 4-check-all-installed.sh
source 5-enable-cluster-mesh.sh
source 6-check-cluster-mesh-status.sh

#create cluster 2

echo "****************************"
echo " CREATING CLUSTER 2"
echo "****************************"

source 1-create-kind-clusters2.sh
source 2-install-cilium-cluster2.sh
#source 3-enable-hubble-ui.sh
source 3-check-all-installed-cluster2.sh
source 4-enable-cluster-mesh-cluster2.sh
source 5-check-cluster-mesh-status-cluster2.sh