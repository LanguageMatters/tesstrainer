#!/bin/bash

lstmtraining --stop_training \
  --continue_from "${WORKSPACE_DIR}"/sinoutput/base_checkpoint \
  --traineddata "${WORKSPACE_DIR}"/sintrain/sin/sin.traineddata \
  --model_output "${WORKSPACE_DIR}"/sinoutput/sin.traineddata
