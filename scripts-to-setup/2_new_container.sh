#!/bin/bash

docker run -d -p 4022:22 \
  --volume="$(pwd)"/../workspace:/tesstrainer/workspace \
  --hostname=tesstrainer \
  --name tesstrainer_run tesstrainer
docker ps
