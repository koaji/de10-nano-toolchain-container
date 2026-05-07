#!/bin/bash

IMAGES="localhost/arm-none-linux-gnueabihf-crosstool:1.0"

podman run \
    -it \
    --rm \
    -v $(pwd):/root/workspace \
    ${IMAGES}
