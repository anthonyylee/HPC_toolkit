.ONESHELL:  # Tells make to run the entire target recipe in one shell

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  slicer-vnc-h200-4-nodes"
	@echo "    Script to start a slurm job for a 4x GPU node session in an Xubuntu Apptainer container for 3D Slicer."
	@echo ""

.PHONY: slicer-vnc-h200-4-nodes
slicer-vnc-h200-4-nodes:
	# Define variables
	GPU_NODES=4
	TASKS_PER_NODE=8
	RUNTIME_HR=10

	# Generate the sbatch script
	sbatch <<-EOF
		#!/bin/bash
		#SBATCH --job-name=slicer_in_apptainer
		#SBATCH --gpus=$${GPU_NODES} 
		#SBATCH --ntasks-per-node=$$((TASKS_PER_NODE * GPU_NODES))
		#SBATCH --time=$${RUNTIME_HR}:00:00
		#SBATCH --output=log/slurm_%x_%j.out
		#SBATCH --qos=normal
		#SBATCH --partition=gpu-h200
		apptainer run \
		  --app turbovnc \
		  --nv \
		  --bind /run,/gpfs \
		  /gpfs/projects/gavia/apptainer_containers/3DSlicer_Xubuntu.sif
	EOF

