#### Verify Kubernet Installation
```
kubectl version --client
```

#### Install arkade
```
curl -SLsf https://dl.get-arkade.dev/ | sudo sh
```

#### Install the OpenFaaS app into the Kubernet Cluster
```
arkade install openfaas
kubectl -n openfaas get deployments -l "release=openfaas, app=openfaas"
- wait for 120 seconds to get running all the services
kubectl rollout status -n openfaas deploy/gateway
kubectl port-forward -n openfaas svc/gateway 8080:8080 &
```

#### Get the Password
```
PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
echo $PASSWORD
```

#### Install the faas-cli (Do it if it's not done)
```
curl -sL https://cli.openfaas.com | sudo sh
```

#### Login into OpenFaaS
```
export PASSWORD=p6591jAC038k6hmsfoSor2Y1B
export OPENFAAS_URL=http://127.0.0.1:8080
echo -n $PASSWORD | faas-cli login --username=admin --password-stdin -g http://127.0.0.1:8080
```

#### Now you should able to Access below page (If not revisit the configuration)
- http://127.0.0.1:8080/ui/ 
- Login Using Above Credentials

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
kubectl get pods -n openfaas
kubectl get pods -o wide -n openfaas
kubectl get services -n openfaas
```

#### Other Commands
```
kubectl delete service gateway-external -n openfaas
kubectl delete service gateway -n openfaas
kubectl expose deployment gateway-external --type=NodePort --port=8080 -n openfaas
```

#### Verify using CURL
```
curl -4 127.0.0.1:8080
curl -4 127.0.0.1:3112
```

#### Remove everything
```
rm -rf /usr/local/bin/faas-cli
rm -rf ~/.openfaas
kubectl delete namespace openfaas openfaas-fn
kind delete cluster
kind get clusters
```

##### References
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