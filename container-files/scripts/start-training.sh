#!/bin/bash

# Training
cd ${TES_SRC_DIR}
mkdir -p "${WORKSPACE_DIR}"/sinoutput
lstmtraining \
  --debug_interval 0 \
  --traineddata "${WORKSPACE_DIR}"/sintrain/sin/sin.traineddata \
  --net_spec '[1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx256 O1c111]' \
  --model_output "${WORKSPACE_DIR}"/sinoutput/base \
  --learning_rate 20e-4 \
  --train_listfile "${WORKSPACE_DIR}"/sintrain/sin.training_files.txt \
  --eval_listfile "${WORKSPACE_DIR}"/sineval/sin.training_files.txt \
  --max_iterations 5000 &> "${WORKSPACE_DIR}"/session.log
