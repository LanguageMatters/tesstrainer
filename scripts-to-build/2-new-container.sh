#!/bin/bash

docker run -d -p 4022:22 \
  --volume="$(pwd)"/../langdata:/tesstrainer/langdata \
  --name t4cmp tesstrainer
docker ps
