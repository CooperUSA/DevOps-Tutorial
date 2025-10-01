# Setting up Tsunami 

To use Tsunami, we’ll take advantage of the official **Tsunami Docker image** (the `tsunami-scanner-full` image), which provides a ready-to-use build of the scanner, the callback server used to confirm out-of-band exploits, and a large set of plugins.
In this guide, however, we’ll focus only on the following plugins:
- [nmap_port_scanner](https://github.com/google/tsunami-security-scanner-plugins/tree/master/google/portscan/nmap)
- [web_app_fingerprinter](https://github.com/google/tsunami-security-scanner-plugins/tree/master/google/fingerprinters/web)
- [apache_http_server_cve_2021_41773](https://github.com/google/tsunami-security-scanner-plugins/tree/master/community/detectors/apache_http_server_cve_2021_41773).

### Pull the Tsunami image
 
First, we want to pull the full image from GitHub Container Registry:

```bash
docker pull ghcr.io/google/tsunami-scanner-full
```{{exec}}

### Start a container   

Next, we want to start a container from that image and name it `tsunami-con`{{}}:

```bash
docker run -dit --name tsunami-con ghcr.io/google/tsunami-scanner-full
```{{exec}}

The container doesn't have `nmap`{{}}. So for us to be able to scan ports with Tsunami later we need to first install `nmap`{{}} onto the container. This can be done with:

```bash
docker exec tsunami-con bash -c "apt-get update && apt-get install -y nmap"
```{{exec}}


 [docker run -d ghcr.io/google/tsunami-scanner-full bash -c "apt-get update && apt-get install -y nmap && tail -f /dev/null"]: #

 [Runs the docker iamge and then with bash we run the command inside the container, then we keep it alive with "tail -f /dev/null". We might need to use "-i" aswell though.]: #