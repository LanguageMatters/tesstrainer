#!/bin/bash

# Training
cd ${TES_SRC_DIR}
training/lstmtraining --debug_interval 0 \
  --traineddata ../workspace/sintrain/sin/sin.traineddata \
  --net_spec '[1,36,0,1 Ct3,3,16 Mp3,3 Lfys48 Lfx96 Lrx96 Lfx256 O1c111]' \
  --model_output ../workspace/sinoutput/base --learning_rate 20e-4 \
  --train_listfile ../workspace/sintrain/sin.training_files.txt \
  --eval_listfile ../workspace/sineval/sin.training_files.txt \
  --max_iterations 50000
