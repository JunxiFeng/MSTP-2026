# MSTP 2026 Bioinformatics Bootcamp

## Welcome

If you're opening this having barely touched a terminal, or it's been years since you last wrote a line of code, you are exactly who this bootcamp is for. Almost everyone who's gone through this material started from close to zero. The goal this week isn't to turn you into a software engineer — it's to give you enough comfort with these tools that, in your own research, you can go from a biological question to computational evidence you actually trust, instead of code you just hope is right.

You will feel behind at some point. That's normal, not a sign you're missing something everyone else already has. Ask questions out loud, ask the person next to you, ask an instructor, ask a coding agent — learning to ask well is genuinely one of the skills this week is trying to build, not a fallback for when the material fails you.

## What we hope you leave with

- Comfort starting from a biological question and study design, before reaching for software.
- Enough command-line, Git, and Python-environment literacy that you're not lost inside your own project.
- Real practice using a coding agent well — and just as important, practice not trusting one blindly.
- A first hands-on experience running something on TSCC, our shared HPC cluster.

## Getting started

Open [START_HERE.md](START_HERE.md) — it walks you through today, one step at a time, starting from wherever you actually are right now.

## How this repository is organized

```text
environments/               Shared software environments, one per day (day1.yml, day2.yml, ...)
day1_foundations/           Day 1's lessons, in reading order
day2_single_cell/           Day 2's lessons, in reading order
day3_biological_inference/  Day 3's lessons, in reading order
day4_5_independent_projects/ Days 4-5's independent projects, in reading order
resources/                  Cheatsheets and further-reading, for after (or during) any day
```

Within each day's folder, materials are labeled **REQUIRED DAY N**, **OPTIONAL**, **REFERENCE**, or **ADVANCED** — the required ones are what that day is actually built around; the rest are there if you want to go deeper, now or later.

## Privacy Warning

Do not commit PHI, credentials, passwords, API keys, SSH keys, restricted datasets, or large raw sequencing files. Every dataset committed to this repository is synthetic. Days 2 through 5 use real, public, PHI-free data (10x Genomics demo data; Kang et al. 2018, reused across Day 3 and Day 4/5; GEO GSE174574 and GSE268112; the ScPCA Portal's pediatric osteosarcoma atlas; Sloan, Mares, Daly et al. 2025's human dorsolateral prefrontal cortex aging/senescence atlas) — all fetched by script to shared (non-repo) storage and never committed, with one exception: the ScPCA dataset requires a one-time manual download through the portal's own UI rather than a script, since the portal only issues time-limited signed download links. See [day2_single_cell/README.md](day2_single_cell/README.md), [day3_biological_inference/README.md](day3_biological_inference/README.md), and [day4_5_independent_projects/README.md](day4_5_independent_projects/README.md).
