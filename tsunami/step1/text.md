While on the intro page, a vulnerable apache httpd web-server was automatically set up. We will first look at this vulnerability, understand what has gone wrong, and then see if we can automatically detect it. 

Within the current directory we have a few files, among which are `httpd.conf`{{}}. This configuration file is poorly configured, and with httpd version 2.4.49, that is vulnerable to CVE-2021-41773, will allow path traversal across the full filesystem running the server, in our case a docker container.

```bash
cat httpd.conf | grep "#" -C 3
```{{exec}}

When executing the above command we can find that the configuration explicitly allows all directories to be accessed. The idea is that this is all directories within the web server's own directory. However, in the specific version of apache used there is an issue with the path normalization, enabling path traversal. We can experience this ourselves with the command below:

```bash
curl http://localhost:8080/cgi-bin/.%2e/.%2e/.%2e/.%2e/.%2e/etc/passwd
```{{exec}}

There we can clearly see that the exploit works, and thus that the web server we have set up is vulnerable.

In the next step we will set up a tsunami container which we can use to detect the vulnerability automatically.