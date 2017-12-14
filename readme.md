# Networks on a surface

2017-12-14 WF

## output

output are images in `imgs`

## pipeline

1. `txt/networkLUT_*.txt` from SM.
1. `00_makeme.bash` output has been put into `fsaverage/`. This script makes surface labels from LUT files
1. `01_shots.bash` runs `shots_freeview_cmd.txt` in freeview to make images in `imgs/`
