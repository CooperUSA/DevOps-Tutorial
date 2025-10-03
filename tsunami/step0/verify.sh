if [ -f "/tmp/skip" ]; then
  exit 0
fi

if [ ! -f /tmp/intro ]; then
    exit 1
fi

echo "Intro verification passed"