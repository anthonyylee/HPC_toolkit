#!/bin/bash

#SBATCH --job-name=slicer_in_apptainer
#SBATCH --gpus=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=08:00:00
#SBATCH --output=log/slurm_%x_%j.out
#SBATCH --qos=normal

apptainer run \
  --app turbovnc \
  --nv \
  --bind /run,/gpfs \
  ./3DSlicer_SlicerMorph_VirtualGL_TurboVNC.sif
