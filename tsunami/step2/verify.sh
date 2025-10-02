# Check that the Tsunami container exists
if [ $( docker ps | grep tsunami-con | wc -l ) -eq 0 ]; then
  echo "The tsunami container 'tsunami-con' isn't running or doesn't exist"
  exit 1
fi

# Check if nmap exists inside the container 'tsunami-con'
if docker exec tsunami-con command -v nmap >/dev/null 2>&1; then
    echo "nmap is installed inside the container"
else
    echo "nmap is NOT installed inside the container"
    exit 1
fi