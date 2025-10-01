We want to run Tsunami again to ensure that no vulnerabilities are still present. We will run the same command as last time:

```bash
docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector"
```{{exec}}

This time in the output we should see that it says `# of detected vulnerability: 0.`{{}}, shwoing that our vulnerability is now fixed.