# Running Jupyter On TSCC

**REQUIRED DAY 1**

## The pieces, and how they fit together

| Piece | What it is |
| --- | --- |
| **Jupyter** | An interactive notebook format (`.ipynb`) — code + output + notes in one document, run cell by cell. |
| **galyleo** | A TSCC tool that launches Jupyter *as a Slurm job on a compute node*, and hands you back a URL to open in your own browser. |
| **Python** | The programming language most of Day 1 uses. |
| **Terminal** | The shell you're launching everything from (see [04_command_line.md](04_command_line.md)). |
| **HPC (TSCC)** | Remote compute infrastructure your code runs on instead of your laptop (see [10_hpc_and_slurm.md](10_hpc_and_slurm.md)). |
| **VS Code** *(optional)* | A code editor, if you'd like one — covered briefly at the end of this lesson. Not required for anything above. |

The single most important habit this section teaches: **always know where your code is actually running** — your laptop, the TSCC login node, or a TSCC compute node — and **which Python interpreter** is executing it. This matters more than usual today, because the wrong choice here is exactly the kind of mistake that's invisible until it isn't: it *looks* like Jupyter is working fine right up until the login node kills your kernel mid-analysis.

## Why not just open a notebook on the login node?

You're already logged in to TSCC's login node — it would be the path of least resistance to just run `jupyter lab` right there and start typing. Don't. The login node is shared by everyone on TSCC at once, has strict per-process memory limits, and is explicitly not for running analysis (see the reminder in [START_HERE.md](../../START_HERE.md) and the full explanation in [10_hpc_and_slurm.md](10_hpc_and_slurm.md)). A Jupyter kernel sitting on the login node, quietly loading a dataset into memory, is exactly the kind of thing that gets killed without warning — or worse, doesn't get killed and slows the login node down for everyone else on it right when you need it to work.

The fix is `galyleo`: it asks Slurm for an actual compute node, starts Jupyter there instead, and gives you a URL that routes to it. One command, and you're correctly on a compute node instead of the login node — no manual `srun`, no SSH tunnel, no juggling multiple terminal windows.

## Launching Jupyter with galyleo

From your TSCC terminal (not inside any conda environment — `galyleo` is a module, separate from your `mstp-day1` environment):

```bash
module load galyleo
galyleo launch --account htl191 --cpus 1 --memory 2 --time-limit 1:00:00 --partition hotel --qos hotel
```

What each flag means:

- `--account htl191` — our bootcamp's Slurm allocation (same one you'll use for every `sbatch`/`srun` this week).
- `--cpus 1 --memory 2` — how much compute to reserve; 1 CPU and 2 GB is plenty for Day 1's notebooks. Later in the week, if a notebook needs more, raise these numbers rather than fighting a slow/killed kernel.
- `--time-limit 1:00:00` — how long the job (and your notebook server) stays alive: one hour here. When it expires, save your work again before then, or relaunch.
- `--partition hotel --qos hotel` — required for this account, same as every other Slurm job you'll submit this week (see [10_hpc_and_slurm.md](10_hpc_and_slurm.md)).

This takes a little while to start — it's genuinely waiting in the Slurm queue for a compute node, not stuck. When it's ready, it prints a URL that looks something like:

```text
http://tscc-11-17.sdsc.edu:8888/lab?token=30e8379d3b4dc998cc52cf4d3343e161b4a76a15874f05d5...
```

Copy that whole URL and paste it into your web browser. **Leave the terminal that printed it open** for as long as you want the notebook server running — closing it ends your session.

## Create and run a notebook

You should now be looking at JupyterLab in your browser, running on a TSCC compute node. From the Launcher tab:

- Click the **Notebook** icon under whichever Python kernel is shown, or use **File > New > Notebook**.
- A new, empty notebook opens, with a single empty code cell.

**Run cells:**

- `Shift+Enter` runs the current cell and moves to the next (creating a new empty one at the end if needed).
- `Ctrl+Enter` / `Cmd+Enter` runs the current cell and stays put.

## Select the right kernel

Jupyter itself isn't a separate install: `jupyterlab` and `ipykernel` are already listed in [environments/day1.yml](../../environments/day1.yml), so building the `mstp-day1` environment (in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md)) installs them along with everything else. But building an environment doesn't automatically make it show up as a *kernel* — that's a separate, explicit registration step, covered in full in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md).

Once registered, select it:

1. Click the kernel name in the top-right corner of the notebook (it'll say something generic at first, like the base Python).
2. Choose **Python (mstp-day1)** from the list.
3. The top-right corner now shows `mstp-day1` — that's your confirmation the right kernel is active.

This must match the environment you created in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md) — a notebook running the wrong kernel will fail to import packages, or silently use the wrong versions. If `mstp-day1` isn't in the list yet, go run the registration step there first, then come back and reload the kernel list (the small circular-arrow icon next to the kernel name, or reload the browser tab).

## Practice

1. Run `module load galyleo` and the `galyleo launch` command above; wait for the URL and open it in your browser.
2. Create a new notebook.
3. Register `mstp-day1` as a kernel if you haven't already (see [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md)), select it, and confirm the top-right corner shows `mstp-day1`.
4. Run `day1_foundations/templates/diagnostic_scripts/check_python.py` from a cell (`!python day1_foundations/templates/diagnostic_scripts/check_python.py`) and confirm the printed path points at the environment you expect.

## Optional: VS Code as an editor

Everything above only needs a browser and a terminal. If you'd still like a proper code editor for browsing/editing files and using Git — genuinely optional, skip this if you're happy in the terminal — here's the short version:

1. Install [VS Code](https://code.visualstudio.com/).
2. Install the **Remote - SSH** extension (Extensions view, or `Ctrl+Shift+X` / `Cmd+Shift+X`; publisher: Microsoft).
3. Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`) → **Remote-SSH: Connect to Host...** → add `your_username@login.tscc.sdsc.edu` → connect.
4. **File > Open Folder** to open your cloned course repository there.

That's it for the editor. **Do not** use VS Code's own Jupyter extension to run notebooks this way — it would either try to run against the login node (the exact thing this lesson is telling you not to do) or require its own separate compute-node dance. For notebooks, always come back to `galyleo` above, in a browser tab, regardless of whether VS Code is also open for editing.

Full walkthrough if you want it: [VS Code Remote-SSH tutorial](https://code.visualstudio.com/docs/remote/ssh-tutorial).

## Further reading

- [VS Code: Python in Visual Studio Code](https://code.visualstudio.com/docs/python/python-tutorial)
- [VS Code: Working with Jupyter Notebooks in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-notebooks)
- [Jupyter Project documentation](https://docs.jupyter.org/en/latest/)
