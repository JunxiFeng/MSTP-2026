# VS Code And Jupyter

**REQUIRED DAY 1**

## The pieces, and how they fit together

| Piece | What it is |
| --- | --- |
| **VS Code** | A code editor — where you read, write, and navigate files. |
| **Jupyter** | An interactive notebook format (`.ipynb`) — code + output + notes in one document, run cell by cell. |
| **Python** | The programming language most of Day 1 uses. |
| **Terminal** | The shell running underneath the editor (see [04_command_line.md](04_command_line.md)). |
| **HPC (TSCC)** | Remote compute infrastructure your code can run on instead of your laptop (see [10_hpc_and_slurm.md](10_hpc_and_slurm.md)). |

The single most important habit this section teaches: **always know where your code is actually running** — on your laptop, or on a TSCC login/compute node — and **which Python interpreter** is executing it. VS Code, Jupyter, and the shell each have their own, independent notion of "current Python," and they can silently disagree.

## 1. Install VS Code

Download and install from [code.visualstudio.com](https://code.visualstudio.com/) (macOS, Windows, Linux all supported).

## 2. Install the extensions you'll need

Open the **Extensions** view (the square-icon in the left sidebar, or `Ctrl+Shift+X` / `Cmd+Shift+X`) and install:

- **Python** (`ms-python.python`) — Python language support, interpreter selection, debugging.
- **Jupyter** (`ms-toolsai.jupyter`) — run and edit `.ipynb` notebooks inside VS Code.
- **Remote - SSH** (`ms-vscode-remote.remote-ssh`) — open a VS Code window whose files, terminal, and extensions all run *on a remote machine* (like TSCC) over SSH.

## 3. Connect VS Code to TSCC with Remote-SSH

You already did the mechanics of this in [START_HERE.md](../../START_HERE.md) to get this repository open — this section is about understanding what actually happened. First, plain SSH access from a terminal (account/access details, if you ever need them fresh, are in [10_hpc_and_slurm.md](10_hpc_and_slurm.md)):

```bash
ssh your_username@login.tscc.sdsc.edu
```

To make this reusable by VS Code, add an entry to `~/.ssh/config` on your **local** machine:

```text
Host tscc
    HostName login.tscc.sdsc.edu
    User your_username
```

Then in VS Code:

1. Open the Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`).
2. Run **Remote-SSH: Connect to Host...**
3. Select `tscc` (the entry you just added).
4. A new VS Code window opens, connected to the TSCC login node. Use **File > Open Folder** to open your project directory there (e.g., your cloned course repository under `/tscc/projects/...` or your home directory).

Everything you do in this window — the integrated terminal, the Python interpreter, Jupyter — now runs on TSCC, not on your laptop. Heavy computation should still be submitted through Slurm rather than run directly on the login node (see [10_hpc_and_slurm.md](10_hpc_and_slurm.md)) — Remote-SSH is for editing, light interactive testing, and submitting jobs, not for running the analysis itself on the login node.

## 4. Create and run a Jupyter notebook

Jupyter itself isn't a separate install: `jupyterlab` and `ipykernel` are already listed in [environments/day1.yml](../../environments/day1.yml), so building the `mstp-day1` environment in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md) installs them along with everything else. The **Jupyter** extension you installed in step 2 above is what lets VS Code *open and run* `.ipynb` files — it's not Jupyter itself.

**Create a new notebook file:**

- In the Explorer (left sidebar), right-click a folder and choose **New File...**, then name it with a `.ipynb` extension (e.g. `scratch.ipynb`). VS Code recognizes the extension and opens it as a notebook.
- Or: Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`) -> **Jupyter: Create New Jupyter Notebook**.

Either way you get an empty notebook with one code cell, ready to type into.

**Select the kernel** (which Python environment actually runs your cells):

1. Click **Select Kernel** in the top-right corner of the notebook.
2. Choose **Python Environments...** from the list.
3. Pick `mstp-day1` (or `Python (mstp-day1)`) — the environment you created in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md). If it isn't in the list, go run the `python -m ipykernel install ...` step there, then come back and select it.
4. The top-right corner now shows `mstp-day1` — that's your confirmation the right kernel is active.

This must match the environment you created in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md) — a notebook running the wrong kernel will fail to import packages, or silently use the wrong versions.

**Run cells:**

- `Shift+Enter` runs the current cell and moves to the next (creating a new empty one at the end if needed).
- `Ctrl+Enter` / `Cmd+Enter` runs the current cell and stays put.
- The same notebook file works whether VS Code is running locally or remotely connected to TSCC via Remote-SSH — only the kernel selection changes.

## 5. Select the right Python interpreter

For plain `.py` scripts (not notebooks), click the Python version shown in the bottom-right status bar, or run **Python: Select Interpreter** from the Command Palette, and choose the `mstp-day1` conda environment. This is one of the four places `python` can secretly mean something different — see the check in [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md).

## Practice

1. Confirm the three extensions above are installed (you installed VS Code itself and connected via Remote-SSH already, in START_HERE.md).
2. If you haven't already, open this repository as a folder in your Remote-SSH-connected window (**File > Open Folder**).
3. Open `day1_foundations/templates/diagnostic_scripts/check_python.py`, select the `mstp-day1` interpreter, and run it — confirm the printed path points at the environment you expect.
4. Open (or create) a notebook, select the `mstp-day1` kernel, and run one cell.

## Further reading

- [VS Code: Remote-SSH tutorial](https://code.visualstudio.com/docs/remote/ssh-tutorial)
- [VS Code: Python in Visual Studio Code](https://code.visualstudio.com/docs/python/python-tutorial)
- [VS Code: Working with Jupyter Notebooks in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-notebooks)
- [Jupyter Project documentation](https://docs.jupyter.org/en/latest/)
