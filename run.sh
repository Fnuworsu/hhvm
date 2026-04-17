#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <hack-file>"
  exit 1
fi

SCRIPT_PATH="$1"
CURRENT_DIR="$(pwd)"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# If running a messagingBroker script, include all dependencies
if [[ "$SCRIPT_PATH" == *"messagingBroker"* ]]; then
  docker run --rm -it \
    --platform linux/amd64 \
    --mount type=bind,source="${CURRENT_DIR}",target=/app \
    -w /app \
    hhvm/hhvm:latest hhvm \
    messagingBroker/queueService.hack \
    messagingBroker/exchangeService.hack \
    messagingBroker/loadBalancer.hack \
    messagingBroker/main.hack
else
  docker run --rm -it \
    --platform linux/amd64 \
    --mount type=bind,source="${CURRENT_DIR}",target=/app \
    -w /app \
    hhvm/hhvm:latest hhvm "$SCRIPT_PATH"
fi