#!/bin/bash

docker exec -it tesstrainer_run sh scripts/compile_leptonica.sh && \
docker exec -it tesstrainer_run sh scripts/compile_tesseract.sh && \
docker exec -it tesstrainer_run tesseract \-v
