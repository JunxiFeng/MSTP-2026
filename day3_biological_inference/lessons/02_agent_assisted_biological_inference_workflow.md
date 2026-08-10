# Agent-Assisted Biological Inference Workflow

**REQUIRED DAY 3**

## The same loop, applied to group comparisons

Day 1's [08_coding_agents.md](../../day1_foundations/lessons/08_coding_agents.md) gave you DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET. Today's version:

| Step | Today's version |
| --- | --- |
| **DEFINE** | State the comparison and the independent unit *before* prompting — e.g., "8 donors, each with a stimulated and control sample. The donor is the independent unit; the two samples per donor are paired, not independent groups." |
| **ASK** | Give the agent that structure explicitly, not just "compare stimulated vs. control." |
| **RUN** | Execute in the `mstp-day3` environment. |
| **VALIDATE** | Check the agent's assumptions against the pitfalls below — did it test at the cell level? Did it correct for the number of tests it actually ran? |
| **TEST** | Confirm results are stable to reasonable choices (aggregation method, gene-set database, random seed) rather than accepting the first output. |
| **INTERPRET** | State a claim no stronger than what a paired, donor-level comparison across 8 patients supports — not a claim about IFN-β response "in general." |

## A weak vs. strong prompt, for this domain

> Weak: "Test whether gene expression differs between stimulated and control."
>
> Strong: "I have single-cell RNA-seq from 8 donors, each with a paired stimulated and control sample, cell-type annotated. Aggregate counts to one profile per donor per condition per cell type (pseudobulk) before testing — do not test at the cell level. Use a paired design across donors, and tell me explicitly how many tests you ran and what multiple-testing correction you applied before reporting anything as significant."

## The extended Agent B prompt

Use the same reusable Agent B prompt from Day 1's [09_agent_validation.md](../../day1_foundations/lessons/09_agent_validation.md), extended with Day 2's items 13-18 (scRNA-seq pitfalls) plus six new items for group-level inference. Items 1-18 are unchanged.

```text
You are independently reviewing another coding agent's biological inference analysis.

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
17. Is each cell-type annotation backed by a statistical marker test, not just a colored UMAP that "looks right"?
18. Were QC thresholds chosen and justified for this dataset, or copied from a tutorial default?
19. Is differential expression tested by aggregating to one profile per independent unit (pseudobulk) before testing, rather than treating every cell as its own replicate?
20. Is the reported significance corrected for the full number of tests actually performed (all genes, all pathways, or all programs considered), not just the tests shown in the final table?
21. Does the compositional analysis account for cell-type proportions summing to 1 per sample, rather than testing each type's proportion as if independent of the others?
22. Where the design is paired (same donor, both conditions), is that pairing preserved in the statistical test, rather than treating all samples as unpaired independent groups?
23. Was the chosen number of gene expression programs and its gene loadings checked for stability across random seeds or replicates, rather than reported from a single run?
24. Was the gene-set database and enrichment method fixed before looking at results, rather than tried across multiple databases/methods until one produced the desired pathway?

For each item return PASS / WARNING / FAIL, evidence, smallest correction, automated checks, and remaining uncertainty.
```

If Agent A and Agent B disagree, trace the specific check back to the actual code and data yourself — the same rule as every prior day.

## Practice

You'll invoke specific items as you go: items 19, 20, and 22 in [04_pseudobulk_differential_expression.ipynb](04_pseudobulk_differential_expression.ipynb), item 21 in [05_compositional_analysis.ipynb](05_compositional_analysis.ipynb), items 20 and 24 in [06_pathway_and_gene_set_analysis.ipynb](06_pathway_and_gene_set_analysis.ipynb), and item 23 in [08_gene_expression_programs_interpretation.ipynb](08_gene_expression_programs_interpretation.ipynb). At the end of [09_visualization_capstone.ipynb](09_visualization_capstone.ipynb), you'll run the full 24-item checklist once, end to end, as today's capstone validation exercise.
