In this tutorial we will set up the tool [Tsunami](https://github.com/google/tsunami-security-scanner) and show how it can be used to scan an endpoint for advanced vulnerabilities. We will then integrate it into a CI/CD pipeline.

This is particularly relevant for DevOps and DevSecOps practices, as integrating vulnerability scanning into a CI/CD pipeline allows teams to detect potential issues early, before the code is deployed to production. Catching vulnerabilities early reduces security risks and aligns with the core principles of DevSecOps.

## Agenda
We’ll start by getting some background on what Tsunami is and how it works. Then we'll
exploring a vulnerable web server that's already set up, examining its behavior and understanding what makes it insecure. Next, we’ll learn how to set up Tsunami and use it to scan the web server for vulnerabilities.

Once we identify the vulnerability, we’ll update the web server to a secure version to demonstrate that Tsunami no longer detects the issue after it has been patched. Finally, we’ll demonstrate how Tsunami can be integrated into a CI/CD pipeline to automatically run scans during builds or deployments.

## Intended Learning Outcomes
By the end of this tutorial, you will understand how to detect and remediate web application vulnerabilities using the Tsunami Security Scanner. You will gain hands-on experience on how to configure and run Tsunami, scanning a target service for known vulnerabilities, interpreting the scan results, and verifying remediation by patching the vulnerable service. Additionally, you will learn how Tsunami can be integrated into CI/CD pipelines to enable continuous and automated security testing.


 [Mayber explain how tsunami works, like it has a port scanning phase, a fingerprinting phase and finally a vulnerability detection phase.]: #
