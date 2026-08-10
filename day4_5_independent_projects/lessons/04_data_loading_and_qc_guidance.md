# Data Loading and QC Guidance

**REQUIRED DAY 4/5**

## Before you open a notebook: confirm your setup via Slurm, not the login node

Same habit as every prior day's HPC practice ([Day 1](../../day1_foundations/lessons/10_hpc_and_slurm.md), [Day 2](../../day2_single_cell/lessons/04_hpc_practice.md), [Day 3](../../day3_biological_inference/lessons/07_gene_expression_programs_and_hpc_practice.md)): confirm your environment and your checkpoint both load correctly through a real `sbatch` job before you do anything interactive. Fill in your own checkpoint path in `templates/slurm_templates/day4_5_practice_job.slurm`, then, from this repository's root:

```bash
sbatch day4_5_independent_projects/templates/slurm_templates/day4_5_practice_job.slurm
squeue -u $USER
```

Check `logs/` once it finishes — you should see your environment's package versions and your checkpoint's real shape/columns printed, with no traceback.

## Where to actually start

Your starter notebook, under `projects/`, already has a tested Data Loading section — real path, real `sc.read_h5ad(...)`, real shape and column output. That part isn't the exercise; confirming you understand what you're looking at is. Before writing any QC code, open your checkpoint and answer, in your own words:

- What is one row of `.obs`? (A cell. Which sample/animal/patient/donor did it come from?)
- What is your grouping variable, and which column holds it?
- Is `.X` raw counts or already normalized? (Check — don't assume. Every checkpoint in this bootcamp so far has told you explicitly; verify it yourself here too, the same way Day 3's lesson 03 verified row sums against a count column.)

## Your own QC, not a copied threshold

Day 2's lesson 05 made this point directly: QC thresholds copied from a tutorial without looking at *this* dataset's own distributions are a checklist item 18 violation waiting to happen. Plot your own distributions (total counts per cell, genes detected per cell, mitochondrial fraction if applicable) before picking a cutoff. Projects 1, 4, and 5 need this from scratch (Project 5's checkpoint has cell-type calls but no QC-metric columns). Project 2's checkpoint already has QC metric columns computed by the source (`sum`, `detected`, `subsets_mito_percent`, `prob_compromised`, `miQC_pass`) — you can use them, but item 26 still applies: look at the distribution yourself before trusting `miQC_pass` as a black box.

## Doublets

`scrublet` (via `scikit-image`, already in `mstp-day4-5`) is available if you need to check for doublets yourself — Projects 1, 3 (if reclustering), 4, and 5 all start without a pre-computed doublet call. Project 2's checkpoint carries `scDblFinder_class`/`scDblFinder_score` from the source pipeline — again, usable, but spot-check a few flagged cells against total-count/complexity outliers rather than accepting the label unread.

## If your dataset needs clustering and annotation

Projects 1 and 4 start from raw counts with no existing cell-type labels — if your question benefits from cell-type resolution (e.g., "does the response differ by cell type" rather than "does it differ overall"), you'll need to normalize, cluster (Leiden, same as Day 2), and annotate using marker genes (checklist item 17: a statistical marker test, not just a colored UMAP). This is optional if your core comparison doesn't need cell-type resolution — a whole-tissue comparison is a legitimate, simpler scope, and simpler is not worse. Project 5 already ships three resolutions of cell-type calls (`cc_broadclass`/`cc_celltype`/`cc_celltype_k36`) — checklist item 26 applies directly: spot-check at least one against a marker gene before trusting it.

## Practice

In your starter notebook, fill in the QC section with your own chosen thresholds and one sentence justifying each, referencing your own plotted distribution — not a number copied from Day 2 or from someone else's project.

## Further reading

- [Day 2's 05_loading_data_and_qc.ipynb](../../day2_single_cell/lessons/05_loading_data_and_qc.ipynb) — the worked QC example this lesson assumes you've already done once.
- [Day 3's 03_loading_the_kang_dataset.ipynb](../../day3_biological_inference/lessons/03_loading_the_kang_dataset.ipynb) — the raw-counts verification pattern (row sums vs. a count column) reused above.
