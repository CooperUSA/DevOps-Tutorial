mkdir repo
cp -r public-html repo/public-html
cp httpd.conf repo
cp webserver.Dockerfile repo
mkdir repo/.github
mkdir repo/.github/workflows
cd repo
git init
git branch -m main


cat > ./.github/workflows/tsunami.yml << EOF
name: Check web server for vulnerability using tsunami

on:
  push:
    branches:
      - main

jobs: 
  everything: 
    runs-on: ubuntu-latest

    services:
      tsunami:
        image: ghcr.io/google/tsunami-scanner-full:latest

    steps:
      - name: Clone repository files
        uses: actions/checkout@v5
        with:
          token: \${{ secrets.ACTIONS_AUTH_TOKEN }}

      - name: Web server setup
        shell: bash
        run: | 
          docker build -t webserver -f webserver.Dockerfile .
          docker run -dit --name webserver -p 8080:80 webserver
  
      - name: Tsunami container setup
        shell: bash
        run: |
          docker run -di --name tsunami-con ghcr.io/google/tsunami-scanner-full:latest
          docker exec tsunami-con bash -c "apt-get update && apt-get install -y nmap"

      - name: Execute tsunami against the web server
        shell: bash
        run: |
          echo "[INFO] Running tsunami"
          docker exec tsunami-con tsunami --ip-v4-target=172.17.0.1 --port-ranges-target=8080 --detectors-include="ApacheHttpServerCVE202141773VulnDetector" 2> output.txt
          echo "[INFO] Tsunami execution finished"
          cat output.txt | grep vulnerability
          grep -q "vulnerability: 0" output.txt

EOF


