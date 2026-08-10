# Advanced Single-Cell Preview

**OPTIONAL / PREVIEW**

Conceptual only, same posture as [09_spatial_transcriptomics_preview.md](09_spatial_transcriptomics_preview.md) — name it, explain why it matters, no hands-on component today.

## Trajectory inference: when cells are mid-transition, not fixed types

Today's clustering treats cell types as discrete boxes. Real biology is often continuous — a stem cell differentiating, a T cell activating — where cells fall along a spectrum rather than into clean categories. A few named approaches, per [sc-best-practices.org's Trajectory Analysis chapters](https://www.sc-best-practices.org/):

- **Pseudotemporal ordering** — orders cells along an inferred developmental/activation trajectory using only a snapshot of expression, not real time-series data.
- **RNA velocity** — uses the ratio of spliced to unspliced transcripts in each cell to estimate the *direction* a cell is moving transcriptionally, giving trajectory inference an actual arrow of time instead of an ambiguous ordering.
- **Lineage tracing** — uses an experimental label (genetic barcoding, not just expression) to track which cells are descended from which, when you need ground truth rather than an inference.

## Integration and batch correction: closing today's loop

[07_dimensionality_reduction_and_clustering.ipynb](07_dimensionality_reduction_and_clustering.ipynb) flagged that a cluster boundary might be a batch effect rather than biology, checked by eye. Integration methods (Harmony, scVI, and others) exist specifically to computationally remove batch/donor/technology effects *before* clustering, so cells of the same type from different batches land together rather than needing to be manually second-guessed afterward. Today's dataset is a single sample, so integration wasn't needed — but this is the tool you'd reach for the moment you have more than one.

## Cell-cell communication and gene regulatory networks

Two more that push past "what cell types are here" toward "what are they doing to each other":

- **Cell-cell communication** — infers likely signaling interactions between cell types based on co-expression of known ligand-receptor pairs (e.g., CellPhoneDB, squidpy's ligand-receptor analysis).
- **Gene regulatory networks (GRNs)** — infers which transcription factors are likely driving which downstream genes, from expression correlation patterns.

## Further reading

- [Single-cell best practices — Trajectory Analysis](https://www.sc-best-practices.org/)
- [scVelo (RNA velocity)](https://scvelo.readthedocs.io/)
- [Harmony (batch integration)](https://portals.broadinstitute.org/harmony/)
- [CellPhoneDB (cell-cell communication)](https://www.cellphonedb.org/)
