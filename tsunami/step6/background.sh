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
    
EOF


