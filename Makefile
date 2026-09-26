.ONESHELL:  # Tells make to run the entire target recipe in one shell

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  slicer-vnc-h200"
	@echo "    Script to start a slurm job in an Xubuntu Apptainer container for 3D Slicer."
	@echo ""
	@echo "  slicer-vnc-mig"
	@echo "    Script to start a MIG slurm job."
	@echo ""
	@echo "  sinfo"
	@echo "    sinfo of Hyak Tillicum."

.PHONY: slicer-vnc-h200
slicer-vnc-h200:
	# Define variables
	GPU_NODES=2
	TASKS_PER_NODE=8
	RUNTIME_HR=12

	# Generate the sbatch script
	sbatch <<-EOF
		#!/bin/bash
		#SBATCH --job-name=slicer_in_apptainer
		#SBATCH --gpus=$${GPU_NODES} 
		#SBATCH --ntasks-per-node=$$((TASKS_PER_NODE * GPU_NODES))
		#SBATCH --time=$${RUNTIME_HR}:00:00
		#SBATCH --output=slurm_log/slurm-%x-%j.out
		#SBATCH --qos=normal
		#SBATCH --partition=gpu-h200
		apptainer run \
		  --app turbovnc \
		  --nv \
		  --bind /run,/gpfs \
		  /gpfs/projects/gavia/apptainer_containers/3DSlicer_Xubuntu.sif
	EOF

.PHONY: slicer-vnc-mig
slicer-vnc-mig:
	
	#################################
	## Stop using after 2026-09-25 ##
	#################################

	# Define variables
	GPU_NODES=20
	TASKS_PER_NODE=1
	RUNTIME_HR=12

	# Generate the sbatch script
	sbatch <<-EOF
		#!/bin/bash
		#SBATCH --job-name=slicer_in_apptainer
		#SBATCH --gpus=$${GPU_NODES} 
		#SBATCH --ntasks-per-node=$$((TASKS_PER_NODE * GPU_NODES))
		#SBATCH --time=$${RUNTIME_HR}:00:00
		#SBATCH --output=slurm_log/slurm-%x-%j.out
		#SBATCH --qos=normal
		#SBATCH --partition=gpu-h200-mig
		apptainer run \
		  --app turbovnc \
		  --nv \
		  --bind /run,/gpfs \
		  /gpfs/projects/gavia/apptainer_containers/3DSlicer_Xubuntu.sif
	EOF

.PHONY: sinfo
sinfo:
	watch -n1 'sinfo -O nodehost,statecompact,gresused -S statecompact,gresused'
