# Agent-Assisted scRNA-seq Workflow

**REQUIRED DAY 2**

## The same loop, applied to single-cell data

Day 1's [08_coding_agents.md](../../day1_foundations/lessons/08_coding_agents.md) gave you DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET. Today, apply it to every major step (QC, normalization, clustering, annotation) instead of one analysis end to end:

| Step | Today's version |
| --- | --- |
| **DEFINE** | State what you're doing and why *before* prompting — e.g., "One donor, ~300 PBMCs. I'm filtering low-quality cells before clustering; I am not comparing this donor to anyone else." |
| **ASK** | Give the agent the biological context, not just "write QC code." |
| **RUN** | Execute in the `mstp-day2` environment ([environments/day2.yml](../../environments/day2.yml)). |
| **VALIDATE** | Check the agent's assumptions against single-cell-specific pitfalls (below). |
| **TEST** | Run [templates/diagnostic_scripts/verify_counts_matrix.py](../templates/diagnostic_scripts/verify_counts_matrix.py) or a similar automated check rather than eyeballing a UMAP. |
| **INTERPRET** | State a claim no stronger than "these are the cell types and approximate proportions present in this one donor" — not a group comparison, since today's data is one sample. |

## A weak vs. strong prompt, for this domain

> Weak: "Write code to filter out bad cells."
>
> Strong: "I have a ~300-cell PBMC count matrix in AnnData. Write QC filtering code using `n_genes_by_counts`, `total_counts`, and `pct_counts_mt`, but don't hard-code threshold values — compute and show me the distributions first, and explain what threshold you'd choose and why, so I can approve it before it's applied."

The strong version asks the agent to expose its judgment calls instead of burying them in a default. That's the difference between a threshold you can defend later and one you can't.

## The extended Agent B prompt

Use Day 1's exact reusable Agent B prompt from [09_agent_validation.md](../../day1_foundations/lessons/09_agent_validation.md) — same fields, same PASS/WARNING/FAIL format, same "open a fresh session" rule — but with six items added for scRNA-seq-specific failure modes. Items 1-12 are unchanged from Day 1.

```text
You are independently reviewing another coding agent's single-cell RNA-seq analysis.

Biological question:
[fill in]

Experimental design:
[fill in]

Independent biological unit:
[fill in]

Main comparison:
[fill in]

Audit the code, outputs, and interpretation.

Check:
1. Is the independent experimental unit handled correctly?
2. Is pairing/repeated-measure structure preserved?
3. Are identifiers matched safely?
4. Are samples silently dropped, duplicated, or reordered?
5. Are missing values handled transparently?
6. Are transformations appropriate?
7. Could batch or another covariate explain the result?
8. Does the visualization represent biological replication correctly?
9. Are statistical assumptions supported?
10. Does the interpretation go beyond what the measurement supports?
11. Can the result be reproduced from the provided inputs?
12. Are there hard-coded paths or environment assumptions?
13. Is a cell being treated as an independent biological replicate, instead of the donor/subject it came from?
14. Were doublets checked for, not just assumed absent?
15. Is the clustering resolution justified against marker-gene separation, rather than left at a default with no stated reason?
16. Could a batch, lane, or chemistry effect explain a cluster boundary better than a real cell-type difference?
17. Is each cell-type annotation backed by a statistical marker test (e.g. rank_genes_groups), not just a colored UMAP that "looks right"?
18. Were QC thresholds (mito %, min genes, min counts) chosen and justified for this dataset, or copied from a tutorial default?

For each item return PASS / WARNING / FAIL, evidence, smallest correction, automated checks, and remaining uncertainty.
```

If Agent A and Agent B disagree, trace the specific check back to the actual code and data yourself — the same rule as Day 1.

## Practice

You'll invoke specific items from this checklist as you go: items 13 and 18 in [05_loading_data_and_qc.ipynb](05_loading_data_and_qc.ipynb), items 15 and 16 in [07_dimensionality_reduction_and_clustering.ipynb](07_dimensionality_reduction_and_clustering.ipynb), and item 17 in [08_cell_type_annotation.ipynb](08_cell_type_annotation.ipynb). At the end of notebook 08, you'll run the full 18-item checklist once, end to end, as today's capstone validation exercise.
