#!/bin/bash
module load r-env-singularity/4.0.4
xterm -hold -e "singularity_wrapper exec saga_gui"
