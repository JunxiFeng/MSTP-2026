# Day 3 - Biological Inference From Single-Cell Data

**REQUIRED DAY 3**

## Learning Goals

By the end of today, you should be able to:

- Explain why the donor, not the cell or the sample, is the independent unit for any group comparison.
- Run differential expression the naive (per-cell) way and the correct (pseudobulk) way on the same question, and explain why they disagree.
- Test whether cell-type proportions shift between conditions, accounting for the sum-to-one constraint of compositional data.
- Run pathway/gene-set enrichment on a real differential expression result.
- Explain what a gene expression program is, how it differs from a cell-type cluster, and why its stability across random seeds matters.
- Turn a results table into a figure someone outside this room could actually read.

## Environment

Today's environment (`scanpy`, `pertpy`, `pydeseq2`, `decoupler`, `cnmf`, and friends) is shared and read-only, the same reason and the same pattern as Day 2's `mstp-day2`: it's heavy enough that everyone building their own copy live would not go well. Register it as a kernel:

```bash
/tscc/nfs/home/juf009/envs/mstp-day3/bin/python -m ipykernel install --user \
  --name mstp-day3 --display-name "Python (mstp-day3)"
```

Then select **Python (mstp-day3)** as the kernel before running any notebook cells. (Terminal use: `conda activate /tscc/nfs/home/juf009/envs/mstp-day3`.)

## Where today's data lives

Today's shared data sits at `/tscc/nfs/home/juf009/day3_shared_data/` — outside the git repo, same reasoning as Day 2's data:

```text
/tscc/nfs/home/juf009/day3_shared_data/
  kang_2018_checkpoint.h5ad     the cached dataset (24,673 cells x 15,706 genes)
  hallmark_genesets.csv         cached MSigDB Hallmark gene sets, for lesson 06
  cd4_tcells_for_cnmf.h5ad      the CD4 T cell subset used for gene expression programs
  cd4_full_grid/                the instructor's full cNMF run (lessons 07-08 read from this)
```

[03_loading_the_kang_dataset.ipynb](lessons/03_loading_the_kang_dataset.ipynb) has you read the dataset directly from here.

## Four-Hour Schedule

| Time | Activity |
| --- | --- |
| 0:00-0:15 | Recap + group-level questions |
| 0:15-0:30 | Agent-assisted workflow extension + checklist items 19-24 |
| 0:30-0:50 | Loading the Kang dataset, orientation to donors/conditions/cell types |
| 0:50-1:25 | Pseudobulk differential expression: naive vs. correct |
| 1:25-1:35 | Break |
| 1:35-2:00 | Compositional analysis |
| 2:00-2:25 | Pathway and gene set analysis |
| 2:25-2:35 | Break |
| 2:35-2:50 | Gene expression programs: concept + your own light Slurm job |
| 2:50-3:15 | Gene expression programs: interpreting the real output |
| 3:15-3:45 | Visualization capstone |
| 3:45-4:00 | Advanced topics preview + wrap-up |

This is a full day — six substantive topics plus a dedicated visualization lesson in four hours leaves less slack per topic than Day 2. If time runs short, the wrap-up preview is the place to compress, not the visualization capstone.

## Required Path

1. Read lessons 01-02 first.
2. Work through notebooks 03-06 in order: loading data, differential expression, composition, pathways.
3. Read lesson 07, then submit your own light Slurm job, then work through notebook 08.
4. Work through the visualization capstone, notebook 09 — run every cell yourself.
5. Read lesson 10 as a conceptual preview.

## Lessons

- [01 Recap and group-level questions](lessons/01_recap_and_group_level_questions.md)
- [02 Agent-assisted biological inference workflow](lessons/02_agent_assisted_biological_inference_workflow.md)
- [03 Loading the Kang dataset](lessons/03_loading_the_kang_dataset.ipynb) (notebook)
- [04 Pseudobulk differential expression](lessons/04_pseudobulk_differential_expression.ipynb) (notebook)
- [05 Compositional analysis](lessons/05_compositional_analysis.ipynb) (notebook)
- [06 Pathway and gene set analysis](lessons/06_pathway_and_gene_set_analysis.ipynb) (notebook)
- [07 Gene expression programs and HPC practice](lessons/07_gene_expression_programs_and_hpc_practice.md)
- [08 Gene expression programs: interpretation](lessons/08_gene_expression_programs_interpretation.ipynb) (notebook)
- [09 Visualization capstone](lessons/09_visualization_capstone.ipynb) (notebook)
- [10 Advanced topics and where to go next](lessons/10_advanced_topics_and_where_to_go_next.md)

## Future Days

Future folders may be added later without reorganizing Day 1, Day 2, or Day 3.
