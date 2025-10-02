# Check that the Tsunami container exists
if [ $( docker ps | grep tsunami-con | wc -l ) -eq 0 ]; then
  echo "The tsunami container 'tsunami-con' isn't running or doesn't exist"
  exit 1
fi

