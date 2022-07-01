#### Install & Run Docker
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
```

#### Install fass-cli 
```
curl -sL https://cli.openfaas.com | sudo sh
```

#### Install fass on Docker 
```
docker swarm init
```

#### Install fass on Docker
```
git clone https://github.com/openfaas/faas
cd faas
./deploy_stack.sh
```
You Will see the password and command for login on terminal, Copy that and save it somewhere.

#### Login into the FASS using CLI
```
echo -n RJ2vz817i1lfn5s8Al511gIlK | faas-cli login --username=admin --password-stdin
```

#### Now you should able to Access below page (If not revisit the configuration)
- http://127.0.0.1:8080/ui/ 
- Login Using Above Credentials

#### Reference
- Install fass-cli
https://docs.openfaas.com/tutorials/cli-with-node/

- Install fass on Docker 
https://docs.openfaas.com/deployment/docker-swarm/

- If You face problem regarding login. you have to change
```
docker-compose.yml
Line No : 24
auth_proxy_url: "http://basic-auth-plugin:8080/validate"
```