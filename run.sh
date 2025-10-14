#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <hack-file>"
  exit 1
fi

SCRIPT_PATH="$1"
CURRENT_DIR="$(pwd)"

docker run --rm -it \
  --platform linux/amd64 \
  --mount type=bind,source="${CURRENT_DIR}",target=/app \
  -w /app \
  hhvm/hhvm:latest hhvm "$SCRIPT_PATH"