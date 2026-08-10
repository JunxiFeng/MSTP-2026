#!/bin/bash
# --partition/--qos are not optional here: the htl191 account's default QOS
# ("normal") caps memory per job at 0, so ANY submission without an explicit
# --partition=hotel --qos=hotel fails with QOSMaxMemoryPerJob, for any
# --mem request above zero. Confirmed 2026-08-08 while testing Day 2's
# analogous template.
#SBATCH --job-name=day1-analysis
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
python day1_foundations/templates/diagnostic_scripts/check_python.py
