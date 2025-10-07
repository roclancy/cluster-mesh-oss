echo "*****************************"
echo " DELETING ALL KIND CLUSTERS"
echo "*****************************"

kind delete cluster --name cluster1
kind delete cluster --name cluster2

echo "*****************************"
echo "ALL KIND CLUSTERS DELETED"
echo "*****************************"
