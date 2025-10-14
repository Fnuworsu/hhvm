#!/bin/bash
# run-hhvm.sh
# Runs a Hack/HHVM script inside an official HHVM Docker container
# Works on macOS (M1–M4) using amd64 emulation

# Exit immediately if a command fails
set -e

# Check for the script argument
if [ -z "$1" ]; then
  echo "Usage: $0 <hack-file>"
  exit 1
fi

SCRIPT_PATH="$1"

# Run HHVM inside Docker
docker run --rm -it \
  --platform linux/amd64 \
  -v "$(pwd)":/app -w /app \
  hhvm/hhvm:latest hhvm "$SCRIPT_PATH"
