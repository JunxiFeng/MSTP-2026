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

This course uses `conda`/`mamba` environments. If you don't already have conda, install [Miniforge](https://conda-forge.org/download/) (the community-maintained, conda-forge-first distribution that includes both `conda` and the faster `mamba` solver):

```bash
# macOS/Linux
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
```

Restart your terminal afterward, then confirm:

```bash
conda --version
mamba --version
```

On TSCC specifically, `module load anaconda3` gives you a real, working `conda` (confirmed: version 25.11.1, which already defaults to the fast `libmamba` solver) — but no separate `mamba` command comes with it. Use the conda-only commands below on TSCC; `mamba` is only there if you installed Miniforge yourself. Check `module avail` for the exact module name before assuming it's called `anaconda3` (see [10_hpc_and_slurm.md](10_hpc_and_slurm.md)).

## Creating this course's environment

The environment for Day 1 is defined declaratively in [environments/day1.yml](../../environments/day1.yml) — a text file listing the exact packages and versions, so it can be recreated identically by anyone.

```bash
mamba env create -f environments/day1.yml
conda activate mstp-day1
```

Conda-only fallback if Mamba is unavailable:

```bash
conda env create -f environments/day1.yml
conda activate mstp-day1
```

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
