# Day 2 - Single-Cell RNA-seq

**REQUIRED DAY 2**

## Learning Goals

By the end of today, you should be able to:

- Explain why a cell is not automatically an independent biological replicate.
- Trace the path from FASTQ to a count matrix, and explain why STARsolo needs a pre-built genome index rather than building one live.
- Load a count matrix into `scanpy`/`AnnData`, and apply and justify QC thresholds rather than copying defaults.
- Normalize, reduce dimensionality, cluster, and annotate cell types — and explain why a clustering resolution or an annotation needs justification, not just a colored UMAP.
- Recognize a batch effect on a UMAP, and correct one with Harmony — and explain why a correction needs to be justified by what the batch variable actually represents, not applied by default.
- Use the extended Agent B checklist to audit a single-cell analysis for scRNA-seq-specific failure modes.
- Run a first hands-on spatial transcriptomics analysis (squidpy) and a first hands-on trajectory analysis (PAGA/diffusion pseudotime) — time permitting; see the schedule note below.

## A note on today's scope

Today's notebooks now cover more than a single 4-hour class comfortably fits: batch correction (new, inside notebook 07), a group cell-annotation activity (new, inside notebook 08), and hands-on spatial (09) and trajectory (10) analyses that used to be conceptual-only previews. Rather than cut any of it, the honest thing is to say so directly: **treat 09 and 10 as time-permitting/take-home if the day runs long**, same spirit as this course's existing "read the extra parts on your own time" posture elsewhere. If you'd rather formally extend Day 2, that's a real option too — see the schedule below for where the extra time actually goes.

## Environment

Notebooks 05-10 need `scanpy`, `squidpy`, `harmonypy`, and friends. Unlike Day 1, you won't create this yourself — `environments/day2.yml` is a heavy environment (`squidpy` and `jupyterlab` between them pull in a large dependency tree), and creating it is slow enough on this filesystem that it isn't practical for everyone to do live in a 4-hour class. It's already built and shared, read-only, at `/tscc/nfs/home/juf009/envs/mstp-day2`.

Register it as a Jupyter kernel (this writes to *your own* home directory, not the shared environment):

```bash
/tscc/nfs/home/juf009/envs/mstp-day2/bin/python -m ipykernel install --user \
  --name mstp-day2 --display-name "Python (mstp-day2)"
```

Launch Jupyter the same way you did on Day 1 — `module load galyleo` then `galyleo launch ...` (see [05_jupyter_on_tscc.md](../day1_foundations/lessons/05_jupyter_on_tscc.md)) — open the URL it gives you, and select **Python (mstp-day2)** as the kernel before running any notebook cells. Jupyter's kernel picker only scans for kernels when it starts up, so if you registered the kernel *after* opening Jupyter, reload the browser tab (or relaunch `galyleo`) to see it.

(If you ever want a terminal with it active instead: `conda activate /tscc/nfs/home/juf009/envs/mstp-day2`. If you're using VS Code as an optional editor, the same kernel is selectable there too, once it's registered.)

## Where today's data lives

Today's shared dataset sits at **`/tscc/nfs/home/juf009/day2_shared_data/`** — outside the git repo entirely (it's real sequencing data, and Day 1's [06_git_basics.md](../day1_foundations/lessons/06_git_basics.md) already covered why that never belongs in a repo, even when it's small and public like this one). Your account can read it:

```text
/tscc/nfs/home/juf009/day2_shared_data/
  raw/               the FASTQs, gene annotation, and barcode whitelist
  reference/         the genome and the built STAR index
  counts/            the alignment output, including checkpoint.h5ad
  extra_datasets/    pbmc3k, paul15, and visium_hne — pre-fetched for notebooks 07/09/10 (see below)
```

[03_raw_data_fastq_to_counts.md](lessons/03_raw_data_fastq_to_counts.md) has you read real files directly from here.

**Why these extra datasets are pre-fetched rather than downloaded live in each notebook:** `sc.datasets.pbmc3k()`, `sc.datasets.paul15()`, and `sq.datasets.visium_hne_adata()` each pull data from the internet the first time they're called, and compute nodes on a shared cluster don't reliably have the same open internet access a login node does. Rather than have 20+ students simultaneously depend on live network access mid-class, these three were fetched once, ahead of time, into the shared folder above — the notebooks read them from there.

## Four-Hour Schedule (core path — see the scope note above for 09/10)

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
| 2:35-3:15 | Dimensionality reduction + clustering, including the Harmony batch-correction section (notebook) |
| 3:15-3:45 | Cell-type annotation, including the group cluster-ID activity (notebook) |
| 3:45-4:00 | Wrap-up + set up 09/10 as take-home if time ran out |

## Extended/Optional Block (~1-1.5 hours, if the day is extended)

| Time | Activity |
| --- | --- |
| +0:00-0:35 | Spatial transcriptomics: a first look (notebook) |
| +0:35-1:10 | Trajectory analysis: a first look (notebook) |

## Required Path

1. Read lessons 01-04 in order, doing the hands-on parts as you go: peeking at real files in lesson 03, and submitting your own Slurm job in lesson 04.
2. Work through notebooks 05-08 in order — QC, normalization, clustering (now including batch correction), annotation (now including the group activity). Run every cell yourself; don't just read them.
3. Work through notebooks 09-10 — spatial, trajectory — same "run every cell" expectation as 05-08, time-permitting/take-home per the scope note above.
4. Read lesson 11 — where to go next.

## Today's Datasets

The main dataset is one shared class dataset, not a personalized track per student (see [Day 1's note on why personalized tracks were removed](../day1_foundations/README.md#personalized-tracks-removed-for-now)): 10x Genomics "1k PBMCs from a Healthy Donor" (v3 chemistry), subsampled to ~300 cells for teaching, from [Zenodo record 3457880](https://zenodo.org/record/3457880). Everyone does their own downstream analysis (QC through annotation) on the same alignment output — this keeps compute predictable and means the whole class can troubleshoot the same data together.

Three more real, public datasets support specific sections:

- **[`sc.datasets.pbmc3k()`](https://scanpy.readthedocs.io/en/stable/generated/scanpy.datasets.pbmc3k.html)** (10x v1 chemistry, ~2700 cells, 2016) — used in notebook 07's batch-correction section, paired against today's main sample (10x v3, more recent) specifically because the two use different-enough chemistry to produce a real, visible batch effect worth correcting.
- **[`sc.datasets.paul15()`](https://scanpy.readthedocs.io/en/stable/generated/scanpy.datasets.paul15.html)** (Paul et al. 2015, myeloid/erythroid differentiation) — used in notebook 10 for trajectory analysis; scanpy's own standard PAGA/diffusion-pseudotime tutorial dataset.
- **[`sq.datasets.visium_hne_adata()`](https://squidpy.readthedocs.io/en/stable/api/squidpy.datasets.visium_hne_adata.html)** (10x Visium, mouse brain, H&E) — used in notebook 09 for spatial analysis; squidpy's own standard teaching dataset.

## Lessons

- [01 Recap and single-cell orientation](lessons/01_recap_and_single_cell_orientation.md)
- [02 Agent-assisted scRNA-seq workflow](lessons/02_agent_assisted_scrna_workflow.md)
- [03 Raw data: FASTQ to counts](lessons/03_raw_data_fastq_to_counts.md)
- [04 HPC practice: submitting your own job](lessons/04_hpc_practice.md)
- [05 Loading data and QC](lessons/05_loading_data_and_qc.ipynb) (notebook)
- [06 Normalization and feature selection](lessons/06_normalization_and_feature_selection.ipynb) (notebook)
- [07 Dimensionality reduction, clustering, and batch correction](lessons/07_dimensionality_reduction_and_clustering.ipynb) (notebook)
- [08 Cell-type annotation](lessons/08_cell_type_annotation.ipynb) (notebook)
- [09 Spatial transcriptomics: a first look](lessons/09_spatial_transcriptomics.ipynb) (notebook)
- [10 Trajectory analysis: a first look](lessons/10_trajectory_analysis.ipynb) (notebook)
- [11 Where to go next](lessons/11_where_to_go_next.md)

## A note on style: this leans more "fill in the blank" than Day 1

Notebooks 05-10 lean on a pattern adapted from Harvard's BMI710 (a Seurat/R single-cell course): prose sets up *why* a step matters and gives you a doc link, and you write the actual function call yourself rather than reading it pre-written. The genuine judgment calls (a QC threshold, a PC count, a clustering resolution) were already handled this way; more of the mechanical steps now are too, particularly the first time you meet a given function. If you get stuck on what a cell is asking for, the linked scanpy docs (and the Seurat-equivalent links in each notebook's "Further reading," if you want to compare) are the same references a working analyst would actually reach for — that's the point, not a hint being deliberately withheld.

## Future Days

Future folders such as `day3_...` may be added later without reorganizing Day 1 or Day 2.
