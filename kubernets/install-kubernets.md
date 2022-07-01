## Kubernetes requires at least 2 to be available

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

### Remove 
rm /usr/local/bin/kubectl