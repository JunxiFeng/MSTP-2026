# Project 3 — Kang et al. 2018, an Unexplored Cell Type

For Kareem Alba and Devin Valdes. Independent work — you're both using this dataset, but your analysis, scope, and presentation are your own. You don't need to pick different cell types from each other, though you can if you want two different angles.

**Dataset**: Day 3's own checkpoint, reused directly — no new download.
`/tscc/nfs/home/juf009/day3_shared_data/kang_2018_checkpoint.h5ad` — 24,673 cells x 15,706 genes, 8 lupus patients' PBMCs, each with a paired IFN-β-stimulated and control sample.

**Core comparison**: stim vs. ctrl, donor as the independent unit (n=8, paired) — but in a cell type Day 3's worked examples didn't already use. CD14+ Monocytes (DE/pathways) and CD4 T cells (gene expression programs) are off the table. Pick from `.obs['cell_type']`: NK cells (1,716), B cells (2,651), CD8 T cells (1,621), FCGR3A+ Monocytes (1,089), Dendritic cells (529), or Megakaryocytes (132 — likely too small for a reliable pseudobulk comparison across only 8 donors).

**Your question**: does the interferon response Day 3 found in monocytes look the same, weaker, or absent in your chosen cell type?

Start with [starter_notebook.ipynb](starter_notebook.ipynb). See [../../lessons/03_project_assignments_and_datasets.md](../../lessons/03_project_assignments_and_datasets.md) for full context.
