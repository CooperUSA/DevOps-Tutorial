# Running Tsunami

Now that we have a container, we can run Tsunami against our Docker network.  
In this tutorial, we’ll scan only **port 8080**, since that’s the only service we’re interested in:

```bash
docker exec tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773"
```{{exec}}


In a real-world scenario, you might scan all open ports to discover unauthorized or suspicious services.  Here, we’re limiting the scan to a known legitimate service to focus on potential issues specific to it.