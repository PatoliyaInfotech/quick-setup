#### Creates a simple function
- Build A Function (This has to be done after making every changes to the app)
```
faas-cli new callme --lang node
faas-cli build -f callme.yml 
faas-cli deploy -f callme.yml
```

- Invoke the function through terminal
```
faas-cli invoke -f callme.yml callme
```

#### Verify your function into the OpenFass UI
- http://127.0.0.1:8080/ui/ 

#### References
```
https://docs.openfaas.com/tutorials/cli-with-node/
https://docs.openfaas.com/reference/cron/#simple-cron-job
```

#### Ready to Use Templates 
```
https://docs.openfaas.com/cli/templates/
```