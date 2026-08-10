# Group-Level Comparison Guidance

**REQUIRED DAY 4/5**

## Pick the tool that fits your question, not the one that fits the day

Day 3 taught pseudobulk differential expression, compositional analysis, pathway/gene-set enrichment, and gene expression programs — in that order, on one dataset, because the schedule required covering all four. Today, you pick whichever subset actually answers your question. A clean, well-defended single comparison beats four shallow ones.

| If your question is... | Reach for... | Worked example to adapt from |
| --- | --- | --- |
| "Does gene expression differ between groups?" | Pseudobulk DE (`pydeseq2`, design formula matched to your independent unit) | Day 3 lesson 04 |
| "Does cell-type/state composition shift between groups?" | Paired or unpaired proportion test, sum-to-one aware | Day 3 lesson 05 |
| "What biology does a DE result point to?" | `decoupler` pathway/gene-set enrichment on your DE stats | Day 3 lesson 06 |
| "Are there coordinated gene programs, not just cell-type clusters?" | `cNMF` (optional — genuinely a stretch, not required for anyone) | Day 3 lessons 07-08 |

## Every project's actual comparison, restated

- **Project 1**: sham vs. MCAO, animal as the independent unit, n=3 vs. 3. Pseudobulk DE is the natural fit; composition is a reasonable second question if you've clustered by cell type.
- **Project 2**: Primary vs. Metastasis, sample as the independent unit, n=18 vs. 9 (unbalanced — say so, and consider whether that changes how you interpret significance). Pseudobulk DE and/or composition, depending on whether you clustered.
- **Project 3**: stim vs. ctrl within your chosen cell type, donor as the independent unit, n=8 paired. This is structurally identical to Day 3's worked example — reuse the pipeline, not the numbers, and re-justify any threshold against your cell type's own distribution (checklist item 29).
- **Project 4**: infected vs. control at 24h, sample as the independent unit (each sample already pools 2 mice — a small effective n, say so). Pseudobulk DE is the natural fit.
- **Project 5**: Young vs. Old (or Young/Middle/Old), donor as the independent unit, n=12 per group. Composition is a strong first question here — the source's own cell-type calls make "does homeostatic astrocyte or SST-inhibitory-neuron abundance shift with age" directly testable (the original paper found exactly this) — but spot-check the annotation first (checklist item 26) before trusting it as your grouping/cell-type variable.

## Re-justify, don't reuse blind

If you copy code from Day 2, Day 3, or someone else's approach, that's expected — nobody is asking you to invent statistics from scratch. What checklist item 29 asks is that you re-check the assumption against *your* data: does your dataset have the same design structure (paired vs. unpaired)? Does your gene-count filter threshold make sense for your dataset's own count distribution, or did you copy Day 3's `pydeseq2` filter without checking?

## Practice

State your test count and correction method before you look at which genes/pathways came out significant (checklist item 20) — write it in your notebook, then run the test. If your result is a clean null (nothing survives correction), that's a real, presentable finding — Day 3's own compositional analysis was exactly that, and it's still in the lesson.

## Further reading

- [Day 3's 04-06 notebooks](../../day3_biological_inference/lessons/) — the worked DE/composition/pathway pipeline this lesson adapts.
