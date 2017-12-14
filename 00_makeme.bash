#!/usr/bin/env bash
export SUBJECTS_DIR="/Volumes/T800/Multimodal/Rest_2015_97subjects/subjects/"

mris_label2annot --s fsaverage --h lh --ctab txt/networkLUT_lh.txt --a 20171214_nets $(seq 1 161 | xargs -I{} -n1 echo "--l $SUBJECTS_DIR/fsaverage/label/lh.label_{}.label")

mris_label2annot --s fsaverage --h rh --ctab txt/networkLUT_rh.txt --a 20171214_nets $(seq 162 333 | xargs -I{} -n1 echo "--l $SUBJECTS_DIR/fsaverage/label/rh.label_{}.label")
