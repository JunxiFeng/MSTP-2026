# HPC Execution Rules

This project runs on a shared HPC cluster.

- Never run computationally intensive analyses directly on login nodes.
- Never use `n_jobs=-1`, unlimited multiprocessing, or all available CPUs.
- Do not launch large Python/R analyses, model training, or large data processing on login nodes.
- Login nodes are only for lightweight file inspection, code editing, debugging, and Slurm submission.
- Substantial computation must run through Slurm (`sbatch` or an allocated compute node).
- Match multiprocessing workers to the CPUs requested from Slurm.
- Before running a potentially expensive command outside Slurm, ask for confirmation.