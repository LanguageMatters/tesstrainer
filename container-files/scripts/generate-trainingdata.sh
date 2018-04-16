#!/bin/bash

# Generating training data
cd ${TES_SRC_DIR}
training/tesstrain.sh --fonts_dir ../fonts --lang sin --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --output_dir ../workspace/sintrain \
  --fontlist "Iskoola Pota"
