#!/bin/bash
# INDIVIDUAL job -- every student builds their own copy of this small
# environment (unlike Days 2-5, where one shared environment is built once
# by the instructor). Even a small environment.yml can get killed on the
# login node: conda's metadata-collection step parses the FULL channel
# index (conda-forge's repodata.json, hundreds of MB), independent of how
# few packages you're actually installing -- a login node's per-process
# memory cap kills it outright, invisible to `ulimit` (confirmed real:
# `conda env create` on the login node dies with "Killed" during
# "Collecting package metadata").
#
# --partition/--qos are required: this account's default QOS caps memory
# per job at 0, so any submission missing these two flags fails with
# QOSMaxMemoryPerJob no matter how small --mem is.
#SBATCH --job-name=build-day1-env
#SBATCH --account=htl191
#SBATCH --partition=hotel
#SBATCH --qos=hotel
#SBATCH --time=00:30:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=2
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err

set -euo pipefail
cd "$SLURM_SUBMIT_DIR"
# Calling conda's own binary directly, by full path -- no need to source any
# shell profile/rc file first. `conda env create` doesn't need `conda
# activate`'s shell-function machinery, just the executable itself.
~/miniforge3/bin/conda env create -f environments/day1.yml
