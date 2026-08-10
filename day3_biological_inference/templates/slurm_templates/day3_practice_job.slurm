#!/bin/bash
# INDIVIDUAL job -- every student submits their own copy, same pattern as
# Day 2's day2_practice_job.slurm. --partition/--qos are required: this
# account's default QOS caps memory per job at 0, so any submission missing
# these two flags fails with QOSMaxMemoryPerJob no matter how small --mem is.
#
#SBATCH --job-name=day3-practice
#SBATCH --account=htl191
#SBATCH --partition=hotel
#SBATCH --qos=hotel
#SBATCH --time=00:10:00
#SBATCH --mem=4G
#SBATCH --cpus-per-task=1
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail
export OMP_NUM_THREADS=1
cd "$SLURM_SUBMIT_DIR"

# Writes to your own results/ folder -- you don't have write access to the
# shared data directory, and shouldn't need it.
OUTPUT_DIR="${OUTPUT_DIR:-results/cnmf_practice}"
mkdir -p "$OUTPUT_DIR"

/tscc/nfs/home/juf009/envs/mstp-day3/bin/python \
  day3_biological_inference/templates/diagnostic_scripts/run_toy_cnmf.py "$OUTPUT_DIR"
