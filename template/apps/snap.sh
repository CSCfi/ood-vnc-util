#!/bin/bash
module load snap
source snap_add_userdir $TMPDIR
xterm -hold -e snap
