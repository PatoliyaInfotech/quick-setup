#### Verify Kubernet Installation
```
kubectl version --client
```

#### Deploy the whole stack
```
kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml
```

#### Set the Password
```
export PASSWORD=l454uDfi3Gb0fG6Y7v33wdfZ5
kubectl -n openfaas create secret generic basic-auth \
--from-literal=basic-auth-user=admin \
--from-literal=basic-auth-password="$PASSWORD"
```

#### Deploy OpenFaaS into cluster
```
git clone https://github.com/openfaas/faas-netes
cd faas-netes
kubectl apply -f ./yaml
- wait for 120 seconds until everything has been up
kubectl get deploy -n openfaas
```

#### Port Forwarding OpenFaaS
```
kubectl port-forward svc/gateway -n openfaas 8080:8080 &
```

#### Install the faas-cli (Do it if it's not done)
```
curl -sL https://cli.openfaas.com | sudo sh
```

#### Login into OpenFaaS
```
export PASSWORD=l454uDfi3Gb0fG6Y7v33wdfZ5
export OPENFAAS_URL=http://127.0.0.1:8080
export OPENFAAS_URL=http://localhost:8080
echo -n $PASSWORD | faas-cli login --username=admin --password-stdin
```

#### Verify external IP Address
```
kubectl get -n openfaas svc/gateway-external
```

#### Check which service using this PORT
```
lsof -i :8080
lsof -i :31112
```

#### List OpenFaaS services
```
kubectl get deploy -n openfaas
```

#### View the PODS status
```
kubectl get pods
```

#### Now you should able to Access below page (If not revisit the configuration)
- http://127.0.0.1:8080/ui/ 
- Login Using Above Credentials

#### Verify using CURL
```
curl -4 127.0.0.1:8080
curl -4 127.0.0.1:3112
```

#### Remove everything
```
kubectl delete namespace openfaas openfaas-fn
kind delete cluster
rm -rf /usr/local/bin/faas-cli
rm -rf ~/.openfaas
- Verify removal
kind get clusters
```

#### Extra Commands
```
kubectl expose deployment gateway --type=LoadBalancer --name=my-service  -n openfaas
```

#### References
- Installation
```
https://docs.openfaas.com/deployment/kubernetes/
https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux
https://kubernetes.io/docs/setup/learning-environment/minikube/#starting-a-cluster
http://raman-kumar.blogspot.com/2018/06/fixed-bash-usrlocalbinkubectl-cannot.html
```

- k8s
```
https://kind.sigs.k8s.io/docs/user/quick-start/
```

- Install Virtual Box Driver
```
https://minikube.sigs.k8s.io/docs/reference/drivers/virtualbox/
```

- Minicube
```
https://minikube.sigs.k8s.io/docs/drivers/docker/
```

- Forgot password
```
https://docs.openfaas.com/deployment/troubleshooting/#i-forgot-my-gateway-password_1
```