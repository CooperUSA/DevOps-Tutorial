# Running Tsunami

Now that we have a container, we can run Tsunami against our Docker network.  
In this tutorial, we’ll only scan **port 8080**, since that’s the only service we’re interested in.

With the command `tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector`{{}} we will tell Tsunami to
- Target the ip address for our web server
- Only scan port 8080 
- Only check for the vulnerability [CVE-2021-41773](https://www.cve.org/CVERecord?id=CVE-2021-41773)

```bash
docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector"
```{{exec}}


(In a real-world scenario, you might scan all open ports to discover unauthorized or suspicious services.  Here, we’re limiting the scan to a known legitimate service to focus on potential issues specific to it.)