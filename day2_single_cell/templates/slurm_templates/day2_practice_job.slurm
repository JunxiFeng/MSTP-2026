#!/bin/bash
# INDIVIDUAL job — every student submits their own copy of this one, same as
# Day 1's day1_template.slurm. Small and fast on purpose: the point is
# practicing the sbatch/squeue/sacct loop again, not doing real compute.
#
# --partition/--qos are required: htl191's default QOS ("normal") caps
# memory per job at 0, so any submission without these fails with
# QOSMaxMemoryPerJob. Confirmed by an actual failed submission (2026-08-08).
#
#SBATCH --job-name=day2-practice
#SBATCH --account=htl191
#SBATCH --partition=hotel
#SBATCH --qos=hotel
#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH --cpus-per-task=1
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail
cd "$SLURM_SUBMIT_DIR"

# CHECKPOINT_H5AD points at the shared count matrix everyone reads from.
# This is a real, fixed path — group `htl191` (your account) has read access
# to it; see day2_single_cell/README.md's "Where the shared data lives".
CHECKPOINT_H5AD="${CHECKPOINT_H5AD:-/tscc/nfs/home/juf009/day2_shared_data/counts/checkpoint.h5ad}"

/tscc/nfs/home/juf009/envs/mstp-day2/bin/python \
  day2_single_cell/templates/diagnostic_scripts/verify_counts_matrix.py "$CHECKPOINT_H5AD"
