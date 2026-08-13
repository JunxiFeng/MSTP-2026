# START HERE

**REQUIRED DAY 1**

This is where Day 1 actually begins — if you haven't seen the welcome in [README.md](README.md) yet, it's worth a minute, but this file is the one that gets you moving.

Everything below only needs a terminal — no editor or IDE required. Each step is explained properly later today (Jupyter in [lessons/05_jupyter_on_tscc.md](day1_foundations/lessons/05_jupyter_on_tscc.md), Git in [lessons/06_git_basics.md](day1_foundations/lessons/06_git_basics.md), conda in [lessons/07_environments_and_reproducibility.md](day1_foundations/lessons/07_environments_and_reproducibility.md)). For now, just get each step done; you're welcome to jump ahead and read any of those in full first if you'd rather understand before you type.

1. **Confirm your TSCC account works.** TSCC accounts are listed [here](https://docs.google.com/spreadsheets/d/1dmCc16dy625OQlGl6PwkF7sAmZuXJBl4tewtei3MlLc/edit?usp=sharing).

   Open **Terminal** (macOS/Linux) or **PowerShell** (Windows) and run:

   ```bash
   ssh YOUR_USERNAME@login.tscc.sdsc.edu
   ```

   Replace `YOUR_USERNAME` with the part of your UCSD email address before `@health.ucsd.edu`. Log in with your UCSD Active Directory password and complete the Duo authentication prompt on your phone.

   Two things that look broken but aren't:
   - While typing your password, the terminal shows nothing at all — no dots, no characters. That's normal; just type it and press Enter.
   - The first login can take a few extra seconds while Duo sends the push notification. Don't retry — just wait for it.

   Once you land at a prompt that looks like `[YOUR_USERNAME@login.tscc.sdsc.edu ~]$`, you're in and ready for the rest of the steps below — stay logged in.

   > **Login node reminder:** this machine is a *login node* — fine for navigating files, editing, and preparing jobs, but **not** for running any real analysis. Anything computationally heavy goes through Slurm instead (step 4 below, and properly in [lesson 10](day1_foundations/lessons/10_hpc_and_slurm.md)). Our bootcamp's allocation is `htl191`.

   **(Optional) If you'd like a graphical editor:** VS Code with the Remote-SSH extension is a nice way to browse/edit files, use Git, and get an integrated terminal against this same TSCC connection — it's genuinely optional, not required for anything below. A short setup guide (and how it fits alongside everything else here) is in the "Optional: VS Code as an editor" section of [lesson 05](day1_foundations/lessons/05_jupyter_on_tscc.md#optional-vs-code-as-an-editor). One thing not to do: don't use VS Code's own Jupyter extension to run notebooks against the login node — for notebooks, always use `galyleo` instead (see lesson 05), regardless of whether you're also using VS Code as your editor.

2. **Clone the course repository:**

   ```bash
   git clone https://github.com/JunxiFeng/MSTP-2026.git
   cd MSTP-2026
   ```

   Everything else below happens from inside this folder.

3. **Install `conda` (Miniforge).** This is a one-time step — once it's done, it's done for every future session, not just today:

   ```bash
   curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
   bash Miniforge3-$(uname)-$(uname -m).sh
   ```

   Press Enter/Space to page through the license, type `yes` to accept, then Enter again to accept the default install location (`~/miniforge3`). Then wire it into your shell so it's available every time you open a terminal:

   ```bash
   ~/miniforge3/bin/conda init bash
   source ~/.bashrc
   ```

   Open a new terminal (or the `source` above is enough) and confirm you now see `(base)` at the start of your prompt, and that this works:

   ```bash
   conda --version
   ```
4. Build the environment — **through Slurm, not directly on the login node.** This is small, but "small" doesn't save you here: `conda env create` parses the *entire* channel index (conda-forge's full package list, hundreds of MB) to solve, before it even gets to installing your handful of packages — enough to get killed by the login node's per-process memory cap (confirmed real: a plain `conda env create` on the login node dies mid-solve with `Killed`, no other explanation given). Submit it as a job instead (this is Slurm — lesson 10 teaches it properly, just follow along for now):

   ```bash
   mkdir -p logs
   sbatch day1_foundations/templates/slurm_templates/build_day1_env.slurm
   squeue -u $USER
   ```

   Once it drops off that list, check `logs/build-day1-env-<jobid>.out` and `.err` for errors, then activate as normal:

   ```bash
   conda activate mstp-day1
   ```

5. Confirm which Python you are using:

   ```bash
   which python
   python --version
   ```

6. Go to [day1_foundations/README.md](day1_foundations/README.md).
7. Follow the lessons in order, and actually do each lesson's Practice section as you go — including running your first notebook through `galyleo` in [lesson 05](day1_foundations/lessons/05_jupyter_on_tscc.md).

Today's validation model is:

```text
Agent validation + automated validation + scientific validation
```

Multiple agents agreeing is useful evidence, not proof. You still make the scientific judgment.
