echo "****************************"
echo " RESTORING CLUSTER1 TO GLOBAL LOAD BALANCING"
echo "****************************"

source 1-restore-global-lb-cluster1.sh

echo "****************************"
echo " GENERATING TEST FROM BOTH CLUSTER1 & CLUSTER2"
echo "****************************"
source 2-test.sh
