# Running Tsunami

Now that we have a container, we can run Tsunami against our local network.  
In this tutorial, we’ll only scan **port 8080**, since that’s the only service we’re interested in.

With the command `tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector`{{}} we will tell Tsunami to
- `--ip-v4-target=172.17.0.1`{{}}: Target the ip address for our web server
- `--port-ranges-target=8080`{{}}: Only scan port 8080 
- `--detectors-include="ApacheHttpServerCVE202141773VulnDetector`{{}}: Only check for the vulnerability [CVE-2021-41773](https://www.cve.org/CVERecord?id=CVE-2021-41773)

Now that we understand the command itself, we can run it:

```bash
docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector"
```{{exec}}

In a real-world scenario, you might scan all open ports to discover unauthorized or suspicious services. You might also wish to use all available detectors to maximize the number of vulnerabilities found. Here, we’re limiting the scan to a known legitimate service with focus on a specific vulnerability to simplify the process.

### Tsunami Results

After Tsunami has finished scanning, we should able to see something similar to this towards the end of it's output:

```
MMM dd, yyyy h:mm:ss a com.google.tsunami.plugins.detectors.cve202141773.ApacheHttpServerCVE202141773VulnDetector checkUrlWithCommonDirectory
INFO: Received vulnerable response from target http://172.17.0.1:8080/cgi-bin/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd.
MMM dd, yyyy h:mm:ss a com.google.tsunami.plugin.PluginExecutorImpl buildSucceededResult
INFO: ApacheHttpServerCVE202141773VulnDetector plugin execution finished in XX (ms)
MMM dd, yyyy h:mm:ss a com.google.tsunami.workflow.DefaultScanningWorkflow generateScanResults
INFO: Tsunami scanning workflow done. Generating scan results.
MMM dd, yyyy h:mm:ss a com.google.tsunami.workflow.DefaultScanningWorkflow lambda$runAsync$0
INFO: Tsunami scanning workflow traces:
  Port scanning phase (XX.XX s) with 1 plugin(s):
    /Tsunami Team (tsunami-dev@google.com)/PORT_SCAN/NmapPortScanner/0.1
  Service fingerprinting phase (XXX.X ms) with 1 plugin(s):
    /Tsunami Team (tsunami-dev@google.com)/SERVICE_FINGERPRINT/WebServiceFingerprinter/0.1 was selected for the following services: http (TCP, port 8080)
  Vuln detection phase (XXX.X ms) with 1 plugin(s):
    /threedr3am (qiaoer1320@gmail.com)/VULN_DETECTION/ApacheHttpServerCVE202141773VulnDetector/1.0 was selected for the following services: http (TCP, port 8080)
  # of detected vulnerability: 1.
```{{}}

This block of text is pretty much just stating the summary of the Tsunami scan, in which we can see
- `MMM dd, yyyy h:mm:ss a com.google.tsunami.plugins.detectors.cve202141773.ApacheHttpServerCVE202141773VulnDetector checkUrlWithCommonDirectory`{{}}: The **apache_http_server_cve_2021_41773** plugin detected a vulnerable response.
- `Port scanning phase (XX.XX s) with 1 plugin(s)`{{}}: We used one plugin for our port scanning phase, which was **nmap_port_scanner**.
- `Service fingerprinting phase (XXX.X ms) with 1 plugin(s)`{{}}: We used one plugin for our fingerprinting phase, which was **web_app_fingerprinter**. 
- `Vuln detection phase (XXX.X ms) with 1 plugin(s)`{{}}: We used one plugin for our vulnerability detection phase, which was **apache_http_server_cve_2021_41773**.  
- `# of detected vulnerability: 1.`{{}}: We detected 1 vulnerability.

The result is also saved in a ***.report*** file in the `/tmp`{{}} directory of the docker container. However, we won't check it as there isn't much more to get out of the result.