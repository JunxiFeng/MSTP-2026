# START HERE

**REQUIRED DAY 1**

This is where Day 1 actually begins — if you haven't seen the welcome in [README.md](README.md) yet, it's worth a minute, but this file is the one that gets you moving.

Everything below is the minimum to get moving — each step is explained properly later today (VS Code and Remote-SSH in [lessons/05_vscode_and_jupyter.md](day1_foundations/lessons/05_vscode_and_jupyter.md), Git in [lessons/06_git_basics.md](day1_foundations/lessons/06_git_basics.md), conda/mamba in [lessons/07_environments_and_reproducibility.md](day1_foundations/lessons/07_environments_and_reproducibility.md)). For now, just get each step done; you're welcome to jump ahead and read any of those in full first if you'd rather understand before you type.

1. **Get connected and get the repo.** Install [VS Code](https://code.visualstudio.com/), then its Remote-SSH extension, and connect to TSCC (`ssh your_username@login.tscc.sdsc.edu`, or the equivalent inside VS Code). Once connected, clone this repository somewhere under your own space on TSCC:

   ```bash
   git clone https://github.com/JunxiFeng/MSTP-2026.git
   cd MSTP-2026
   ```

   Open this cloned folder in VS Code (**File > Open Folder**). Everything else below happens from inside it.
2. **Install `conda` (Miniforge).** This is a one-time step — once it's done, it's done for every future session, not just today:

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
3. Build the environment — **on a compute node, not the login node.** This is small, but "small" doesn't save you here: `conda env create` parses the *entire* channel index (conda-forge's full package list, hundreds of MB) to solve, before it even gets to installing your handful of packages — enough to get killed by the login node's per-process memory cap (confirmed real: a plain `conda env create` on the login node dies mid-solve with `Killed`, no other explanation given). Request an interactive compute node first (this is Slurm — lesson 10 teaches it properly, just follow along for now):

   ```bash
   srun --partition=hotel --qos=hotel --account=htl191 --mem=16G --cpus-per-task=2 --time=00:30:00 --pty /bin/bash
   ```

   You're now on a compute node, in the same directory you started from. Build and activate the environment here:

   ```bash
   conda env create -f environments/day1.yml
   conda activate mstp-day1
   ```

   Once that finishes, `exit` to return to the login node — you only needed the compute node for the build itself, and you'll `conda activate mstp-day1` again from the login node from here on (activation is cheap; the environment now already exists).

4. Confirm which Python you are using:

   ```bash
   which python
   python --version
   ```

5. Go to [day1_foundations/README.md](day1_foundations/README.md).
6. Follow the lessons in order, and actually do each lesson's Practice section as you go.

Today's validation model is:

```text
Agent validation + automated validation + scientific validation
```

Multiple agents agreeing is useful evidence, not proof. You still make the scientific judgment.
