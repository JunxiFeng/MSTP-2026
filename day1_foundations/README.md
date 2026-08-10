# Day 1 - Bioinformatics Foundations

**REQUIRED DAY 1**

## Learning Goals

By the end of today, you should be able to:

- Start from a biological question before choosing software.
- Explain how biological measurements become files and metadata.
- Navigate a Git repository and make one local commit.
- Create and verify a reproducible Python environment.
- Install a coding agent and write a prompt that gives it the biological context it needs.
- Explain why independent agent validation matters, using the reusable Agent B prompt.
- Submit a job through Slurm and confirm it ran in the environment you expect.

## Four-Hour Schedule

| Time | Activity |
| --- | --- |
| 0:00-0:25 | What bioinformatics is + workflow design |
| 0:25-0:45 | Sequencing / data generation / file types |
| 0:45-1:05 | Command line + VS Code/Jupyter |
| 1:05-1:15 | Break |
| 1:15-1:40 | Git + repository structure |
| 1:40-2:05 | Environments + reproducibility |
| 2:05-2:15 | Break |
| 2:15-2:45 | Coding agents + effective prompting |
| 2:45-3:10 | Independent agent validation + automated checks |
| 3:10-3:35 | Open practice / Q&A (buffer for whichever lesson needed more time) |
| 3:35-3:55 | HPC + Slurm |
| 3:55-4:00 | Containers + Snakemake/Nextflow preview |

## Required Path

1. Read lessons 01-11 in order.
2. Actually do each lesson's **Practice** section — don't just read it. Every lesson from 04 onward has one: shell commands in [04_command_line.md](lessons/04_command_line.md), installing/connecting VS Code in [05_vscode_and_jupyter.md](lessons/05_vscode_and_jupyter.md), a local commit in [06_git_basics.md](lessons/06_git_basics.md), an environment/kernel check in [07_environments_and_reproducibility.md](lessons/07_environments_and_reproducibility.md), a run of the reusable Agent B prompt in [09_agent_validation.md](lessons/09_agent_validation.md), and a Slurm submission in [10_hpc_and_slurm.md](lessons/10_hpc_and_slurm.md).

## Personalized tracks (removed for now)

Earlier drafts of this course gave each student their own dataset and folder from Day 1 onward. That was cut: maintaining a personalized track per student, per day, for a 5-day bootcamp didn't scale, and it made troubleshooting harder — everyone hitting a different error on different data means nobody in the room can help each other. Everyone now works through the same shared materials and shared datasets (see Day 2 onward), with genuinely independent work returning on [Day 4/5](../day4_5_independent_projects/README.md), once everyone has the same shared foundation to work from.

## Workflow Diagram

```text
Biological question
-> study design
-> data generation
-> files + metadata
-> Git repository
-> reproducible environment
-> data inspection
-> Agent A analysis help
-> Agent B independent audit
-> automated checks
-> local execution
-> HPC execution
-> biological interpretation
-> validation / next experiment
```

## Lessons

- [01 What is bioinformatics?](lessons/01_what_is_bioinformatics.md)
- [02 Analysis workflow](lessons/02_analysis_workflow.md)
- [03 Data generation and sequencing](lessons/03_data_generation_and_sequencing.md)
- [04 Command line](lessons/04_command_line.md)
- [05 VS Code and Jupyter](lessons/05_vscode_and_jupyter.md)
- [06 Git basics](lessons/06_git_basics.md)
- [07 Environments and reproducibility](lessons/07_environments_and_reproducibility.md)
- [08 Coding agents](lessons/08_coding_agents.md)
- [09 Agent validation](lessons/09_agent_validation.md)
- [10 HPC and Slurm](lessons/10_hpc_and_slurm.md)
- [11 Where to go next](lessons/11_where_to_go_next.md)
