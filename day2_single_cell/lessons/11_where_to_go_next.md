# Where To Go Next

**ADVANCED**

## Today's scale, and the rungs above it

Today you ran one dataset through one hand-assembled pipeline: STARsolo -> scanpy QC -> normalization -> clustering -> annotation. That's the right first rung to stand on. A few rungs above it, in roughly the order you'd meet them in a real project:

1. **One dataset, one pipeline** — today.
2. **A standardized, reusable pipeline** — [nf-core/scrnaseq](https://nf-co.re/scrnaseq) is a community-maintained, peer-reviewed Nextflow pipeline covering exactly today's FASTQ-to-counts step (and beyond) across multiple aligners including STARsolo, so the next dataset you process doesn't require hand-assembling Slurm scripts from scratch — see Day 1's [11_where_to_go_next.md](../../day1_foundations/lessons/11_where_to_go_next.md) for the general containers/Nextflow reproducibility ladder this fits into.
3. **Public reference atlases** — the [Human Cell Atlas](https://www.humancellatlas.org/) and similar efforts have already annotated cell types across many tissues at far larger scale than one 300-cell teaching dataset; a common real task is mapping your own new data onto an existing reference atlas's annotations rather than annotating from scratch every time.
4. **Integrating across studies** — once you have more than one dataset (different donors, different labs, different technologies), the batch-correction/integration methods previewed in [10_advanced_single_cell_preview.md](10_advanced_single_cell_preview.md) become necessary, not optional.

## Agents at this scale

Day 1's [08_coding_agents.md](../../day1_foundations/lessons/08_coding_agents.md) introduced [Biomni](https://biomni.stanford.edu/), the Stanford biomedical AI agent that autonomously handles tasks including single-cell cell-type annotation across a large curated tool/database set. Today's manual DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET loop, done step by step with your own judgment at each checkpoint, is exactly what's being delegated further as agents like Biomni take on more of the pipeline — which is also exactly why the independent-validation habit from [02_agent_assisted_scrna_workflow.md](02_agent_assisted_scrna_workflow.md) matters more as autonomy increases, not less.

## Further reading

- [nf-core/scrnaseq](https://nf-co.re/scrnaseq)
- [Human Cell Atlas](https://www.humancellatlas.org/)
- [Single-cell best practices (full book)](https://www.sc-best-practices.org/) — today's lessons covered a subset; the rest (condition analysis, gene set enrichment, perturbation modeling, multimodal integration) is there when you need it.
