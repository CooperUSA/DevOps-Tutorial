if [ -f "/tmp/skip" ]; then
  exit 0
fi

# Check that the Tsunami container exists
if [ $( docker ps | grep tsunami-con | wc -l ) -eq 0 ]; then
  echo "The tsunami container 'tsunami-con' isn't running or doesn't exist"
  exit 1
fi

# Check if nmap exists inside the container 'tsunami-con'
if [ -z "$(docker exec tsunami-con whereis nmap | awk '{print $2}')" ]; then
    echo "nmap is NOT installed inside the container"
    exit 1
fi