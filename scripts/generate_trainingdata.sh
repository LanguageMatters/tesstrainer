#!/bin/bash

# Generating training data
cd ${TES_SRC_DIR}
tesstrain.sh \
  --fonts_dir "${FONTS_DIR}" \
  --lang sin \
  --linedata_only \
  --noextract_font_properties \
  --langdata_dir "${LANGDATA_DIR}" \
  --output_dir "${WORKSPACE_DIR}"/sintrain \
  --training_text "${WORKSPACE_DIR}"/sin.training_text \
  --fontlist "Iskoola Pota"
