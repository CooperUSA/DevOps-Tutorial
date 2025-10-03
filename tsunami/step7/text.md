
## Headers

The first few lines of the file simply specify a name for the action, when it should run (in this case when pushing to main), and what infrastructure it should run on (latest ubuntu version).

```yml
name: Check web server for vulnerability using tsunami

on:
  push:
    branches:
      - main

jobs: 
  everything: 
    runs-on: ubuntu-latest
```{{}}


## Download tsunami

Then to make the runner download tsunami, we add it as a service container. This will download the container to be used within the current action. We do this using the code below.

```yml
    services:
      tsunami:
        image: ghcr.io/google/tsunami-scanner-full:latest
```{{}}

## Checkout repository

We then want the runner to download the repository, this can be done by for example by using the predefined checkout action. This requires a few extra things to be set up, namely a personal access token providing write access to contents, and read access to secrets. The repository then needs to be set up with a repository secret, here named `ACTIONS_AUTH_TOKEN`{{}} containing the previously configured personal access token token. Other methods that work are obviously also fine.

```yml
    steps:
      - name: Clone repository files
        uses: actions/checkout@v5
        with:
          token: ${{ secrets.ACTIONS_AUTH_TOKEN }}
```{{}}

## Download and configure web server

Then we want to setup the web server. For this we manually run docker to setup our dockerfile like we have done previously within this tutorial. This will obviously differ in case your infrastructure is set up in a different way, but this matches how we set things up previously in this tutorial.

```yml
      - name: Web server setup
        shell: bash
        run: | 
          docker build -t webserver -f webserver.Dockerfile .
          docker run -dit --name webserver -p 8080:80 webserver
```{{}}

## Set up the tsunami container

Then we need to set up the tsunami container with nmap, as it does not come included, just like previously.

```yml
      - name: Tsunami container setup
        shell: bash
        run: |
          docker run -di --name tsunami-con ghcr.io/google/tsunami-scanner-full:latest
          docker exec tsunami-con bash -c "apt-get update && apt-get install -y nmap"
```{{}}

## Run tsunami

Finally, with everything else set up, we configure the step that will run tsunami against the web server. Fundamnetally we use the same command as we showed previously within this tutorial. We redirect the output of this command to a file, and we then read the file to find if there are any vulnerabilities. The number of vulnerabilities found is extracted and shown in the output log. 

grep is then used again generate an appropriate status code so the runner succeeds when there are no vulnerabilities present, and fails when there are.

```yml
      - name: Execute tsunami against the web server
        shell: bash
        run: |
          echo "[INFO] Running tsunami"
          docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector" 2> output.txt
          echo "[INFO] Tsunami execution finished"
          cat output.txt | grep vulnerability
          grep -q "vulnerability: 0" output.txt
```{{}}

The same changes as discussed previously can also be made here, for example using more detectors or scanning more ports.