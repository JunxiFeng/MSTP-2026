#!/bin/bash
# INDIVIDUAL job -- confirms your environment and your project's checkpoint
# both load correctly before you start real analysis. --partition/--qos are
# required: this account's default QOS caps memory per job at 0, so any
# submission missing these two flags fails with QOSMaxMemoryPerJob no matter
# how small --mem is.
#SBATCH --job-name=day4-5-practice
#SBATCH --account=htl191
#SBATCH --partition=hotel
#SBATCH --qos=hotel
#SBATCH --time=00:10:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=1
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail
export OMP_NUM_THREADS=1
cd "$SLURM_SUBMIT_DIR"

/tscc/nfs/home/juf009/envs/mstp-day4-5/bin/python \
  day4_5_independent_projects/templates/diagnostic_scripts/check_day4_5_env.py

# Swap in your own project's checkpoint path from
# day4_5_independent_projects/lessons/03_project_assignments_and_datasets.md
/tscc/nfs/home/juf009/envs/mstp-day4-5/bin/python -c "
import anndata as ad
a = ad.read_h5ad('/tscc/nfs/home/juf009/day4_5_shared_data/<your_project>/<checkpoint>.h5ad')
print(a.shape, list(a.obs.columns))
"
