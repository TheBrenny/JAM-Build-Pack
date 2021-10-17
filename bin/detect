#!/bin/sh

# Extract passed var
BUILD_DIR=${1:-}

if head -c 27 "${BUILD_DIR}/package.json" | grep -q "\"name\": \"javaautomark\""; then
    echo "JAM"
    exit 0
else
    exit 1
fi
