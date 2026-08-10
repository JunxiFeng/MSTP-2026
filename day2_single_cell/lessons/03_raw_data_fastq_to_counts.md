# Raw Data: FASTQ To Counts

**REQUIRED DAY 2**

## Before you start: this lesson teaches STARsolo, but you'll probably use Cell Ranger

If you have 10x Genomics data in your own research, the tool you'll actually reach for is almost certainly **Cell Ranger** (10x's own official pipeline), not STARsolo. One command, `cellranger count`, runs alignment, barcode/UMI processing, cell calling, and basic QC together, using sensible defaults chosen for you — you don't hand-specify barcode length or UMI length the way this lesson does below.

This lesson teaches STARsolo instead specifically because it makes every one of those steps an explicit, visible flag rather than a default buried inside someone else's pipeline — that's the whole point of walking through "real commands" below rather than jumping straight to real output. Once you understand what STARsolo's flags are actually doing, Cell Ranger's defaults stop being a black box; they're the same decisions, just pre-made for you.

**When you do run Cell Ranger yourself**, it hands you a `web_summary.html` report instead of raw log files. Check these before trusting anything downstream (real thresholds, from [10x Genomics' own QC guide](https://www.10xgenomics.com/analysis-guides/quality-assessment-using-the-cell-ranger-web-summary)):

- **Estimated Number of Cells** — does it match what you actually loaded/expected? A wildly off number usually means cell calling went wrong, not that biology surprised you.
- **Mean Reads per Cell** — 10x recommends at least ~20,000 read pairs per cell; well below that and you're likely underpowered to detect lowly-expressed genes.
- **Valid Barcodes** — should be high; below ~75% points at a sequencing or library-prep problem, not a downstream analysis choice.
- **Sequencing Saturation** — how much of the library's actual complexity you've already sequenced (90%+ is considered very good). Low saturation with reads to spare means more sequencing would still find new molecules; it's not automatically bad, but it changes what "more depth" would buy you.
- **Reads Mapped to Genome** — expect >85% for a standard human/mouse sample. Lower than that before you even get to per-gene counting is a reference or sample-quality problem worth chasing down first.
- **Fraction Reads in Cells** — the fraction of good reads that land in barcodes Cell Ranger actually called as cells. Below ~70% signals a lot of ambient RNA/debris contaminating your "cells," the same category of problem Day 2's later QC lessons ask you to catch yourself.

None of this replaces your own QC ([05_loading_data_and_qc.ipynb](05_loading_data_and_qc.ipynb)) — it's the first checkpoint, before you've even opened the count matrix, not the last one.

## Peek at the real data

Today's shared data lives at `/tscc/nfs/home/juf009/day2_shared_data/` (see the [Day 2 README](../README.md#where-todays-data-lives) for why it's there instead of in the git repo). You can read it directly — let's look at an actual read before talking about what it means:

```bash
zcat /tscc/nfs/home/juf009/day2_shared_data/raw/subset_pbmc_1k_v3_S1_L001_R1_001.fastq.gz | head -4
```

```text
@A00228:279:HFWFVDMXX:1:1101:4110:1063 1:N:0:ACATTACT
TGGGCTGGTCGCGGTTCATGGACATTCG
+
FFFFFFFFFFFFFFFFFFFFFFFFFFFF
```

FASTQ format is always four lines per read: an `@`-prefixed header, the sequence, a `+` separator, and a quality string the same length as the sequence (`zcat` decompresses `.gz` on the fly, the same way `--readFilesCommand zcat` will do it for STAR later in this lesson — you already saw `zcat`/`head` in Day 1's [04_command_line.md](../../day1_foundations/lessons/04_command_line.md)).

This is the **R1** file — 28 base pairs, every time, for this 10x v3 chemistry. Split that sequence in two and it stops being an anonymous string of letters:

```text
TGGGCTGGTCGCGGTT CATGGACATTCG
└── cell barcode ┘└── UMI ──┘
  (first 16bp)      (next 12bp)
```

`TGGGCTGGTCGCGGTT` says which droplet (cell) this read came from; `CATGGACATTCG` is the UMI (Unique Molecular Identifier) — distinguishes original transcript molecules from PCR duplicates of the same molecule. Now look at R2 from the exact same read:

```bash
zcat /tscc/nfs/home/juf009/day2_shared_data/raw/subset_pbmc_1k_v3_S1_L001_R2_001.fastq.gz | head -4
```

```text
@A00228:279:HFWFVDMXX:1:1101:4110:1063 2:N:0:ACATTACT
TTCCCTATTAAAATTAGAACCTGAGTATAAATTTACTTTCTCAAATTCTTGCCATGAGAGGTTGATGAGATAATTAAAGGAGAAGATTCCT
+
FFFFF:F:FFFFFFF:FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF:FFFFFFFFFFFFFF,FFF,FF,FFFFFFFFFFFFFFFF:F
```

Same header (`1101:4110:1063`, matching R1's), but 91bp of actual cDNA sequence — this is the piece that gets aligned to the genome. R1 tells you *whose* transcript this is; R2 tells you *what* the transcript is. Neither file alone is useful; a real analysis tool has to read both together, for every one of the 7.7 million read pairs in this dataset.

## From FASTQ to a count matrix: the real commands

Turning millions of these read pairs into one cell-by-gene table takes two computational steps. You won't run either yourself today — the first one alone needs 64GB of RAM and 44 minutes, which doesn't fit in a 4-hour class — but you should understand exactly what produced the data you'll analyze for the rest of the day, not just trust a black box.

### Step 1: build a genome index

Before anything can be aligned, the aligner (STAR) needs a searchable index of the genome:

```bash
STAR --runMode genomeGenerate \
  --genomeDir star_index/ \
  --genomeFastaFiles Homo_sapiens.GRCh37.75.dna.primary_assembly.fa \
  --sjdbGTFfile Homo_sapiens.GRCh37.75.gtf \
  --runThreadN 8
```

- `--runMode genomeGenerate` — build an index; don't align anything yet.
- `--genomeFastaFiles` — the reference genome sequence itself.
- `--sjdbGTFfile` — the gene annotation (which coordinates are genes, exons, splice junctions). STAR uses this to build a database of known splice junctions so it can correctly align reads that span an intron.
- `--runThreadN` — how many CPU threads to use.

**A real thing that went wrong here**: the gene annotation file and the genome sequence file need to agree on how they name chromosomes. The first real attempt at this command failed outright, because one file called a chromosome `chr1` and the other called the same chromosome `1` — zero overlap, so STAR couldn't place a single gene. Two reference files that are individually correct can still be incompatible with each other; that's worth remembering the next time you pair a genome with an annotation from a different source.

**Why the whole genome, not one chromosome to save time**: building this index is slow because of the genome's size, not because of how many reads you'll eventually align — subsampling the FASTQs to ~300 cells does nothing to speed this step up. It's tempting to index just one chromosome to make it faster, but the marker genes you'll need in [08_cell_type_annotation.ipynb](08_cell_type_annotation.ipynb) — CD3D, CD8A, MS4A1, CD19, NKG7, LYZ, CD14, FCGR3A, PPBP — are spread across at least 8 different chromosomes. Indexing just one would silently make several cell types undetectable three lessons from now.

### Step 2: align your reads and count them per cell

```bash
STAR --runMode alignReads \
  --genomeDir star_index/ \
  --readFilesIn R2_L001.fastq.gz,R2_L002.fastq.gz R1_L001.fastq.gz,R1_L002.fastq.gz \
  --readFilesCommand zcat \
  --soloType CB_UMI_Simple \
  --soloCBwhitelist 3M-february-2018.txt \
  --soloCBstart 1 --soloCBlen 16 --soloUMIstart 17 --soloUMIlen 12 \
  --soloCBmatchWLtype 1MM_multi \
  --soloFeatures Gene \
  --outSAMtype None \
  --runThreadN 8
```

- `--readFilesIn` — cDNA reads (R2) first, then barcode+UMI reads (R1) second; comma-separated when you have multiple lanes, exactly like today's two lanes.
- `--soloType CB_UMI_Simple` — the standard mode for droplet-based single-cell data.
- `--soloCBwhitelist` — the list of ~3 million barcode sequences 10x actually manufactured; real barcodes get corrected against this list, since sequencing has errors.
- `--soloCBstart 1 --soloCBlen 16 --soloUMIstart 17 --soloUMIlen 12` — exactly the split you just did by hand above: 16bp barcode starting at position 1, 12bp UMI starting at position 17.
- `--soloCBmatchWLtype 1MM_multi` — allow up to 1 mismatch when matching a barcode to the whitelist, since a single sequencing error shouldn't throw away an otherwise-good read.
- `--outSAMtype None` — skip writing full alignment files; today only the count matrix is needed.

This step is fast — the real run took under 2 minutes once the index existed. Building the index is what's slow; aligning is not. Real results from that exact run: **7,685,925 input reads, 88.68% uniquely mapped, 272 cells detected, 16,707 genes.**

## See the real output yourself

Both commands above have already been run once for this class. Read their actual output directly — this isn't a summary, it's the real log file:

```bash
cat /tscc/nfs/home/juf009/day2_shared_data/counts/Log.final.out
```

```text
                          Number of input reads |	7685925
                      Uniquely mapped reads % |	88.68%
             % of reads mapped to multiple loci |	7.62%
                    % of reads unmapped: too short |	3.34%
```

```bash
cat /tscc/nfs/home/juf009/day2_shared_data/counts/Solo.out/Gene/Summary.csv
```

```text
Number of Reads,7685925
Estimated Number of Cells,272
Mean Reads per Cell,13891
Median Genes per Cell,1696
Total Gene Detected,16707
```

## Practice

Run both `cat` commands above yourself. From the real output, answer: what fraction of reads mapped uniquely, how many cells were detected, and how does that compare to the "~300 cells" description of today's dataset? Then, in your own words, explain why building the genome index needed so much more memory than aligning did.

## Further reading

- [10x Genomics: Quality Assessment Using the Cell Ranger Web Summary](https://www.10xgenomics.com/analysis-guides/quality-assessment-using-the-cell-ranger-web-summary) — the real thresholds behind the "Before you start" section above.
- [Cell Ranger count Web Summary reference](https://www.10xgenomics.com/support/software/cell-ranger/latest/analysis/outputs/cr-outputs-web-summary-count) — every metric in the report, not just the ones flagged above.
- [STARsolo documentation](https://gensoft.pasteur.fr/docs/STAR/2.7.9a/STARsolo.html)
- [Galaxy Training Network: Pre-processing of 10X Single-Cell RNA Datasets](https://training.galaxyproject.org/training-material/topics/single-cell/tutorials/scrna-preprocessing-tenx/tutorial.html) — a full worked tutorial using this exact dataset and tool.
- [10x Genomics: Best Practices for Analysis of 10x Genomics Single Cell RNA-seq Data](https://www.10xgenomics.com/analysis-guides/best-practices-analysis-10x-single-cell-rnaseq-data)
- [Single-cell best practices — Raw data processing](https://www.sc-best-practices.org/introduction/raw_data_processing.html)
