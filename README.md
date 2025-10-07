
# Overview <BR>
In this repo is a demo and number of tests/demo for OSS cilium Cluster Mesh, This has been created and tested on MAC OS <br>

This repo will create the following using Kind and docker
- Create 2 x Kubernetes clusters (using Kind)
- Install and connect both clusters using Cluster Mesh
- Provide a number of tests/demo that you can run to see Cluster Mesh capabilities (these tests/demo are not an exhustive list of Cluster Mesh capabilites).

# 1 - Prerequisites 
<br>
You will need the following installed

1) Docker / Docker Desktop - https://docs.docker.com/desktop/setup/install/mac-install/
2) Kind - The easiest way on a Mac book is to use Brew command "brew install kind" - https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-a-package-manager

# 2 - Setup & install 
1) Clone this git to your machine / mac book
2) Change to directory 1-clusters
3) In this directory run the command "source 00-create-all.sh" <br>
- This will now create 2 x Kuberentes clusters using Kind and create contains in your docker desktop
- After the 2 new clusters are created check you can see them in the kube.conf file - use command "kubectl config get-contexts"
- You should see 2 clusters named "kind-cluster1 and kind-cluster2"
<br>
<br> <img width="366" height="205" alt="image" src="https://github.com/user-attachments/assets/fd99d399-6ea1-4afa-812f-30406106222d" /> <br>
<br>
4) Now Connect the 2 new kubernetes cluster created using Cluster Mesh <br>
<br>
- Change to directory called "2-connect-clusters" <br>
- Now run command "source 00-create-all.sh" <br>
- This will now connect both the newly created clusters kind-cluster1 & kind-cluster2 using clustermesh <br>
- Finally it will run a status command for Cluster Mesh and print out the results - wait until it displays all connected this can take a few minuites <br>
<br>
<img width="649" height="208" alt="image" src="https://github.com/user-attachments/assets/3a9cade2-157c-45ec-9977-039ecf1e5e6b" /><br>
<br>
5) Now we create some workload, services and some data that each workload will hold, and deploy this to both kubernetes clusters we created, the workloads are called xwing and rebel-base <br>
<br>
The scripts in the tests/demo below will use these workloads for requests and pull data (which is held created using a config-map) from the rebel app which is different on each cluster.<br>
<br>
- Change to directory called "3-deploy-apps-both-clusters" <br>
- Now run command "source 00-create-all.sh" <br>
- This will now deploy the workloads, create the services and config-map for each workload to hold data and then enable port-forwarding for the Hubble UI <br>
- The script to create the workloads will also create a series of requests and will output the values, you will see the request being service by the cluster the request came from (it is not load balancing at this point this will be enabled in the tests below)<br>
<br>
<img width="594" height="197" alt="image" src="https://github.com/user-attachments/assets/c8c91371-6aa3-42ab-a498-fea6e1cdb99e" /> <br>
<br>
- Once it has all completed put http://127.0.0.1:12000 in your browser and you will see the Hubble UI, select default namespace <br>
<br>
<img width="380" height="569" alt="image" src="https://github.com/user-attachments/assets/2e0e0b15-ee32-4ceb-9ac6-ad59718ab87a" /> <br>
<br>
  
# 3 - Run tests to demonstrate Cluster Mesh capabilities
Now we have 2 clusters created and connected we can run some tests to demonstrate various senarios, each test is located in its own directory and has a single command to activate the test and view the result.
Each test will print out into your terminal the output result of each script, look for the descritions which help explain more about the outcome of the scripts test.

## Test 1 - Creating a Cluster Mesh load balancer and seeing how traffic is routed 
This test/demo has a number of tasks it performs, <br>
<br>
1st it will print out how a request is serviced BEFORE the load balancer is enabled, <br>
2nd it will then enable the load balancer, <br>
3rd it will again create some requests and you will see how the load balancer now load balances the request AFTER being enabled between both clusters. <br>
<br>
Follow the steps below to run the script and perform the tests:

1) Change into directory called "4-test1-GLOBAL-LB-make-cluster-global-BOTH-CLUSTERS"
2) Now from the same directory using your terminal run command "source 00-create-all.sh"
- The script runs fast, once completed look at the output. You will see the before and after and how the request are now being handled by the load balancer from cluster1 and cluster2
<br>
<img width="432" height="271" alt="image" src="https://github.com/user-attachments/assets/cc4b34d4-99c3-4334-a389-65c78687f9cb" /><br>
<img width="287" height="206" alt="image" src="https://github.com/user-attachments/assets/ab15239f-a90a-4b3e-8067-ad056815cdea" /> <br>
<br>

3) In the Hubble UI you can see the connections and request being made as the script ran, notice the cluster name in each pods (cluster1 and cluster2) click on xwing and you will see requests being serviced from rebel-base in cluster 1 and 2 (this is the load balancing in action) <br>
<br>
<img width="1482" height="287" alt="image" src="https://github.com/user-attachments/assets/02bc132f-c7ce-4392-9ff1-db23c0a1ed5c" /><br>
<br>
<img width="810" height="477" alt="image" src="https://github.com/user-attachments/assets/bd058f6d-1e33-4a9b-b463-320a3a6850ef" /><br>
<br>

## Test 2 - Cluster Mesh High Avalability / Failover test
This test/demo has a number of tasks it performs, <br>
<br>
1st The script will scale down the pods rebel-base (which resond to requests for x-wing) simulating a failure of workloads on cluster2 <br>
2nd The script will generate requests from both x-wing workloads on both clusters1 & cluster2, this will cause the loadbalancer to route the requests to the only working rebel-base pods which are on cluster1<br>
<br>
Follow the steps below to run the script and perform the tests: <br>
1) Change into directory called "5-test2-FAILOVER-test-scaledown-rebel-app" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script output showing it is scaling down cluster2 and then all requests are serviced (via the load balancer) from the only remaining pod rebel-base which is on cluster1
<br>
<img width="285" height="295" alt="image" src="https://github.com/user-attachments/assets/ef8d0171-625d-424b-ab1f-6d6dc75020a0" /> <br>
<br>

Now restore the rebel-base pods on cluster2, marking the end of the failure outage, this will cause the load balancer to learn that the cluster2 rebel-pods are back and will then start load balancing between cluster1 and cluster2 as it did before the failure.
<br>
Follow the steps below to run the script and perform the tests: <br>
1) Change into directory called "6-test3-scale-back-rebel-base" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script scale up the rebel-base pods on cluster2 and then generate a number of request to show the load balancer is again load balancing between cluster1 and cluster2 <br>
<br>
<img width="610" height="333" alt="image" src="https://github.com/user-attachments/assets/2bae2e05-a0c5-4f8a-b5f6-2f1548231425" /> <br>
<br>

## Test 3 - Remove a cluster from the Cluster Mesh Load Balancer
This test/demo has a number of tasks it performs, <br>
<br>
1st The script will set an annotation on cluster1, this label will inform Cluster Mesh that it can no longer use cluster1 to load balance requests for other clusters, even though we are removing cluster1 from the Cluster Mesh load balancer cluster1 will still service requests from its own cluster1 requests and will also get serviced by cluster2 also. Requests from cluster2 will ONLY get serviced by cluster2 as cluster1 has been removed from the Cluster Mesh load balancer.  <br>
<br>
2nd The script will generate requests from both x-wing workloads on both clusters1 & cluster2, and you will see Cluster2 requests are only serviced by cluster2 where as request from cluster1 are serviced by cluster1 & Cluster2 <br>
<br>
Follow the steps below to run the script and perform the tests: <br>
1) Change into directory called "7-test4-remove-cluster1-from-global" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script remove cluster1 from the Cluster Mesh avaliable global load balancers and generate requests from both cluster1 and cluster2 <br>
<br>
<img width="375" height="426" alt="image" src="https://github.com/user-attachments/assets/0d2db452-fbe9-4b50-8f53-014c8e98212b" /> <br>
<br>
Now restore cluster1 back to Cluster Mesh list of availble clusters to load balance requests too, so all request will be service by cluster1 & cluster2 once restored. <br>
<br>
Follow the steps below to run the script and perform the tests: <br>
<br>
1) Change into directory called "8-test5-restore-cluster1-to-global-lb" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script restore cluster1 back to the pool of avalible cluster and generate requests from both clusters1 & Cluster2 and how the requests are services. <br>
<br>
<img width="370" height="337" alt="image" src="https://github.com/user-attachments/assets/24f5bf31-c451-4d91-9524-453ea5e35ec4" /> <br>
<br>

## Test 4 - Affinity - Define where a request should be serviced from - Local
<br>
This test will show how the Cluster Mesh load balancer can keep requests local to the cluster by setting an Affinity. (you can also set a remote Affinity so requests would be serviced by a remote cluster we don't show that in this test but the process is the same except we specify remote and not local ) <br>
<br>
Affinity defines where a request should be serviced from first (in this case local to where the request came from) but if that first option (local Affinity) was to fail the Cluster Mesh load balancer would then route the request to the other load balancers from its pool of clusters availiable, there by ensuring the request is serviced even if affinity is set and that affinity cluster fails. This is what we will demonstrate in this test / demo.<br>
<br>
This test/demo has a number of tasks it performs, <br>
<br>
- 1st The script will set an affinity of local to cluster1, meaning all requests from cluster1 are to be serviced from cluster1 as first option <br>
- 2nd The script will generate requests and output the results AFTER the local affinity has been set, you will see cluster1 requests are only serviced by cluster1 <br>
- 3rd The script will scale down the pods on cluster1 that are servicing request (causing a failure of service) this will force the Cluster Mesh load balancer to load balance request from cluster1 to the other availible clusters in the cluster Mesh global load balancer pool.<br>
- 4th The script will generate requests from cluster1 & cluster2 AFTER the scaling down (simulated failure) of pods (rebel-base) on cluster1 and you will see all request serviced by cluster2 <br>
- 5th The script will then scale back up cluster1 (restoring the rebel-base pods) <br>
- 6th The will generate requests AFTER the scale back up of pods on cluster1 (remove the failure) has been restored and how the Cluster Mesh global load balancer goes back to servicing request base on the affinity, which is local <br>
<br>
Follow the steps below to run the script and perform the tests: <br>
1) Change into directory called "9-test6-affinity-cluster1-local-first" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script perform all the tasks listed above and print out the results <br>
<br>
<img width="433" height="428" alt="image" src="https://github.com/user-attachments/assets/267c9ede-282a-4eac-8024-d6441dc04008" /> <br>
<img width="585" height="422" alt="image" src="https://github.com/user-attachments/assets/290558d9-2b9c-4dee-ae4e-c450999dca84" /> <br>
<img width="642" height="425" alt="image" src="https://github.com/user-attachments/assets/aeb10361-446d-44de-a543-b7a0185781bf" /> <br>
<br>
<br>
Now remove the affinity to restore back to the Cluster Mesh global load balancer to load balance <br>
<br>
Follow the steps below to run the script and perform the tests: <br>
<br>
1) Change into directory called "10-test7-remove-affinity-local" <br>
2) Now from the same directory using your terminal run command "source 00-create-all.sh" <br>
- you will see the script perform all the tasks listed above and print out the results <br>
<br>
<img width="389" height="423" alt="image" src="https://github.com/user-attachments/assets/75d8cbea-48bd-47dd-b7f8-a023a45c942d" /> <br>
<br>












  

