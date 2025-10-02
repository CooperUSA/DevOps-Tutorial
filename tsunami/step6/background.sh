mkdir repo
cp -r public-html repo/public-html
cp httpd.conf repo
cp webserver.Dockerfile repo
mkdir repo/.github
mkdir repo/.github/workflow
cd repo
git init
git branch -m main