# Command Line

**REQUIRED DAY 1**

## Why the command line, when we have VS Code and Jupyter?

Almost everything you'll do this week — running Python, using Git, submitting HPC jobs, moving files around on a remote cluster — happens through a shell underneath the GUI. VS Code's integrated terminal, Jupyter's `!` shell escapes, and TSCC's login node are all just terminals. Comfort here is the single skill that makes everything downstream easier.

## Getting a terminal open

- **macOS**: open the built-in **Terminal** app, or [iTerm2](https://iterm2.com/) for a nicer experience. macOS ships `zsh` by default.
- **Windows**: use the terminal built into VS Code once installed ([05_vscode_and_jupyter.md](05_vscode_and_jupyter.md)), or install [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) for a real Linux shell — recommended if you'll do a lot of command-line work locally.
- **Linux**: any terminal emulator; the default shell is usually `bash`.
- **On TSCC (HPC)**: you always get a shell the moment you `ssh` in — see [10_hpc_and_slurm.md](10_hpc_and_slurm.md).

## Navigating the filesystem

```bash
pwd            # print working directory — "where am I?"
ls             # list files in the current directory
ls -la         # list all files (including hidden), with details
cd path/       # change directory
cd ..          # go up one level
cd ~           # go to your home directory
```

Paths: `.` means "here," `..` means "one folder up," an **absolute path** starts from the filesystem root (`/tscc/projects/...`), and a **relative path** is interpreted from your current directory. Use **Tab** to autocomplete file and directory names — it prevents typos and is faster than typing full names.

## Working with files and directories

```bash
mkdir new_folder      # create a directory
cp source dest        # copy a file
mv source dest        # move or rename a file
head -n 5 file.csv     # first 5 lines
tail -n 5 file.csv     # last 5 lines
less file.csv          # page through a file (q to quit)
wc -l file.csv          # count lines
```

## `rm` — treat carefully

```bash
rm file.txt        # deletes a file — no trash bin, no undo
rm -r folder/       # deletes a folder and everything inside it
```

There is no "are you sure?" prompt by default and no recycle bin. Before running `rm`, run `ls` on the same pattern first to see exactly what will be deleted. Never run `rm -rf` on a path you have not just double-checked with `pwd`/`ls`.

## Finding and filtering things

```bash
grep "pattern" file.txt          # find lines matching a pattern
grep -r "pattern" folder/        # search recursively through a folder
find . -name "*.csv"             # find files by name pattern
sort file.txt                    # sort lines
uniq                              # collapse adjacent duplicate lines (often used after sort)
cut -d, -f1 file.csv               # extract a column from delimited text
```

## Wildcards, pipes, and redirection

```bash
ls *.fastq.gz              # wildcard: all files ending in .fastq.gz

cat file.txt | grep "gene" | wc -l   # pipe: feed one command's output into the next

python script.py > output.txt        # redirect stdout to a file (overwrite)
python script.py >> output.txt       # redirect stdout to a file (append)
python script.py 2> errors.log       # redirect stderr to a file
```

Pipes (`|`) are how you compose small, single-purpose commands into a more complex query without writing a script.

## Getting help

```bash
man ls          # manual page (q to quit)
ls --help       # short usage summary
```

When an agent or a tutorial gives you a command you don't recognize, run `--help` or `man` on it before running it — especially for anything involving `rm`, `mv`, or a pipe into `sh`/`bash`.

## Reading errors without panicking

You will hit errors today — in the shell, and later in Python. That's normal, not a sign you broke something. The skill worth building on Day 1 isn't "avoid errors," it's "read one calmly and figure out the next step."

A few common shell errors and what they actually mean:

```text
command not found          -> the program isn't installed, or isn't on your PATH
No such file or directory  -> you mistyped a path, or you're in the wrong directory (check with pwd/ls)
Permission denied           -> you don't have rights to read/write/execute that file (see chmod, or you need sudo)
```

Python errors (**tracebacks**) look longer and more alarming, but the important part is almost always the **last line**:

```text
Traceback (most recent call last):
  File "script.py", line 12, in <module>
    result = counts["gene_id"] / n_samples
KeyError: 'gene_id'
```

Read a traceback **bottom-to-top**: the last line (`KeyError: 'gene_id'`) tells you *what* went wrong; the lines above it show *where*, tracing back through the function calls that led there. Start at the bottom, not the top.

When you're stuck:

1. Read the last line first. It usually names the actual problem (a missing column, a wrong type, a file that doesn't exist).
2. Check the concrete thing it's complaining about — does that file/column/variable actually exist where you think it does?
3. If it's still unclear, paste the **exact error text** (not a paraphrase) into a search engine or your coding agent, along with the one or two lines of code that produced it. "It doesn't work" gets a much worse answer than the real error message. See [08_coding_agents.md](08_coding_agents.md) for using an agent to explain and fix errors as part of the RUN step.

## Practice

From this repository's root, try:

```bash
cd day1_foundations/lessons
ls -la
wc -l *.md
grep -l "REQUIRED" *.md
```

## Further reading

- [The Unix Shell — Software Carpentry](https://swcarpentry.github.io/shell-novice/) — the standard, free introduction; do this if command line is new to you.
- [explainshell.com](https://explainshell.com/) — paste any shell command to get a breakdown of every flag.
- [command_line_cheatsheet.md](../../resources/cheatsheets/command_line_cheatsheet.md) — this course's quick-reference version.
