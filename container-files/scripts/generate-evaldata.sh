#!/bin/bash

# Generating eval data
cd ${TES_SRC_DIR}
training/tesstrain.sh --fonts_dir ../fonts --lang sin --linedata_only \
  --noextract_font_properties --langdata_dir ../langdata \
  --fontlist "Iskoola Pota" --output_dir ../workspace/sineval
