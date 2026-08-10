# START HERE

**REQUIRED DAY 1**

This is where Day 1 actually begins — if you haven't seen the welcome in [README.md](README.md) yet, it's worth a minute, but this file is the one that gets you moving.

One honest note before we start: you should already have TSCC login access (contact your PI/lab administrator beforehand if not — this isn't something today's material can set up for you) and Git/conda-or-mamba available somewhere you can reach a terminal. If any of that isn't true yet, that's completely normal for Day 1 morning — flag an instructor or TA right now and we'll sort it out together, rather than quietly struggling through an install while everyone else moves on.

Everything below is the minimum to get moving — each step is explained properly later today (VS Code and Remote-SSH in [lessons/05_vscode_and_jupyter.md](day1_foundations/lessons/05_vscode_and_jupyter.md), Git in [lessons/06_git_basics.md](day1_foundations/lessons/06_git_basics.md), conda/mamba in [lessons/07_environments_and_reproducibility.md](day1_foundations/lessons/07_environments_and_reproducibility.md)). For now, just get each step done; you're welcome to jump ahead and read any of those in full first if you'd rather understand before you type.

1. **Get connected and get the repo.** Install [VS Code](https://code.visualstudio.com/), then its Remote-SSH extension, and connect to TSCC (`ssh your_username@login.tscc.sdsc.edu`, or the equivalent inside VS Code). Once connected, clone this repository somewhere under your own space on TSCC:

   ```bash
   git clone <this repository's URL>
   cd mstp-2026-bioinformatics-bootcamp
   ```

   Open this cloned folder in VS Code (**File > Open Folder**). Everything else below happens from inside it.
2. Create the environment:

   ```bash
   mamba env create -f environments/day1.yml
   conda activate mstp-day1
   ```

   Conda-only fallback:

   ```bash
   conda env create -f environments/day1.yml
   conda activate mstp-day1
   ```

3. Confirm which Python you are using:

   ```bash
   which python
   python --version
   ```

4. Go to [day1_foundations/README.md](day1_foundations/README.md).
5. Follow the lessons in order, and actually do each lesson's Practice section as you go.

Today's validation model is:

```text
Agent validation + automated validation + scientific validation
```

Multiple agents agreeing is useful evidence, not proof. You still make the scientific judgment.
