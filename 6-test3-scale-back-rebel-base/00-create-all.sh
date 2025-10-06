echo "****************************"
echo " RESTORING FAILED PODS BACK TO CLUSTER-2"
echo "****************************"


source 1-scale-back-rebel.sh
sleep 10

echo "****************************"
echo " NOW GENERATING REQUESTS TO SHOW LOAD BALANCING AGAIN ACROSS CLUSTER-1 & CLUSTER-2"
echo "****************************"

source 2-test.sh