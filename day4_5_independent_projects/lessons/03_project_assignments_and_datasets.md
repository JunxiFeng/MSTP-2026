# Project Assignments and Datasets

**REQUIRED DAY 4/5**

Five real datasets, no assigned groups. Every dataset below was actually downloaded and loaded before this lesson was written — the cell/gene counts are real, not from a paper abstract. Where a dataset is shared by more than one of you, that's a chance to compare notes, not a joint deliverable — your notebook, your scope, and your presentation are your own.

## Project 1 — mouse ischemic stroke

**For**: Noe Cazares Jr., Andrea Tran.

**Dataset**: GEO [GSE174574](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE174574) — single-cell RNA-seq from mouse brain, 24 hours after either a sham operation or MCAO (middle cerebral artery occlusion, the standard ischemic stroke model). 6 samples: `sham1/2/3` and `MCAO1/2/3`.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project1_stroke/project1_stroke_checkpoint.h5ad` — 58,528 cells x 27,998 genes. `.obs['sample']` and `.obs['condition']` (`sham`/`MCAO`) are already set; nothing else has been done to this file — it is the raw, un-QC'd, per-cell-barcode matrix straight from CellRanger's cell-calling step.

**Core comparison**: sham vs. MCAO. The independent unit is the animal (one sample = one mouse) — 3 vs. 3, a small n, worth keeping in mind when you interpret significance.

## Project 2 — pediatric osteosarcoma

**For**: Ethan Subel, Mayra Mendiola.

**Dataset**: ScPCA Portal project [SCPCP000017](https://scpca.alexslemonade.org/projects/SCPCP000017) — single-nucleus RNA-seq from 27 pediatric osteosarcoma tumor samples (the portal calls this "A Single Cell Atlas of Pediatric Sarcoma," but every sample in it is specifically Osteosarcoma).

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project2_sarcoma/project2_sarcoma_checkpoint.h5ad` — 167,180 cells x 60,319 genes across all 27 samples, plus `single-cell_metadata_trimmed.tsv` (per-sample `disease_timing`, `tissue_location`, `primary_or_metastasis`). `.obs['primary_or_metastasis']` is already set.

**Core comparison, locked in**: Primary vs. Metastasis (18 samples vs. 9). The independent unit is the sample/participant. This checkpoint deliberately does **not** include the data source's own pre-computed cell-type annotations, doublet scores, or copy-number calls — see checklist item 26. Optional stretch (Ethan, if time allows): the richer `disease_timing` axis (Initial diagnosis / Recurrence / Local control surgery / Metastatic resection / Post treatment resection / On therapy surgery), or independently reconciling cell-type calls from scratch rather than trusting a source's own labels. Keep any stretch result visibly separate from the core Primary-vs-Metastasis claim (checklist item 30).

## Project 3 — Kang et al. 2018, an unexplored cell type

**For**: Kareem Alba, Devin Valdes.

**Dataset**: Day 3's own checkpoint — no new data, no new download. `/tscc/nfs/home/juf009/day3_shared_data/kang_2018_checkpoint.h5ad` — 24,673 cells x 15,706 genes, 8 lupus patients' PBMCs, each with a paired IFN-β-stimulated and control sample.

**Core comparison**: stim vs. ctrl, same as Day 3, but **not** in the cell type Day 3 already worked through. Day 3's worked examples used CD14+ Monocytes (differential expression, pathways) and CD4 T cells (gene expression programs) — those are off the table as "your own" result. Pick a cell type in `.obs['cell_type']` (real published counts: NK cells 1,716; B cells 2,651; CD8 T cells 1,621; FCGR3A+ Monocytes 1,089; Dendritic cells 529; Megakaryocytes 132 — the smallest few may not support a reliable pseudobulk comparison across only 8 donors, which is itself worth stating as a limitation). If both of you land here, you don't need to pick different cell types — but a real question either way: does the interferon response Day 3 found in monocytes look the same, weaker, or absent in your chosen cell type?

## Project 4 — malaria-infected mouse liver

**For**: Erin Golden, Ronja Frigard.

**Dataset**: GEO [GSE268112](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE268112) — single-nucleus RNA-seq from mouse liver, comparing *Plasmodium berghei* infection (the standard mouse malaria model) against a salivary-gland-lysate control, across three timepoints. This checkpoint uses only the 24-hour pair.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project4_malaria_liver/project4_malaria_liver_checkpoint.h5ad` — 24,944 cells x 60,732 genes. `.obs['condition']` (`infected`/`control`) is already set.

**Core comparison, locked in**: infected vs. control at 24 hours post-infection/injection. The independent unit is the sample (each sample here already pools two biological replicate mice, per the original study design — so n is smaller than the cell count makes it look). Spatial transcriptomics data exists for this same study (GEO GSE268018/GSE268068) but is **not** part of your checkpoint — it's real, it's public, and it's a legitimate optional stretch if you want to look it up yourself, but the core deliverable here is snRNA-seq only.

## Project 5 — aging and senescence in the human brain

**For**: Kelechi Onwuzurike.

**Dataset**: Sloan, Mares, Daly et al. 2025, *Cell Genomics* — "Uncovering the signatures of aging and senescence in the human dorsolateral prefrontal cortex." Single-nucleus RNA-seq from 36 cognitively normal donors spanning the adult human lifespan, no neurodegenerative disease (every donor's diagnosis is "Control"). Real, public data: the processed count matrix is on [Zenodo](https://doi.org/10.5281/zenodo.17467925), and donor-level age/sex metadata is in the paper's own [supplementary sheet](https://docs.google.com/spreadsheets/d/1rmVE_ZtojFaL0ChXuxNjC9N2wWLPpffSWVh0U2asZP4/edit) — both were actually downloaded and joined before this lesson was written.

**Checkpoint**: `/tscc/nfs/home/juf009/day4_5_shared_data/project5_senescence/project5_senescence_checkpoint.h5ad` — 112,489 nuclei x 22,009 genes, raw counts. `.obs['donor']`, `.obs['age_group']` (`Young`/`Middle`/`Old`, 12 donors each), `.obs['age_at_death']`, `.obs['sex']` are already set, along with the source's own cell-type calls at three resolutions (`cc_broadclass`, `cc_celltype`, `cc_celltype_k36`) — unlike Project 2, these annotations **are** included here, so checklist item 26 (spot-check a pre-computed annotation before trusting it) is directly actionable on this dataset.

**Core comparison**: Young vs. Old (drop or set aside `Middle` for a cleaner two-group comparison, or use all three as an ordinal comparison — your choice, state it and why). The independent unit is the donor (12 vs. 12, or 12 vs. 12 vs. 12). `cc_broadclass` includes real neurovascular unit cell types (`End` — endothelial, `Peri` — pericyte) alongside neurons, glia, and immune cells — a real angle for a specifically neurovascular question inside a whole-cortex dataset.

## Practice

Before lesson 04, confirm you can state your independent unit and core comparison out loud, in one sentence each, without looking anything up. If you can't, that's the thing to resolve first — not a data-loading problem.

## Further reading

- [GSE174574 on GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE174574) — Project 1's source series.
- [SCPCP000017 on the ScPCA Portal](https://scpca.alexslemonade.org/projects/SCPCP000017) — Project 2's source project.
- [GSE268112 on GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE268112) — Project 4's source series.
- [Sloan, Mares, Daly et al. 2025, Cell Genomics](https://www.cell.com/cell-genomics/fulltext/S2666-979X(25)00383-0) — Project 5's source paper.
