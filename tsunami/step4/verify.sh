if [ -f "/tmp/skip" ]; then
  exit 0
fi

if [ "$(curl http://localhost:8080/cgi-bin/.%2e/.%2e/.%2e/.%2e/.%2e/etc/passwd | grep 'Gnats Bug-Reporting System')" ]; then
  exit 1
else
  exit 0
fi