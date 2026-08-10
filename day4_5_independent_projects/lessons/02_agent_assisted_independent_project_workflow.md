# Agent-Assisted Independent Project Workflow

**REQUIRED DAY 4/5**

## The same loop, now with nobody handing you the question

Every prior day gave you a question, a dataset, and (mostly) a comparison. Today you supply all three yourself, before touching an agent — there's no group to split the thinking across:

| Step | Today's version |
| --- | --- |
| **DEFINE** | Write your Biological question, Experimental design, Independent biological unit, and Main comparison — the same four fields the Agent B prompt asks for — *before* you run anything, and before you've seen a single result. |
| **ASK** | Give an agent that exact DEFINE block, plus your real checkpoint path and schema. |
| **RUN** | Execute in the `mstp-day4-5` environment, against your checkpoint under `/tscc/nfs/home/juf009/day4_5_shared_data/`. |
| **VALIDATE** | Run the full 30-item Agent B checklist below — not just the new items — since this is the first day nobody has pre-checked your design for you. |
| **TEST** | Confirm your result is stable to reasonable alternative choices, and confirm you can say *why* you made the choice you made, not just that you made one. |
| **INTERPRET** | State a claim scoped to the species, tissue, timepoint, and sample size you actually analyzed — see item 28. |

## A weak vs. strong prompt, for this domain

> Weak: "Analyze my dataset and tell me what's interesting."
>
> Strong: "I have [N] samples from [species/tissue], comparing [group A] vs. [group B], with [independent unit] as the independent unit. My core comparison, decided before looking at any result, is [X]. Apply pseudobulk aggregation before any group-level test, preserve pairing if the design has it, and correct for the number of tests actually run. If the checkpoint file includes any pre-computed cell-type or QC annotations, spot-check at least one against an independent marker or metric before trusting it."

## The extended Agent B prompt

Use the same reusable Agent B prompt from Day 1's [09_agent_validation.md](../../day1_foundations/lessons/09_agent_validation.md), extended with Day 2's items 13-18 (scRNA-seq pitfalls) and Day 3's items 19-24 (group-level inference pitfalls), plus six new items for independent-project pitfalls. Items 1-24 are unchanged.

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
25. Was the dataset, scope (e.g., which timepoint, which cell type, which comparison groups), and inclusion criteria decided and written down before looking at any result, rather than adjusted afterward to produce a cleaner-looking answer?
26. If the data source ships its own pre-computed cell-type, doublet, or copy-number annotations, were they spot-checked against an independent marker-gene or QC-based check, rather than trusted and used as ground truth without verification?
27. Can the entire pipeline, from the shared checkpoint file to the final figure, be re-run end to end by someone other than the person who wrote it, using only what's committed and documented?
28. Does the stated conclusion stay scoped to the actual species, tissue, timepoint, and sample size analyzed, rather than generalizing to "the disease" or "the cell type" more broadly?
29. Were parameter choices, thresholds, or code carried over from an earlier day's or someone else's worked example re-justified against this dataset's own distributions, rather than reused because they worked there?
30. Was an optional/stretch-goal component (e.g., an extra cell type, an annotation-reconciliation step, a secondary comparison) clearly separated from the core required comparison in the writeup, rather than blended in as if it strengthens the main claim?

For each item return PASS / WARNING / FAIL, evidence, smallest correction, automated checks, and remaining uncertainty.
```

If Agent A and Agent B disagree, trace the specific check back to the actual code and data yourself — the same rule as every prior day. Today it also applies to disagreements between you and your reviewer during peer review (see [07_peer_review.md](07_peer_review.md)) — trace it back to the code, don't average the two opinions.

## Practice

Write your DEFINE block (item 25) before you load your checkpoint. If your dataset ships pre-computed annotations you didn't compute yourself — item 26 is directly actionable on Project 5, where the checkpoint includes the source's own cell-type calls at three resolutions, and directly relevant to Project 2 in the opposite direction (its checkpoint deliberately excludes the source's cell-type/copy-number calls, so any annotation you use is necessarily your own). Item 27 is what your reviewer will actually try to do during peer review: run your notebook top to bottom. Item 30 matters most if you attempt any optional/stretch content (Project 2's disease-timing/CNV/annotation-reconciliation stretch, Project 3's optional gene-expression-program extension, Project 4's optional spatial pointer) — keep it visibly separate from your core claim. You'll run the full 30-item checklist twice: once on your own analysis before the mini-symposium, and once on your reviewer's analysis during peer review.

## Further reading

- [Day 1's 09_agent_validation.md](../../day1_foundations/lessons/09_agent_validation.md) — the original 12-item checklist and why an agent auditing another agent's work still needs a human to resolve disagreements.
- [Day 3's 02_agent_assisted_biological_inference_workflow.md](../../day3_biological_inference/lessons/02_agent_assisted_biological_inference_workflow.md) — items 19-24 and the pseudobulk/pairing/correction pitfalls they target.
