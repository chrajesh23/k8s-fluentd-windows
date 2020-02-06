follow  - https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

# Step 1
install eksctl 

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

```

# step 2
install eks cluster

```
eksctl create cluster -f cluster-spec.yaml --install-vpc-controllers
```

# Step3 
 When your cluster is ready, test that your kubectl configuration is correct. 
 ```
kubectl get svc
 ```