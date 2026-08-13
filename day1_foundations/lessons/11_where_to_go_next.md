# Where To Go Next

**ADVANCED**

## The reproducibility ladder

Day 1 gets you through the first four rungs:

| Level | What it means | Where you did it today |
| --- | --- | --- |
| 1. Save code | The analysis exists as a script/notebook, not just commands typed once. | [05_jupyter_on_tscc.md](05_jupyter_on_tscc.md) |
| 2. Version code | Changes are tracked, with history, in Git. | [06_git_basics.md](06_git_basics.md) |
| 3. Specify dependencies | The environment is a file (`environment.yml`), not tribal knowledge. | [07_environments_and_reproducibility.md](07_environments_and_reproducibility.md) |
| 4. Automate execution | The analysis runs the same way locally and on a scheduler. | [10_hpc_and_slurm.md](10_hpc_and_slurm.md) |

The next rungs — not required for Day 1, but worth knowing exist:

## 5. Containers

A container packages the *entire* runtime (OS libraries, compilers, not just Python packages) so an analysis behaves identically on any machine, including years later when the original OS/library versions are gone.

- [Docker: Get Started](https://docs.docker.com/get-started/) — the most common container tool, widely used for local development.
- [Apptainer (formerly Singularity)](https://apptainer.org/docs/user/main/index.html) — the container runtime typically used on HPC clusters like TSCC, since Docker itself usually can't run unprivileged on shared systems.

## 6. Workflow managers (Snakemake / Nextflow)

Once an analysis has multiple steps with dependencies between them (align -> count -> normalize -> test), a workflow manager tracks which steps need to rerun when an input changes, and can parallelize independent steps automatically. See the tiny preview in [tiny_snakemake_preview.md](../templates/workflow_previews/tiny_snakemake_preview.md).

- [Snakemake documentation](https://snakemake.readthedocs.io/)
- [Nextflow documentation](https://www.nextflow.io/docs/latest/index.html)

## 7. Cloud / HPC portability

Writing an analysis so it can move between TSCC, another university's cluster, and a cloud provider without rewriting the science — usually achieved by combining containers (rung 5) with a workflow manager (rung 6), so the *infrastructure-specific* part is confined to a small execution config rather than the analysis code itself.

- [Nextflow: executors](https://www.nextflow.io/docs/latest/executor.html) — one config mechanism for this.
- [Snakemake: cluster execution](https://snakemake.readthedocs.io/en/stable/executing/cluster.html)

## 8. Larger, domain-specific workflows

Once the fundamentals above are solid, most domains have established community pipelines rather than hand-rolled scripts:

- [nf-core](https://nf-core.org/) — a curated collection of peer-reviewed Nextflow pipelines (RNA-seq, variant calling, single-cell, and more).
- [Galaxy Project](https://usegalaxy.org/) — a browser-based platform for running established bioinformatics workflows without writing code.

None of this replaces the judgment from [02_analysis_workflow.md](02_analysis_workflow.md) and [09_agent_validation.md](09_agent_validation.md) — better infrastructure makes a correct analysis easier to scale and reproduce; it does not make an incorrectly designed one correct.
