#!/bin/bash
module load r-env
xterm -hold -e "apptainer_wrapper exec saga_gui"
