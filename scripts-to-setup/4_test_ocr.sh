#!/bin/bash

# Show version information:
docker exec -it tesstrainer_run tesseract \-v
# List available languages for tesseract engine:
docker exec -it tesstrainer_run tesseract \--list-langs
# Show help message:
# docker exec -it tesstrainer tesseract \-h

# Base OCR test
docker exec -it tesstrainer_run /bin/bash -c "echo ====; mkdir ./ocr-files/; cd ./ocr-files/; pwd; \
rm phototest.*; echo ====; \
echo downloading test file:; wget -O phototest.tif https://github.com/tesseract-ocr/tesseract/raw/master/testing/phototest.tif; \
tesseract phototest.tif phototest; \
head -100 phototest.txt; \
echo Compare the text above ^^^ with the source image: \
echo https://github.com/tesseract-ocr/tesseract/raw/master/testing/phototest.tif"

# Process and copy files to ./ocr-files/ directory
docker exec -it tesstrainer_run /bin/bash -c "cd ./ocr-files/; tesseract phototest.tif phototest -l eng --psm 1 --oem 2 pdf hocr"
docker cp tesstrainer_run:/tesstrain/ocr-files/ ./
echo "Check results in ./ocr-files directory"
