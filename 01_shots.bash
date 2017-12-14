#!/usr/bin/env bash

# start where this script is
cd $(dirname $0)

# where to save the screenshots
[ ! -r imgs ] && mkdir imgs

# use this fsaverage/ dir by cheating
export SUBJECTS_DIR="$(pwd)"

# take screenshots
freeview -cmd shots_freeview_cmd.txt
