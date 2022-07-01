## Kubernetes requires at least 2 to be available

#### Install Minicube
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
mv ./minikube /usr/local/bin/minikube
```

### Add new User
```
adduser developer
# password@7
usermod -aG sudo dev
```

### Login to the newly created User
```
su - developer
# password@7
```

### Add User to the Docker Group
```
sudo groupadd docker
sudo usermod -aG docker $USER && newgrp docker
- Re-Login or Restart the Server
```

#### Start minikube with Docker Driver
```
minikube start --driver=docker
``` 

#### Verify minikube Installation
```
docker ps
```

#### Remove Minicube
```
rm /usr/local/bin/minikube
```

#### References
- Post-installation steps for Linux
```
https://docs.docker.com/engine/install/linux-postinstall/
```

- Minicube
```
https://kubernetes.io/docs/setup/learning-environment/minikube/#starting-a-cluster
https://minikube.sigs.k8s.io/docs/drivers/docker/
```