# Day 2 - Single-Cell RNA-seq

**REQUIRED DAY 2**

## Learning Goals

By the end of today, you should be able to:

- Explain why a cell is not automatically an independent biological replicate.
- Trace the path from FASTQ to a count matrix, and explain why STARsolo needs a pre-built genome index rather than building one live.
- Load a count matrix into `scanpy`/`AnnData`, and apply and justify QC thresholds rather than copying defaults.
- Normalize, reduce dimensionality, cluster, and annotate cell types — and explain why a clustering resolution or an annotation needs justification, not just a colored UMAP.
- Use the extended Agent B checklist to audit a single-cell analysis for scRNA-seq-specific failure modes.
- Describe, at a conceptual level, what spatial transcriptomics and a few advanced single-cell techniques add beyond today's pipeline.

## Environment

Notebooks 05-08 need `scanpy`, `squidpy`, and friends. Unlike Day 1, you won't create this yourself — `environments/day2.yml` is a heavy environment (`squidpy` and `jupyterlab` between them pull in a large dependency tree), and creating it is slow enough on this filesystem that it isn't practical for everyone to do live in a 4-hour class. It's already built and shared, read-only, at `/tscc/nfs/home/juf009/envs/mstp-day2`.

Register it as a Jupyter kernel (this writes to *your own* home directory, not the shared environment):

```bash
/tscc/nfs/home/juf009/envs/mstp-day2/bin/python -m ipykernel install --user \
  --name mstp-day2 --display-name "Python (mstp-day2)"
```

VS Code's kernel picker only scans for kernels when it starts up, so it won't see this new one until you reload: open the Command Palette (`Cmd+Shift+P` / `Ctrl+Shift+P`) and run **Developer: Reload Window**.

Then, in VS Code or Jupyter, select **Python (mstp-day2)** as the kernel before running any notebook cells. (If you ever want a terminal with it active instead: `conda activate /tscc/nfs/home/juf009/envs/mstp-day2`.)

## Where today's data lives

Today's shared dataset sits at **`/tscc/nfs/home/juf009/day2_shared_data/`** — outside the git repo entirely (it's real sequencing data, and Day 1's [06_git_basics.md](../day1_foundations/lessons/06_git_basics.md) already covered why that never belongs in a repo, even when it's small and public like this one). Your account can read it:

```text
/tscc/nfs/home/juf009/day2_shared_data/
  raw/         the FASTQs, gene annotation, and barcode whitelist
  reference/   the genome and the built STAR index
  counts/      the alignment output, including checkpoint.h5ad
```

[03_raw_data_fastq_to_counts.md](lessons/03_raw_data_fastq_to_counts.md) has you read real files directly from here.

## Four-Hour Schedule

| Time | Activity |
| --- | --- |
| 0:00-0:15 | Recap + single-cell orientation |
| 0:15-0:35 | Agent-assisted scRNA-seq workflow + extended Agent B checklist |
| 0:35-1:05 | Raw data: peek at real FASTQs, walk through the indexing/alignment commands, inspect real output |
| 1:05-1:20 | Your own Slurm practice job |
| 1:20-1:30 | Break |
| 1:30-2:00 | Loading data + QC (notebook) |
| 2:00-2:25 | Normalization + feature selection (notebook) |
| 2:25-2:35 | Break |
| 2:35-3:05 | Dimensionality reduction + clustering (notebook) |
| 3:05-3:30 | Cell-type annotation (notebook) |
| 3:30-3:45 | Spatial transcriptomics preview |
| 3:45-4:00 | Advanced single-cell preview + wrap-up |

## Required Path

1. Read lessons 01-04 in order, doing the hands-on parts as you go: peeking at real files in lesson 03, and submitting your own Slurm job in lesson 04.
2. Work through notebooks 05-08 in order — QC, normalization, clustering, annotation. Run every cell yourself; don't just read them.
3. Read lessons 09-11 as conceptual previews — no hands-on component, same posture as Day 1's [11_where_to_go_next.md](../day1_foundations/lessons/11_where_to_go_next.md).

## Today's Dataset

One shared class dataset, not a personalized track per student (see [Day 1's note on why personalized tracks were removed](../day1_foundations/README.md#personalized-tracks-removed-for-now)): 10x Genomics "1k PBMCs from a Healthy Donor" (v3 chemistry), subsampled to ~300 cells for teaching, from [Zenodo record 3457880](https://zenodo.org/record/3457880). Everyone does their own downstream analysis (QC through annotation) on the same alignment output — this keeps compute predictable and means the whole class can troubleshoot the same data together.

## Lessons

- [01 Recap and single-cell orientation](lessons/01_recap_and_single_cell_orientation.md)
- [02 Agent-assisted scRNA-seq workflow](lessons/02_agent_assisted_scrna_workflow.md)
- [03 Raw data: FASTQ to counts](lessons/03_raw_data_fastq_to_counts.md)
- [04 HPC practice: submitting your own job](lessons/04_hpc_practice.md)
- [05 Loading data and QC](lessons/05_loading_data_and_qc.ipynb) (notebook)
- [06 Normalization and feature selection](lessons/06_normalization_and_feature_selection.ipynb) (notebook)
- [07 Dimensionality reduction and clustering](lessons/07_dimensionality_reduction_and_clustering.ipynb) (notebook)
- [08 Cell-type annotation](lessons/08_cell_type_annotation.ipynb) (notebook)
- [09 Spatial transcriptomics preview](lessons/09_spatial_transcriptomics_preview.md)
- [10 Advanced single-cell preview](lessons/10_advanced_single_cell_preview.md)
- [11 Where to go next](lessons/11_where_to_go_next.md)

## Future Days

Future folders such as `day3_...` may be added later without reorganizing Day 1 or Day 2.
