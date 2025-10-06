
echo "****************************"
echo " SET AFFINITY ON CLUSTER-1 TO SERVICE REQUEST LOCAL FIRST"
echo "****************************"

source 1-set-cluster-local.sh

echo "****************************"
echo " GENERATING REQUESTS FROM BOTH CLUSTER1 & CLUSTER2"
echo "****************************"

source 2-test.sh

sleep 3

echo "****************************"
echo " SCALING DOWN CLUSTER-1 TO SHOW THAT CLUSTER-1 WILL NOW BE SERVICED BY CLUSTER 2"
echo "****************************"

source 3-scale-down-cluster1.sh
sleep 5

echo "****************************"
echo " GENERATING REQUESTS FROM BOTH CLUSTER1 & CLUSTER2"
echo "****************************"

source 2-test.sh

sleep 10

echo "****************************"
echo " SCALE BACK UP CLUSTER-1 SO CLUSTER-1 WILL SWITCH BACK TO USING ITS LOCAL CLUSTER-1 FIRST"
echo "****************************"


source 4-scale-up-cluster1.sh
sleep 3

echo "****************************"
echo " GENERATING REQUESTS FROM BOTH CLUSTER1 & CLUSTER2"
echo "****************************"

source 2-test.sh
