# Step 1

create new namespace 
```
kubectl apply -f poc/cloudwatch-namespace.yaml
```

# step 2

- build docker image from poc/docker folder
- modify fluent conf file if you need to customize


replace "windows-fluentd-cloudwatch"  word with generated docker image id at container section at -
 poc/fluentd-cloudwatch-windows-deamonset.yaml


# Step 3 

configure map 

```

kubectl create configmap cluster-info \
--from-literal=cluster.name=cluster_name \
--from-literal=logs.region=region_name -n amazon-cloudwatch

```

# Step 4 

deploy deamonset using below command

```
kubectl apply -f poc/fluentd-cloudwatch-windows-deamonset.yaml
```

validate pods
```
kubectl get pods -n amazon-cloudwatch
```

# step 5 
Verify the FluentD Setup and cloud watch logs after you deploy application 