# Project 5 — Aging and Senescence in the Human Brain

**Dataset**: Sloan, Mares, Daly et al. 2025, *Cell Genomics* — single-nucleus RNA-seq from the human dorsolateral prefrontal cortex, 36 cognitively normal donors spanning the adult lifespan. Real, public data: [processed counts on Zenodo](https://doi.org/10.5281/zenodo.17467925), [donor age/sex metadata](https://docs.google.com/spreadsheets/d/1rmVE_ZtojFaL0ChXuxNjC9N2wWLPpffSWVh0U2asZP4/edit) from the paper's own supplementary sheet.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project5_senescence/project5_senescence_checkpoint.h5ad` — 112,489 nuclei x 22,009 genes, raw counts. `.obs['donor']`, `.obs['age_group']` (`Young`/`Middle`/`Old`, 12 donors each), `.obs['age_at_death']`, `.obs['sex']` already set, plus the source's own cell-type calls at three resolutions (`cc_broadclass`, `cc_celltype`, `cc_celltype_k36`).

**Core comparison**: Young vs. Old (or all three age groups) — state and justify your choice. Donor is the independent unit (12 vs. 12, or 12 vs. 12 vs. 12).

**Unlike Project 2**, this checkpoint's cell-type annotations are included, not withheld — which makes checklist item 26 (spot-check a pre-computed annotation before trusting it) directly actionable here. `cc_broadclass` includes real neurovascular unit cell types (`End`, `Peri`) if you want a specifically vascular angle inside this whole-cortex dataset.

Start with [starter_notebook.ipynb](starter_notebook.ipynb). See [../../lessons/03_project_assignments_and_datasets.md](../../lessons/03_project_assignments_and_datasets.md) for full context.
