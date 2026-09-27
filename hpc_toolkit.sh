#!/bin/bash

set -euo pipefail

show_help() {
    cat <<EOF
Usage: $(basename "$0") <command>

Commands:
  slicer-vnc-h200
      Start a Slurm job in an Xubuntu Apptainer container for 3D Slicer.

  slicer-vnc-mig
      Start a MIG Slurm job.
      (Deprecated after 2026-09-25)

  sinfo
      Display Hyak Tillicum node status.

  help
      Show this help message.
EOF
}

slicer_vnc_h200() {
    GPU_NODES=2
    TASKS_PER_NODE=8
    RUNTIME_HR=12

    sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=slicer_in_apptainer
#SBATCH --gpus=${GPU_NODES}
#SBATCH --ntasks-per-node=$((TASKS_PER_NODE * GPU_NODES))
#SBATCH --time=${RUNTIME_HR}:00:00
#SBATCH --output=slurm_log/slurm-%x-%j.out
#SBATCH --qos=normal
#SBATCH --partition=gpu-h200

apptainer run \
  --app turbovnc \
  --nv \
  --bind /run,/gpfs \
  /gpfs/projects/gavia/apptainer_containers/3DSlicer_Xubuntu.sif
EOF
}

slicer_vnc_mig() {
    cat <<EOF

#################################
## Stop using after 2026-09-25 ##
#################################

EOF

    GPU_NODES=20
    TASKS_PER_NODE=1
    RUNTIME_HR=12

    sbatch <<EOF
#!/bin/bash
#SBATCH --job-name=slicer_in_apptainer
#SBATCH --gpus=${GPU_NODES}
#SBATCH --ntasks-per-node=$((TASKS_PER_NODE * GPU_NODES))
#SBATCH --time=${RUNTIME_HR}:00:00
#SBATCH --output=slurm_log/slurm-%x-%j.out
#SBATCH --qos=normal
#SBATCH --partition=gpu-h200-mig

apptainer run \
  --app turbovnc \
  --nv \
  --bind /run,/gpfs \
  /gpfs/projects/gavia/apptainer_containers/3DSlicer_Xubuntu.sif
EOF
}

show_sinfo() {
    watch -n 1 'sinfo -O nodehost,statecompact,gresused -S statecompact,gresused'
}

case "${1:-help}" in
    slicer-vnc-h200)
        slicer_vnc_h200
        ;;
    slicer-vnc-mig)
        slicer_vnc_mig
        ;;
    sinfo)
        show_sinfo
        ;;
    help|-h|--help)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo
        show_help
        exit 1
        ;;
esac
