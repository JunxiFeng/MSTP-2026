# Day 4/5 - Independent Projects

**REQUIRED DAY 4/5**

## Learning Goals

By the end of Day 5, you should be able to:

- State a real dataset's independent unit, grouping variable, and core comparison, and defend why you scoped it the way you did.
- Choose and justify your own QC thresholds and analysis pipeline for a dataset nobody has pre-checked for you.
- Run a group-level comparison (differential expression, composition, and/or pathway enrichment) appropriate to your own question, with correct pairing and multiple-testing correction.
- Spot-check any pre-computed annotation a data source hands you, rather than trusting it as ground truth.
- Build a small set of clear, honest figures for a real result — including a null one.
- Run the full 30-item Agent B checklist on your own analysis and on a peer's, and resolve disagreements by tracing back to code.

## Environment

Today's environment (`mstp-day4-5`) is the union of Day 2's QC/clustering stack and Day 3's group-inference stack — shared and read-only, same reason and pattern as every prior day. Register it as a kernel:

```bash
/tscc/nfs/home/juf009/envs/mstp-day4-5/bin/python -m ipykernel install --user \
  --name mstp-day4-5 --display-name "Python (mstp-day4-5)"
```

Then select **Python (mstp-day4-5)** as the kernel before running any notebook cells. (Terminal use: `conda activate /tscc/nfs/home/juf009/envs/mstp-day4-5`.)

## Everyone works independently

There are no assigned groups today. Five real datasets are on offer, each matched to one or more students' stated interests — where two of you land on the same dataset, that's an invitation to talk to each other, not a requirement to produce joint work. Your notebook, your scope decisions, and your presentation are your own. See [03_project_assignments_and_datasets.md](lessons/03_project_assignments_and_datasets.md) for who's using which dataset.

## Where today's data lives

Each project's real, already-verified checkpoint sits at `/tscc/nfs/home/juf009/day4_5_shared_data/`, outside the git repo, same reasoning as every prior day's data:

```text
/tscc/nfs/home/juf009/day4_5_shared_data/
  project1_stroke/project1_stroke_checkpoint.h5ad          58,528 cells x 27,998 genes
  project2_sarcoma/project2_sarcoma_checkpoint.h5ad         167,180 cells x 60,319 genes
  project2_sarcoma/single-cell_metadata_trimmed.tsv         per-sample disease_timing/tissue_location
  project3_kang_extension/README_pointer.txt                points at day3_shared_data/kang_2018_checkpoint.h5ad
  project4_malaria_liver/project4_malaria_liver_checkpoint.h5ad  24,944 cells x 60,732 genes
  project5_senescence/project5_senescence_checkpoint.h5ad   112,489 nuclei x 22,009 genes
```

See [lessons/03_project_assignments_and_datasets.md](lessons/03_project_assignments_and_datasets.md) for what each dataset is, why it was matched to your interests, and your locked-in core comparison.

## Day 4 Schedule — Data & Design

| Time | Activity |
| --- | --- |
| 0:00-0:15 | Welcome back + framing: Day 4/5 is one continuous independent project, worked solo |
| 0:15-0:30 | Dataset introduction (lesson 03) |
| 0:30-0:50 | Agent-assisted independent-project workflow + checklist items 25-30 (lesson 02) |
| 0:50-1:20 | Loading your dataset, confirming schema and raw counts |
| 1:20-1:30 | Break |
| 1:30-2:05 | Your own QC: derive and justify your own thresholds (lesson 04) |
| 2:05-2:40 | Grouping-variable orientation; clustering/annotation for datasets that need it |
| 2:40-2:50 | Break |
| 2:50-3:25 | Write your DEFINE statement and fill in the Agent B prompt fields, before running any group-level test |
| 3:25-3:50 | Instructor/TA circulation, one-on-one |
| 3:50-4:00 | Day 4 wrap-up: what "ready for Day 5" means for your project |

## Day 5 Schedule — Analysis & Communication

| Time | Activity |
| --- | --- |
| 0:00-0:15 | Recap Day 4 + today's arc |
| 0:15-0:45 | Group-level comparison, part 1: DE and/or compositional analysis (lesson 05) |
| 0:45-1:15 | Group-level comparison, part 2: pathway/gene-set analysis, or gene expression programs if that fits your question |
| 1:15-1:25 | Break |
| 1:25-2:00 | Visualization capstone (lesson 06) |
| 2:00-2:40 | Peer review (lesson 07) — trade notebooks with anyone, not just someone on your own dataset |
| 2:40-2:50 | Break |
| 2:50-3:00 | Resolve peer feedback yourself |
| 3:00-3:45 | Mini-symposium (lesson 08) — 12 talks, ~4 minutes each |
| 3:45-4:00 | Whole-bootcamp wrap-up |

## Required Path

1. Read lessons 01-03 first.
2. Load your dataset in `projects/<your_project>/starter_notebook.ipynb` and complete your own QC (lesson 04).
3. Run your group-level comparison (lesson 05) and build your capstone figures (lesson 06).
4. Complete peer review (lesson 07) and present at the mini-symposium (lesson 08).

## Lessons

- [01 Recap and independent project orientation](lessons/01_recap_and_independent_project_orientation.md)
- [02 Agent-assisted independent project workflow](lessons/02_agent_assisted_independent_project_workflow.md) (checklist items 25-30)
- [03 Project assignments and datasets](lessons/03_project_assignments_and_datasets.md)
- [04 Data loading and QC guidance](lessons/04_data_loading_and_qc_guidance.md)
- [05 Group-level comparison guidance](lessons/05_group_level_comparison_guidance.md)
- [06 Visualization capstone guidance](lessons/06_visualization_capstone_guidance.md)
- [07 Peer review](lessons/07_peer_review.md)
- [08 Mini-symposium and wrap-up](lessons/08_mini_symposium_and_wrap_up.md) **ADVANCED**

## Your project

- [Project 1 — Mouse ischemic stroke](projects/project1_stroke/README.md)
- [Project 2 — Pediatric osteosarcoma](projects/project2_sarcoma/README.md)
- [Project 3 — Kang et al. 2018, an unexplored cell type](projects/project3_kang_extension/README.md)
- [Project 4 — Malaria-infected mouse liver](projects/project4_malaria_liver/README.md)
- [Project 5 — Aging and senescence in the human brain](projects/project5_senescence/README.md)

## Future Days

Day 4/5 is currently the last built content in this bootcamp. If a future cohort adds a Day 6, it should follow the same pattern established here — a new folder, without reorganizing Days 1 through 5.
