#### Install Kubernet
```
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
```

#### Set Permission for Current User
```
chmod +x ./kubectl
ls -ltrh
```

#### For Ubuntu
```
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### For MAC
```
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### Verify Installation
```
kubectl version --client
```

#### Install Kind
```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.7.0/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
```

#### Remove Kind
```
docker rm -f kind-control-plane
rm /usr/local/bin/kind
```
