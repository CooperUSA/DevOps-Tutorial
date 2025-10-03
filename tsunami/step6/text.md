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

On the next page we will break down each part of this file.