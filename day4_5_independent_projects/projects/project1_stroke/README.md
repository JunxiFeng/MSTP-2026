# Project 1 — Mouse Ischemic Stroke

**Dataset**: GEO [GSE174574](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE174574), single-cell RNA-seq from mouse brain, 24h after sham surgery or MCAO (middle cerebral artery occlusion).

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project1_stroke/project1_stroke_checkpoint.h5ad` — 58,528 cells x 27,998 genes, raw counts, `.obs['sample']` and `.obs['condition']` (`sham`/`MCAO`) already set.

**Core comparison**: sham vs. MCAO, animal as the independent unit (n=3 vs. 3).

Start with [starter_notebook.ipynb](starter_notebook.ipynb). See [../../lessons/03_project_assignments_and_datasets.md](../../lessons/03_project_assignments_and_datasets.md) for full context.
