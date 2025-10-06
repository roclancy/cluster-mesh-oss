
echo "****************************"
echo " SHOWING NO LOAD BALANCING BEFORE LOAD BALANCING CREATED"
echo "****************************"

source test-before-loadbalancing.sh

echo "****************************"
echo " CREATING GLOBAL LOAD BALANCING"
echo "****************************"

source 1-set-annotation-global-cluster.sh

source 2-test-after-loadbalancing.sh