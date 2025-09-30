# Setting up Tsunami 

To use Tsunami, we’ll take advantage of the official **Tsunami Docker image**, which provides a ready-to-use build of the tool. Using the official image ensures we have access to all available plugins.
In this guide, however, we’ll focus only on the following plugins:
- [nmap_port_scanner](https://github.com/google/tsunami-security-scanner-plugins/tree/master/google/portscan/nmap)
- [web_app_fingerprinter](https://github.com/google/tsunami-security-scanner-plugins/tree/master/google/fingerprinters/web)
- [apache_http_server_cve_2021_41773](https://github.com/google/tsunami-security-scanner-plugins/tree/master/community/detectors/apache_http_server_cve_2021_41773).

###

First, pull the latest Tsunami Docker image by running this code:

```bash
docker pull ghcr.io/google/tsunami-scanner-full
```{{exec}}

Next, start a new container using that image:

```bash
docker run -it --rm ghcr.io/google/tsunami-scanner-full bash -c "apt-get update && apt-get install -y nmap && bash"
```{{exec}}
(Since the image doesn't have nmap, we also install it inside the container)

###

Once inside the container, we can run Tsunami against our local network.  
In this tutorial, we’ll scan only **port 8080**, since that’s the only service we’re interested in:

```bash
tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="apache_http_server_cve_2021_41773"
```{{exec}}
# tsunami --ip-v4-target=127.0.0.1 --port-ranges-target=8080

In a real-world scenario, you might scan all open ports to discover unauthorized or suspicious services.  Here, we’re limiting the scan to a known legitimate service to focus on potential issues specific to it.
