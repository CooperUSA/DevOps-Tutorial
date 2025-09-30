# Setting up Tsunami 

To use Tsunami we need build up the tool, the easiest way being to use their own Docker image to help you build and use Tsunami. Therefore, we need to first pull that docker image by running this code:

```bash
docker pull ghcr.io/google/tsunami-scanner-full
```{{exec}}

And now we want to run the image:

```bash
docker run -it --rm ghcr.io/google/tsunami-scanner-full bash
```{{exec}}

Now that we're inside the docker image, we want to run tsunami on our local network. However, we only want to inspect port 8080, as we only have one service which is on that port. 

```bash
tsunami --ip-v4-target=127.0.0.1 --port-ranges-target=8080
```{{exec}}

In normal situation we can analyze all our ports to look for illegitimate services. However, we're only intrested in looking for issues with our legitimate services, and we know where they are.
