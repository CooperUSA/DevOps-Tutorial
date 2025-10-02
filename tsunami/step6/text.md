We will now look at how this can be integrated within a CI/CD pipeline. Specifically we will look at the setup to integrate tsunami automatically checking the web server for vulnerabilities into a github actions workflow. 

A directory named `repo`{{}} has automatically been created, and the server files have been copied into it and a git repository has been initiated there. 

```bash
cd repo
ls -la
```{{exec}}

We then want to add our workflow. To do this, we'll navigate further into the .github/workflows directory.

```bash
cd .github/workflows
```{{exec}}

The workflow we need to add has to do a few things:
1. Download Tsunami
2. Checkout the repository
3. Download and configure the web server using our local docker image
4. Configure tsunami
5. Run tsunami against the web server, and detect within the output if there are any vulnerabilities

The file `tsunami.yml`{{}} has been automatically created and will do the steps above, we can explore it by running:

```bash
cat tsunami.yml
```{{exec}}

We will now break the file down piece by piece.

## Download tsunami

To make the runner download tsunami, we add it as a service container. This will include the container within the current job. We do this using the code below.

```yml
    services:
      tsunami:
        image: ghcr.io/google/tsunami-scanner-full:latest
```{{}}

## Checkout repository

We then want the runner to download the repository, this can be done by for example by using the predefined checkout action. This requires a few extra things to be set up, namely a personal access token providing write access to contents, and read access to secrets. The repository then needs to be set up with a repository secret, here named `ACTIONS_AUTH_TOKEN`{{}} containing the token. Other methods that work are obviously also fine.

```yml
    steps:
      - name: Clone repository files
        uses: actions/checkout@v5
        with:
          token: ${{ secrets.ACTIONS_AUTH_TOKEN }}
```{{}}

## Download and configure web server

Then we want to setup the web server. For this we manually run docker to setup our dockerfile like we have done previously within this tutorial. 

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
      - name: Execute tsunami on the web server
        shell: bash
        run: |
          echo "[INFO] Running tsunami"
          docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector" 2> output.txt
          echo "[INFO] Tsunami execution finished"
          cat output.txt | grep vulnerability
          grep -q "vulnerability: 0" output.txt
```{{}}

The same changes as discussed previously can also be made here, for example using more detectors or scanning more ports.