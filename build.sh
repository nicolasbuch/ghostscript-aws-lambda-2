#!/usr/bin/env bash

docker build --platform=linux/amd64 -t gs-lambda-layer .
docker run --platform=linux/amd64 --entrypoint cat gs-lambda-layer /tmp/gs.zip > ./ghostscript.zip
