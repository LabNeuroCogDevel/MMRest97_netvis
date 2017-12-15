#!/usr/bin/env bash

# start where this script is
cd $(dirname $0)

# where to save the screenshots
[ ! -r imgs ] && mkdir imgs

# use this fsaverage/ dir by cheating
export SUBJECTS_DIR="$(pwd)"

# make command file
allsides(){
  label=$1
  hemi=$2
  cat <<EOF
     -cam Azimuth   0 -ss imgs/$label/${hemi}_0.png  2 
     -cam Azimuth  90 -ss imgs/$label/${hemi}_90.png 2 
     -cam Azimuth 180 -ss imgs/$label/${hemi}_180.png 2 
     -cam Azimuth 270 -ss imgs/$label/${hemi}_270.png 2 
EOF
}

fvcmd(){
  label=$1
  cat <<EOF
   -f fsaverage/lh.inflated:annot=fsaverage/lh.20171214_nets_$label.annot 
     $(allsides $label lh)
   -unload surface
   -f fsaverage/rh.inflated:annot=fsaverage/rh.20171214_nets_$label.annot 
     $(allsides $label rh)
   -f fsaverage/lh.inflated:annot=fsaverage/lh.20171214_nets_$label.annot 
     $(allsides $label both)
   -unload surface
   -unload surface
EOF
}

echo "-hide-3d-slices -nocursor -noquit" > shots_freeview_cmd.txt
for luttxt in txt/*/; do
 label=$(basename $luttxt)
 fvcmd $label
done >> shots_freeview_cmd.txt
echo "-quit" >> shots_freeview_cmd.txt

# take screenshots
freeview -cmd shots_freeview_cmd.txt
