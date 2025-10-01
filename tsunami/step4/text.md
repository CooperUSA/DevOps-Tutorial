Now that we see that we can detect the vulnerability, we must also convince ourselves that if we fix the vulnerability, it won't show up. 

Fixing this vulnerability simply involves updating the server to a newer version. The web server is defined within the `webserver.Dockerfile` file in the root directory.

```bash
cat webserver.Dockerfile
```{{exec}}

To then update the server we can simply replace the version to 2.4, this will provide us with the latest release of httpd 2.4 as opposed to specifically 2.4.49. You can either make this change manually with your favourite text editor, or for the sake of automation we can run the command below:

```bash
sed 's/2.4.49/2.4/' webserver.Dockerfile
```{{exec}}

Now that we have changed the Dockerfile, we want to actually make sure the server is updated, for this we'll simply kill and restart the server. No need for anything fancy.

```bash
docker kill webserver
docker remove webserver
docker build -t webserver -f webserver.Dockerfile .
docker run -dit --name webserver -p 8080:80 webserver
```{{exec}}
