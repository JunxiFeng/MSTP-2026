# Data Generation And Sequencing

**REQUIRED DAY 1**

## Why this matters before you touch code

The file format, noise structure, and unit of replication in your data are all consequences of how the data was generated in the lab. You cannot design a correct analysis (Step 3 of [02_analysis_workflow.md](02_analysis_workflow.md)) without a rough mental model of that pipeline.

## From biological material to a count matrix (bulk RNA-seq-like data)

```text
Biological material (tissue / cells)
  -> RNA extraction
  -> library preparation (fragmentation, adapters, amplification)
  -> sequencing (instrument reads short/long DNA fragments)
  -> raw reads (FASTQ)
  -> alignment or assignment to a reference (BAM) or pseudo-alignment
  -> a gene-by-sample count matrix
```

Each arrow is a place where bias or error can enter: extraction efficiency, library prep batch, sequencing depth, alignment choices. This is why metadata (batch, extraction date, RNA quality) is captured alongside the data, not reconstructed afterward.

## Sequencing platforms, briefly

- **Short-read (Illumina)** — high accuracy, high throughput, reads ~50-300bp. The default for most RNA-seq, ChIP-seq, ATAC-seq, and genotyping workloads.
- **Long-read (PacBio, Oxford Nanopore)** — reads from hundreds to tens of thousands of bp, used for genome assembly, structural variants, and isoform-resolved transcriptomics.

You don't need to become an instrument expert on Day 1 — just know that "sequencing" is not one technology, and the platform shapes which questions the data can answer.

## Single-cell data adds two things

- **Cell barcodes**: which droplet/well a read came from, so reads can be assigned back to individual cells.
- **UMIs (Unique Molecular Identifiers)**: distinguish original transcript molecules from PCR duplicates.

The experimental unit also shifts: in single-cell data, "cell" is not automatically the independent unit for statistics — the *sample/subject* usually still is, because cells from the same subject are not independent replicates of each other.

## Clinical and imaging data

These often arrive already collapsed into a **participant-by-feature table** (rows = patients/participants, columns = clinical variables, lab values, or image-derived features). The generation pipeline is different (chart abstraction, imaging + segmentation) but the same principle applies: know what upstream processing already happened before the table reached you, since it constrains what you can validly test.

## Common file formats you'll see

| Format | Contains | Typically produced by |
| --- | --- | --- |
| `.fastq` / `.fastq.gz` | Raw sequencing reads + quality scores | Sequencer / basecaller |
| `.bam` / `.sam` | Reads aligned to a reference genome | Aligner (e.g., BWA, STAR, minimap2) |
| `.vcf` | Called genetic variants | Variant caller (e.g., GATK) |
| `.csv` / `.tsv` | Count matrices, metadata, tabular results | Downstream processing scripts |

See [common_file_types.md](../../resources/cheatsheets/common_file_types.md) for a quick-reference cheatsheet.

## Further reading

- [Illumina: Sequencing 101](https://www.illumina.com/science/technology/next-generation-sequencing/beginners.html)
- [10x Genomics: Single Cell Gene Expression — how it works](https://www.10xgenomics.com/products/single-cell-gene-expression)
- [NCBI: Sequence Read Archive (SRA) — what raw sequencing data looks like in public repositories](https://www.ncbi.nlm.nih.gov/sra/docs/)
- [Galaxy Training Network: Introduction to Genomics](https://training.galaxyproject.org/) — free, hands-on lessons if you want to go deeper on any specific assay.
