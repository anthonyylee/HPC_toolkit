#!/bin/bash

#SBATCH --job-name=slicer_in_apptainer
#SBATCH --gpus=1
#SBATCH --ntasks-per-node=8
#SBATCH --time=00:08:00
#SBATCH -o log/slurm_%x_%j.out

apptainer run \
  --app turbovnc \
  --nv \
  --bind /run,/gpfs \
  /gpfs/projects/gavia/apptainer_containers/3DSlicer_SlicerMorph_VirtualGL_TurboVNC.sif
