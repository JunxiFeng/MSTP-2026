# Slurm Cheatsheet

**REFERENCE**

- `sbatch slurm/run_analysis.slurm` submits a job.
- `squeue -u $USER` checks queued/running jobs.
- `sacct -j JOBID` checks job history.
- `scancel JOBID` cancels a job.

Day 1 jobs use `#SBATCH --account=htl191`.
