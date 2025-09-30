set -x      # Show commands in logs for debugging
echo "[*] Starting background setup..."


# Ensure the Docker daemon is active
if ! systemctl is-active --quiet docker; then
    systemctl start docker


