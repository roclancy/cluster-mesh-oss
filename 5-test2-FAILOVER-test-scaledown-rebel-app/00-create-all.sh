echo "****************************"
echo " CAUSING FAILURE ON CLUSTER-2"
echo "****************************"


source 1-scale-down-REBEL-BASE.sh

sleep 3

source 2-test-failover.sh