# Project 4 — Malaria-Infected Mouse Liver

**Dataset**: GEO [GSE268112](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE268112), single-nucleus RNA-seq from mouse liver, *Plasmodium berghei* infection vs. salivary-gland-lysate control.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project4_malaria_liver/project4_malaria_liver_checkpoint.h5ad` — 24,944 cells x 60,732 genes, raw counts, `.obs['condition']` (`infected`/`control`) already set. Scoped to the 24-hour timepoint only.

**Core comparison, locked in**: infected vs. control at 24h, sample as the independent unit (each sample already pools two biological replicate mice — a small effective n, worth stating).

**Optional stretch**: spatial transcriptomics data exists for this same study (GEO GSE268018/GSE268068) but is **not** part of your checkpoint. It's real and public if you want to look it up — the core deliverable here is snRNA-seq only.

Start with [starter_notebook.ipynb](starter_notebook.ipynb). See [../../lessons/03_project_assignments_and_datasets.md](../../lessons/03_project_assignments_and_datasets.md) for full context.
