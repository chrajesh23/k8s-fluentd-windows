# Step 1

```
kubectl apply -f poc/cloudwatch-namespace.yaml
```

# step 2

- build docker image from poc/docker folder
- modify fluent conf file if you need to customize


update <<windows-fluentd-cloudwatch>> with generated docker image id at container section at -
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
Verify the FluentD Setup after you deploy application 