.ONESHELL:  # Tells make to run the entire target recipe in one shell

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  target_1"
	@echo ""
	@echo "  target_2"
	@echo ""

.PHONY: slicer-vnc-mig
slicer-vnc-mig:
	# Define variables
	GPU_NODES=1
	TASKS_PER_NODE=8
	RUNTIME_HR=8

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

