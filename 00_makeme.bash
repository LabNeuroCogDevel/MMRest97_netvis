#!/usr/bin/env bash

cd $(dirname $0)
#
# make freesurfer label annotations from SM input files
# and copy locally
# txt/networkLUT_{l,r}h.txt
#

# settings
export SUBJECTS_DIR="/Volumes/T800/Multimodal/Rest_2015_97subjects/subjects"

mkannot() {
  dir="$1"
  labelfile=20171214_nets_$dir
  # remove old
  for f in $SUBJECTS_DIR/fsaverage/label/{l,r}h.$labelfile.annot; do
    [ -r $f ] && rm $f
  done
  
  # create new
  mris_label2annot --s fsaverage --h lh --ctab txt/$dir/networkLUT_lh.txt --a $labelfile $(seq 1 161 | xargs -I{} -n1 echo "--l $SUBJECTS_DIR/fsaverage/label/lh.label_{}.label")
  mris_label2annot --s fsaverage --h rh --ctab txt/$dir/networkLUT_rh.txt --a $labelfile $(seq 162 333 | xargs -I{} -n1 echo "--l $SUBJECTS_DIR/fsaverage/label/rh.label_{}.label")
  
  # copy to local
  cp $SUBJECTS_DIR/fsaverage/label/{l,r}h.$labelfile.annot  fsaverage/
}

# do all or just the one specified
if [ -z "$1" ]; then 
  for d in txt/*/; do
     mkannot $(basename $d)
  done
else
  [ ! -d txt/$1 ] && echo "no LUT for '$1'" && exit 1
  mkannot $1
fi
