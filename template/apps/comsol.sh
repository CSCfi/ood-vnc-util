#!/bin/bash
module load comsol
xterm -hold -e comsol -3drend sw -tmpdir $TMPDIR -configuration $TMPDIR -data $TMPDIR
