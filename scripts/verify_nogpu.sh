#!/bin/bash

DIALOG_TEXT="The application you are trying to launch does not have GPU acceleration, but you are on a GPU partition. Are you sure you want to continue?"
DIALOG_TITLE="Are you sure?"

{
  [[ "$SLURM_JOB_PARTITION" != *gpu* ]] || \
  singularity exec /appl/opt/ood/$SLURM_OOD_ENV/vnc_images/xfce.sif zenity --question --title="$DIALOG_TITLE" --text="$DIALOG_TEXT";
} || exit 1
