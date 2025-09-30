set -x      # Show commands in logs for debugging
echo "[*] Starting background setup..."


# Ensure the Docker daemon is active
if ! systemctl is-active --quiet docker; then
    systemctl start docker


# Setup the vulnerable web server (automatically)

cat > webserver.Dockerfile << EOF
FROM httpd:2.4.49
COPY ./public-html/ /usr/local/apache2/htdocs/
COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf" > webserver.Dockerfile
EOF

echo "[*] Startup done"