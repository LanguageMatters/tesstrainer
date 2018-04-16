#!/bin/bash

# Generating eval data
cd ${TES_SRC_DIR}
training/tesstrain.sh \
  --fonts_dir "${FONTS_DIR}" \
  --lang sin \
  --linedata_only \
  --noextract_font_properties \
  --langdata_dir "${LANGDATA_DIR}" \
  --output_dir "${WORKSPACE_DIR}"/sineval \
  --fontlist "Iskoola Pota"
