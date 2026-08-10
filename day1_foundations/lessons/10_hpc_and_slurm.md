# HPC And Slurm

**REQUIRED DAY 1**

## The one thing to internalize

The biological analysis does not change on HPC — only the execution environment changes. The same script that ran on your laptop should run, unmodified, on the cluster. What changes is *how* you launch it: instead of running it directly, you hand it to a scheduler (**Slurm**) that finds it a compute node and runs it there, so your laptop doesn't need to stay on and your job doesn't compete with everyone else's job for the same CPU.

## What is TSCC

This course runs on **TSCC (Triton Shared Computing Cluster)**, UC San Diego's shared research computing cluster operated by SDSC. You interact with it in two stages: you `ssh` into a **login node** (for editing files, submitting jobs — not for running your analysis directly), and Slurm dispatches your actual work to a **compute node**.

## Logging in

```bash
ssh your_username@login.tscc.sdsc.edu
```

If you don't yet have TSCC access, contact your PI/lab administrator or [UCSD Research IT](https://research-it.ucsd.edu/) — this course's jobs run under the Gaulton lab allocation, account `htl191`.

## The module system

TSCC uses [Lmod](https://lmod.readthedocs.io/) to manage software versions:

```bash
module avail             # list modules available to load
module spider <name>     # search for a specific package/tool
module load <name>       # load a module into your current shell
module list              # show what's currently loaded
module unload <name>     # remove a loaded module
```

Check for an existing conda/anaconda module before installing your own Miniforge on TSCC (see [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md)).

## Submitting a batch job

Batch mode is how you run something without staying logged in and watching it. This course's starter script, [day1_template.slurm](../templates/slurm_templates/day1_template.slurm):

```bash
#!/bin/bash
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
```

What each line is doing:

- `#SBATCH` lines are directives to Slurm, not shell comments — they must come before any executable command.
- `--account=htl191` — **every Day 1 job must use this account**; this is how usage is billed to the lab's allocation.
- `--partition=hotel --qos=hotel` — **not optional.** `htl191`'s default QOS (`normal`) caps memory per job at 0, so a job submitted without these two flags fails immediately with `QOSMaxMemoryPerJob`, no matter how small `--mem` is. This was confirmed by an actual failed submission, not a guess — if you ever see that error, this is almost certainly why.
- `--time` / `--mem` / `--cpus-per-task` — the resources you're requesting; ask for only what you need, since overestimating delays scheduling and underestimating gets your job killed mid-run.
- `--output` / `--error` — where stdout/stderr land; `%x` is the job name, `%j` is the job ID, so each run gets its own log file.
- `set -euo pipefail` — makes the script exit immediately on any error instead of silently continuing (a general good habit for any shell script, not Slurm-specific).

Submit it (from this repository's root; make sure `mstp-day1` is the active conda environment in this same shell first — unlike Days 2-5's shared environments, `sbatch` here just inherits whatever `python` is on `PATH` in the shell you run it from, so if you deactivate or open a fresh terminal, activate again before submitting):

```bash
conda activate mstp-day1
sbatch day1_foundations/templates/slurm_templates/day1_template.slurm
```

## Monitoring and controlling jobs

```bash
squeue -u $USER        # see your queued/running jobs
sacct -j JOBID          # see history/exit status for a specific job
scancel JOBID           # cancel a job
```

## Interactive sessions

Sometimes you want a live shell *on a compute node* rather than submitting a batch script — useful for debugging before you commit to a batch run:

```bash
srun --partition=hotel --qos=hotel --pty --nodes=1 --ntasks-per-node=1 \
     -t 00:30:00 -A htl191 --wait=0 --export=ALL /bin/bash
```

This drops you into a bash shell on an actual compute node, with the same account (`-A htl191`) as your batch jobs, for up to 30 minutes (`-t 00:30:00`) in this example.

## Practice

```bash
ssh your_username@login.tscc.sdsc.edu
cd /path/to/your/cloned/repo
conda activate mstp-day1
mkdir -p logs
sbatch day1_foundations/templates/slurm_templates/day1_template.slurm
squeue -u $USER
```

Once it finishes, check `logs/` for the `.out`/`.err` files and confirm the script ran using the environment you expect (same `which python` check as [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md), run on the compute node).

## Further reading

- [TSCC User Guide (SDSC)](https://www.sdsc.edu/systems/tscc/user_guide.html)
- [UCSD Research IT: Accessing TSCC](https://research-it.ucsd.edu/computing/users/access.html)
- [Slurm documentation](https://slurm.schedmd.com/documentation.html)
- [slurm_cheatsheet.md](../../resources/cheatsheets/slurm_cheatsheet.md) — this course's quick-reference version.
