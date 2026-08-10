# Recap And Single-Cell Orientation

**REQUIRED DAY 2**

## The ladder still applies

Day 1 gave you a ladder for every analysis: biological question -> study design -> data and metadata -> reproducible computation -> validation -> interpretation ([day1_foundations/lessons/02_analysis_workflow.md](../../day1_foundations/lessons/02_analysis_workflow.md)). Nothing about that changes today. What changes is the measurement: instead of one expression value per gene per sample (bulk RNA-seq), you get one expression value per gene per **cell**, with thousands of cells per sample.

## The one thing that trips everyone up

Day 1 already flagged this in [03_data_generation_and_sequencing.md](../../day1_foundations/lessons/03_data_generation_and_sequencing.md): **a cell is not automatically an independent biological replicate.** Two thousand cells from one donor are not "n=2000" — they're still one biological sample, just measured at higher resolution. The independent experimental unit today, if you were designing a real study, would still usually be the donor/subject, not the cell.

This matters immediately: today you'll cluster and annotate cell types *within* one sample. That's a legitimate question ("what cell types are present, and in roughly what proportions?"). It is not the same question as "does this differ between groups?" — answering that would require multiple donors per group, which today's single shared sample doesn't have. Keep this distinction in mind every time you're tempted to say "n=300 cells" out loud.

## What's different about single-cell data, mechanically

| Bulk RNA-seq (Day 1) | Single-cell RNA-seq (today) |
| --- | --- |
| One expression profile per sample | One expression profile per cell |
| A few to dozens of samples | Hundreds to tens of thousands of cells per sample |
| No cell-of-origin information | Each read is tagged with a cell barcode |
| One transcript count per gene | Reads deduplicated per gene *per cell* using a UMI (Unique Molecular Identifier) |

Cell barcodes and UMIs were introduced conceptually in Day 1's [03_data_generation_and_sequencing.md](../../day1_foundations/lessons/03_data_generation_and_sequencing.md). Today you'll see exactly where they come from in the raw read, and how they turn a pile of FASTQ reads into a cell-by-gene count matrix.

## Today's dataset and map

Today's shared class dataset is described in [the Day 2 README](../README.md#todays-dataset): 10x Genomics "1k PBMCs" (peripheral blood mononuclear cells — a mix of T cells, B cells, NK cells, and monocytes from blood), v3 chemistry, subsampled to ~300 cells for teaching.

The day's map:

```text
FASTQ (raw reads)
  -> [already done] STARsolo alignment + quantification
  -> cell-by-gene count matrix
  -> [everyone, individually] load into AnnData
  -> QC
  -> normalization + feature selection
  -> dimensionality reduction + clustering
  -> cell-type annotation
  -> (preview only) spatial transcriptomics, advanced techniques
```

The FASTQ-to-matrix step is explained in detail in [03_raw_data_fastq_to_counts.md](03_raw_data_fastq_to_counts.md), but it already happened — one job, one output, shared by the whole class. Everything from "load into AnnData" onward is done by each of you individually, on that same starting matrix, and your own hands-on Slurm practice is in [04_hpc_practice.md](04_hpc_practice.md).

## Further reading

- [Single-cell best practices — Introduction to single-cell RNA-seq](https://www.sc-best-practices.org/introduction/scrna_seq.html) — the scverse/Theis-lab community reference this whole day is structured around.
