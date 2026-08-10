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
2. **Make sure `conda` is available.** TSCC already has one — load it (you'll need to repeat this line in any new terminal session, until you add it to your shell profile):

   ```bash
   module load anaconda3
   conda --version
   ```

   If that doesn't print a version (e.g. you're not on TSCC), install your own — see [lessons/07_environments_and_reproducibility.md](day1_foundations/lessons/07_environments_and_reproducibility.md) for the Miniforge install command.
3. Create the environment:

   ```bash
   conda env create -f environments/day1.yml
   conda activate mstp-day1
   ```

   TSCC's `conda` already solves quickly on its own (recent versions default to the fast `libmamba` solver) — you don't need a separate `mamba` install here. If you installed Miniforge yourself in step 2 and have a real `mamba` command, that works too: `mamba env create -f environments/day1.yml`.

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
