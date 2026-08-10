# Advanced Topics And Where To Go Next

**ADVANCED**

Same posture as Day 1's [11_where_to_go_next.md](../../day1_foundations/lessons/11_where_to_go_next.md) and Day 2's spatial/advanced previews: conceptual only, no hands-on component today.

## When the axis of variation is time, not condition

Today's comparison was two fixed conditions (stimulated vs. control). Often the more natural axis is continuous — a cell differentiating, activating, or progressing through a process with no discrete labels at all. That's **trajectory inference** ([previewed conceptually in Day 2](../../day2_single_cell/lessons/10_advanced_single_cell_preview.md)) — pseudotime and RNA velocity ask "where is this cell along a process," not "which group is it in."

## Perturbation goes further than one drug

Today's IFN-β stimulation is one perturbation applied to everyone. **Perturb-seq** and similar screens apply many genetic perturbations (CRISPR knockouts/knockdowns) in parallel within a single experiment, then ask the same DE question today's pseudobulk lesson taught — which genes change — but repeated across hundreds of independent perturbations at once. The statistical core (aggregate to the right unit, correct for the number of tests) doesn't change; the scale does.

## Gene expression programs, extended

Today's cNMF lesson found programs within cells from one dataset. The same idea extends to comparing programs *across* datasets, tissues, or even species — asking whether a program discovered here recurs elsewhere, which is how gene programs move from a within-study observation to a generalizable biological claim.

## Multi-omics integration

Everything this week has been transcriptomic. Real cells also have chromatin accessibility (ATAC), protein abundance (CITE-seq), and spatial context ([previewed in Day 2](../../day2_single_cell/lessons/09_spatial_transcriptomics_preview.md)) — multi-omics integration combines these modalities per cell, which is a substantially harder alignment problem than anything this week touched, but builds directly on today's habit of being precise about what a "unit" and a "replicate" actually are, since that discipline gets harder to maintain, not easier, as data types multiply.

## Further reading

- [Single-cell best practices — Perturbation modeling](https://www.sc-best-practices.org/conditions/perturbation_modeling.html)
- [pertpy documentation](https://pertpy.readthedocs.io/) — the same package used to load today's dataset also has tools for perturbation modeling and distance metrics between conditions.
- [Single-cell best practices (full book)](https://www.sc-best-practices.org/) — today's lessons covered a subset of the "Condition Analysis" and gene-program-adjacent chapters; trajectory analysis, mechanistic studies (GRNs, cell-cell communication), and multimodal integration are there when you need them.
