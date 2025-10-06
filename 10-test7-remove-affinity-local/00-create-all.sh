
echo "****************************"
echo " SET CLUSTER 1 BACK TO GLOBAL"
echo "****************************"


source 1-set-cluster-1-back-to-global.sh

echo "****************************"
echo " GENERATING REQUESTS FROM BOTH CLUSTER1 & CLUSTER2"
echo "****************************"

source 2-test.sh