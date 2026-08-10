# Project 2 — Pediatric Osteosarcoma

**Dataset**: ScPCA Portal project [SCPCP000017](https://scpca.alexslemonade.org/projects/SCPCP000017), single-nucleus RNA-seq from 27 pediatric osteosarcoma samples.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project2_sarcoma/project2_sarcoma_checkpoint.h5ad` (raw counts, `.obs['primary_or_metastasis']` already set) plus `single-cell_metadata_trimmed.tsv` (per-sample `disease_timing`/`tissue_location`). Real cell/gene counts are printed the first time you load it — this README intentionally doesn't restate them so you confirm it yourself.

**Core comparison, locked in**: Primary vs. Metastasis, sample as the independent unit (unbalanced n — 18 vs. 9, worth accounting for in interpretation).

**This checkpoint deliberately does not include** the data source's own pre-computed cell-type, doublet, or copy-number annotations — see checklist item 26. If you do any clustering/annotation, it's your own, not borrowed from the source.

**Optional stretch** (Ethan, if time allows): the richer `disease_timing` axis, or independently reconciling cell-type calls from scratch. Keep any stretch result visibly separate from the core Primary-vs-Metastasis claim (checklist item 30).

Start with [starter_notebook.ipynb](starter_notebook.ipynb). See [../../lessons/03_project_assignments_and_datasets.md](../../lessons/03_project_assignments_and_datasets.md) for full context.
