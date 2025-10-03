if [ -f "/tmp/skip" ]; then
  exit 0
fi

head -n 1 webserver.Dockerfile | grep -v "2.4.49\|2.4.50"