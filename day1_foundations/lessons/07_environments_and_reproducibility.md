# Environments And Reproducibility

**REQUIRED DAY 1**

## What "environment" means

A software environment is **code + packages + package versions + runtime**, all together. "It works on my machine" almost always means "it works in *this specific environment*," and reproducibility means making that environment explicit and shareable instead of implicit and personal.

## The question you must always be able to answer: which Python am I actually using?

The same command, `python`, can point at completely different installations depending on *where you type it*:

1. **Shell Python** — whatever `python`/`python3` resolves to in your terminal right now.
2. **VS Code interpreter** — the interpreter VS Code selected for running/debugging `.py` files ([05_vscode_and_jupyter.md](05_vscode_and_jupyter.md)).
3. **Jupyter kernel** — the interpreter a specific notebook is attached to, chosen independently of both of the above.
4. **HPC environment** — whatever modules/conda environment is active on a TSCC login or compute node ([10_hpc_and_slurm.md](10_hpc_and_slurm.md)), which is separate from all three above.

These four can silently disagree — e.g., you `pip install`ed a package in a terminal, but your notebook kernel is a different Python that doesn't have it. Check with:

```bash
which python
python --version
```

or, in Python itself:

```bash
python day1_foundations/templates/diagnostic_scripts/check_python.py
```

which prints the exact interpreter path, version, and working directory being used *right now*, in whatever context you run it — terminal, VS Code, or a notebook cell (`!python day1_foundations/templates/diagnostic_scripts/check_python.py`).

## Installing a package manager: Miniforge (conda + mamba)

You already did this in [START_HERE.md](../../START_HERE.md) — this is the same steps again, with the reasoning filled in. This course uses `conda`/`mamba` environments; [Miniforge](https://conda-forge.org/download/) is the community-maintained, conda-forge-first distribution that includes both:

```bash
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

The installer prompts you through the license and install location (default `~/miniforge3` is fine). It won't automatically show up in new terminals until you tell it to hook into your shell:

```bash
~/miniforge3/bin/conda init bash
source ~/.bashrc
```

You should now see `(base)` at the start of your prompt. Confirm:

```bash
conda --version
mamba --version
```

(TSCC also has a working `conda` available via `module load anaconda3`, without a separate `mamba` — but installing your own via Miniforge is what START_HERE has you do, since it works identically everywhere, not just on TSCC.)

## Creating this course's environment

The environment for Day 1 is defined declaratively in [environments/day1.yml](../../environments/day1.yml) — a text file listing the exact packages and versions, so it can be recreated identically by anyone.

**Don't run `conda env create` directly on a login node** (TSCC or otherwise sharing compute among many users) — you likely already did this correctly in [START_HERE.md](../../START_HERE.md) via `sbatch`, so this is about understanding why: solving an environment means parsing the *entire* channel index first (conda-forge's full package list, hundreds of MB), regardless of how few packages you're actually installing. That's enough to trip a login node's per-process memory cap — confirmed real: a plain `conda env create` on TSCC's login node dies mid-solve with `Killed` and nothing else. Submit it as a job instead (this is Slurm — [10_hpc_and_slurm.md](10_hpc_and_slurm.md) covers it properly):

```bash
mkdir -p logs
sbatch day1_foundations/templates/slurm_templates/build_day1_env.slurm
squeue -u $USER
```

Then activate as normal, which is cheap and fine to do directly on the login node — only the solve/install step is the problem:

```bash
conda activate mstp-day1
```

If you have a real `mamba` command (e.g. from installing Miniforge yourself), it's a drop-in replacement for `conda env create` inside that same Slurm script.

Verify:

```bash
which python
python --version
conda env list
```

## Registering the environment as a Jupyter kernel

`environments/day1.yml` already includes `ipykernel`, which lets this environment show up as a selectable kernel. If a new environment you create doesn't show up in VS Code's or Jupyter's kernel picker, register it explicitly:

```bash
conda activate mstp-day1
python -m ipykernel install --user --name mstp-day1 --display-name "Python (mstp-day1)"
```

Then select "Python (mstp-day1)" as the kernel in VS Code or Jupyter.

## `environment.yml` vs. `requirements.txt`

- **`environment.yml`** (conda/mamba) — can pin the Python version itself plus non-Python dependencies (compilers, system libraries). Used by this course.
- **`requirements.txt`** (pip) — pins only Python packages, assumes a Python interpreter already exists. Common in pure-Python projects.

Both serve the same purpose: making "what's installed" explicit and versioned in a file that lives in the repository, instead of living only in one person's head or one machine's disk.

## Further reading

- [Miniforge (conda-forge installer)](https://conda-forge.org/download/)
- [Conda: Managing environments](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)
- [Mamba documentation](https://mamba.readthedocs.io/en/latest/)
- [conda_mamba_cheatsheet.md](../../resources/cheatsheets/conda_mamba_cheatsheet.md) — this course's quick-reference version.
