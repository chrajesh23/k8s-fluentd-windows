
## prerequisites

- 1  eks cluster with windows node.
    to create new cluster
    - install eksctl 
    - issue below command to create cluster
    
    ```
    eksctl create cluster -f tested/eks/1-cluster-spec.yaml --install-vpc-controllers
    ```

    output

    ```
[ℹ]  eksctl version 0.13.0
[ℹ]  using region us-west-2
[!]  Windows VPC resource controller is required to run Windows workloads
[!]  install it using 'eksctl utils install-vpc-controllers --name=windows-prod --region=us-west-2 --approve'
[ℹ]  setting availability zones to [us-west-2c us-west-2d us-west-2b]
[ℹ]  subnets for us-west-2c - public:192.168.0.0/19 private:192.168.96.0/19
[ℹ]  subnets for us-west-2d - public:192.168.32.0/19 private:192.168.128.0/19
[ℹ]  subnets for us-west-2b - public:192.168.64.0/19 private:192.168.160.0/19
[ℹ]  nodegroup "windows-ng" will use "ami-0768280a62a0519f5" [WindowsServer2019FullContainer/1.14]
[ℹ]  using Kubernetes version 1.14
[ℹ]  creating EKS cluster "windows-prod" in "us-west-2" region with managed nodes and un-managed nodes
[ℹ]  2 nodegroups (linux-ng, windows-ng) were included (based on the include/exclude rules)
[ℹ]  will create a CloudFormation stack for cluster itself and 1 nodegroup stack(s)
[ℹ]  will create a CloudFormation stack for cluster itself and 1 managed nodegroup stack(s)
[ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-west-2 --cluster=windows-prod'
[ℹ]  CloudWatch logging will not be enabled for cluster "windows-prod" in "us-west-2"
[ℹ]  you can enable it with 'eksctl utils update-cluster-logging --region=us-west-2 --cluster=windows-prod'
[ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "windows-prod" in "us-west-2"
[ℹ]  2 sequential tasks: { create cluster control plane "windows-prod", 2 parallel sub-tasks: { create nodegroup "windows-ng", create managed nodegroup "linux-ng" } }
[ℹ]  building cluster stack "eksctl-windows-prod-cluster"
[ℹ]  deploying stack "eksctl-windows-prod-cluster"
[ℹ]  building managed nodegroup stack "eksctl-windows-prod-nodegroup-linux-ng"
[ℹ]  building nodegroup stack "eksctl-windows-prod-nodegroup-windows-ng"
[ℹ]  --nodes-max=1 was set automatically for nodegroup windows-ng
[ℹ]  deploying stack "eksctl-windows-prod-nodegroup-linux-ng"
[ℹ]  deploying stack "eksctl-windows-prod-nodegroup-windows-ng"
[✔]  all EKS cluster resources for "windows-prod" have been created
[✔]  saved kubeconfig as "/home/vijay/.kube/config"
[ℹ]  adding identity "arn:aws:iam::501361998365:role/eksctl-windows-prod-nodegroup-win-NodeInstanceRole-1KRMVDVXGXRW4" to auth ConfigMap
[ℹ]  nodegroup "windows-ng" has 0 node(s)
[ℹ]  waiting for at least 1 node(s) to become ready in "windows-ng"
[ℹ]  nodegroup "windows-ng" has 1 node(s)
[ℹ]  node "ip-192-168-74-79.us-west-2.compute.internal" is ready
[ℹ]  nodegroup "linux-ng" has 1 node(s)
[ℹ]  node "ip-192-168-1-142.us-west-2.compute.internal" is ready
[ℹ]  waiting for at least 1 node(s) to become ready in "linux-ng"
[ℹ]  nodegroup "linux-ng" has 1 node(s)
[ℹ]  node "ip-192-168-1-142.us-west-2.compute.internal" is ready
[ℹ]  kubectl command should work with "/home/vijay/.kube/config", try 'kubectl get nodes'
[✔]  EKS cluster "windows-prod" in "us-west-2" region is ready

    ```

- 2 create User using authentication section to access cloudwatch logs
    https://github.com/fluent-plugins-nursery/fluent-plugin-cloudwatch-logs

    incase of using IAM user, make sure you give only cloudwatch logs.


## Fluentd Daemonset deployment

# Step 1

create new namespace 
```
kubectl apply -f tested/eks/2-cloudwatch-namespace.yaml
```

# step 2  (Optional)

 Incase of building custom image
    - build docker image from tested/docker/build.txt and update in tested/eks/3-fluentd-cloudwatch-windows-deamonset.yaml

# Step 3 

configure configmap, incase of using IAM secrets provide <access-key> and <sec-key>  

```
kubectl create configmap cluster-info \
--from-literal=cluster.name=windows-prod \
--from-literal=logs.region=us-west-2 \
--from-literal=logs.aws_key_id=<access-key> \
--from-literal=logs.aws_sec_key=<sec-key> \
-n amazon-cloudwatch
```

# Step 4 

deploy deamonset using below command

```
kubectl apply -f tested/eks/3-fluentd-cloudwatch-windows-deamonset.yaml -n amazon-cloudwatch
```

validate pods
```
kubectl get pods -n amazon-cloudwatch
```

# step 5 

install loggen application or windows cotainer and test

```
kubectl apply -f tested/log-gen/Log-gen.yaml
```
or
```
kubectl apply -f tested/eks/4-windows-server-iis.yaml
```

# step 6 
Verify the FluentD Setup and cloud watch logs after you deploy application 