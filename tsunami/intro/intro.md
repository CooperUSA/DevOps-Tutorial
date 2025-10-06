In this tutorial we will set up the tool [Tsunami](https://github.com/google/tsunami-security-scanner) and show how it can be used to scan an endpoint for advanced vulnerabilities. We will then integrate it into a CI/CD pipeline.

This is particularly relevant for DevOps and DevSecOps practices, as integrating vulnerability scanning into a CI/CD pipeline allows teams to detect potential issues early, before the code is deployed to production. Catching vulnerabilities early reduces security risks and aligns with the core principles of DevSecOps.

## Agenda
We’ll start by getting some background on what Tsunami is and how it works. Next, we’ll explore a vulnerable web server that has been set up in advance, examining its behavior to understand what makes it insecure.

We’ll then learn how to set up Tsunami and use it to scan the web server for vulnerabilities. After identifying a vulnerability, we’ll update the web server to a secure version and demonstrate that Tsunami no longer detects the issue once it has been patched.

Finally, we’ll show how Tsunami can be integrated into a CI/CD pipeline to automatically run scans during builds or deployments.

```
         Start
           |
+----------v----------+ 
| Intro & Setup       |
|  - Motivation       |
|  - Agenda / ILO     |
|  - Background       |
+----------v----------+
           |
+----------v----------+
| Tsunami Hands-On    |
|  - Explore Vuln     |
|  - Pull Image       |
|  - Run & Analyze    |
+----------v----------+
           |
+----------v----------+
| Update server       |
|  - Re-test          |
+----------v----------+
           |
+----------v----------+
| Integration with    |
|      CI/CD          |
+----------v----------+
           |
           v
          End
```


## Intended Learning Outcomes
By the end of this tutorial, you will understand how to 
- Detect and remediate web application vulnerabilities using the Tsunami Security Scanner. 
- Gain hands-on experience on: 
    - How to configure and run Tsunami.
    - Scanning a target service for known vulnerabilities. 
    - Interpreting the scan results.
    - Verifying remediation by patching the vulnerable service. 
- Additionally, you will learn how Tsunami can be integrated into CI/CD pipelines to enable continuous and automated security testing.