#!/bin/bash

DIALOG_TEXT="The application you are trying to launch does not have GPU accelerated, but you are on a GPU partition. Are you sure you want to continue?"

{
  [[ "$SLURM_JOB_PARTITION" != *gpu* ]] || \
  singularity exec /appl/opt/ood/$SLURM_OOD_ENV/vnc_images/xfce.sif zenity --question --text="$DIALOG_TEXT";
} || exit 1
