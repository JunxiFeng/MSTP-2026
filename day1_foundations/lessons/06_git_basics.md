# Git Basics

**REQUIRED DAY 1**

## Git vs. GitHub

**Git** is a program that tracks versions of files on your machine. **GitHub** is a website that hosts copies of Git repositories so you can share and back up your work. You can use Git without ever touching GitHub; you cannot use GitHub without Git.

## 1. Install Git

- **macOS**: usually preinstalled; otherwise `brew install git` or install [Xcode Command Line Tools](https://developer.apple.com/xcode/resources/).
- **Windows**: install [Git for Windows](https://git-scm.com/download/win), which also provides Git Bash.
- **Linux**: `sudo apt install git` (Debian/Ubuntu) or your distro's package manager.
- **On TSCC**: Git is already available as part of the standard shell environment (check with `git --version`).

Check the install:

```bash
git --version
```

## 2. Configure your identity (one-time setup)

Every commit records who made it. Set this once per machine:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## 3. Create a GitHub account and connect it

1. Create a free account at [github.com](https://github.com/).
2. Authenticate so you can push/pull without typing a password every time. Two common options:
   - **HTTPS + Personal Access Token** — see [Managing your personal access tokens](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens).
   - **SSH key** — see [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) (generate a key with `ssh-keygen`, add the public key to your GitHub account).
   - Alternatively, install the [GitHub CLI](https://cli.github.com/) and run `gh auth login`, which handles this interactively.

## 4. The core commands

```bash
git clone URL              # copy a remote repository to your machine
git status                 # what's changed since the last commit?
git diff                   # line-by-line view of unstaged changes
git add FILE               # stage a file for the next commit
git commit -m "message"    # record a snapshot of staged changes
git log --oneline          # history of commits
git pull                   # fetch + merge remote changes into your branch
git push                   # send your local commits to the remote
```

A typical local loop:

```bash
git status                  # see what changed
git add analysis.py         # stage the file(s) you want to commit
git commit -m "Add differential expression script"
git log --oneline           # confirm it's recorded
```

## 5. Branches, briefly

A branch is an independent line of work. `main` (or `master`) is usually the primary branch.

```bash
git checkout -b my-feature   # create and switch to a new branch
git checkout main            # switch back to main
```

You won't need branching heavily on Day 1, but it's worth knowing it exists before you need to isolate an experiment from working code.

## 6. `.gitignore`

A `.gitignore` file tells Git which files/folders to never track (logs, large outputs, local secrets). Add patterns like:

```text
*.log
__pycache__/
.env
```

## What never goes into a commit

Do not commit PHI, credentials, API keys, SSH private keys, tokens, restricted datasets, or large raw sequencing files. Once something is committed, it lives in the repository's history even if you delete it in a later commit — treat "already pushed" as "permanent" unless you know how to rewrite history (out of scope for Day 1; ask an instructor if this happens).

## Practice

You already ran `git clone` in [START_HERE.md](../../START_HERE.md) to get this repository in the first place — this is about actually understanding what that did:

```bash
git status
git log --oneline -5
```

Then make one small change to any file (a scratch note, a typo fix — it doesn't need to matter), `git add` it, and `git commit` it locally.

## Further reading

- [Pro Git (free online book)](https://git-scm.com/book/en/v2) — the definitive, thorough reference.
- [GitHub Skills](https://skills.github.com/) — free, interactive GitHub tutorials in your browser.
- [Learn Git Branching](https://learngitbranching.js.org/) — interactive visualization if branching/merging is confusing.
- [git_cheatsheet.md](../../resources/cheatsheets/git_cheatsheet.md) — this course's quick-reference version.
