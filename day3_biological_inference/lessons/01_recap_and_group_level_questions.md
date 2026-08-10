# Recap And Group-Level Questions

**REQUIRED DAY 3**

## Three days, three units of replication

| Day | Data shape | The independent unit |
| --- | --- | --- |
| Day 1 | One profile per bulk sample | The sample |
| Day 2 | One profile per cell, one donor | Still the donor — a cell is not a replicate ([day2_single_cell/lessons/01](../../day2_single_cell/lessons/01_recap_and_single_cell_orientation.md)) |
| Day 3 (today) | One profile per cell, **multiple donors, multiple conditions** | Still the donor |

Day 2 deliberately used one shared sample, so every question you could ask was "what cell types are present in this donor?" — a legitimate question, but not a *comparison*. Today's dataset has multiple donors, each measured under two conditions, which finally makes group comparisons valid — but only if you keep treating the donor, not the cell, as the unit that counts.

## Today's dataset

[Kang et al. 2018](https://www.nature.com/articles/nbt.4042) (GSE96583): PBMCs from lupus patients, each donor split into two aliquots — one left untreated, one stimulated with IFN-β for 6 hours. Every donor contributes **one paired sample per condition**, so every comparison today is naturally paired: the same donor, two conditions. Exact donor count, cell counts, and cell-type breakdown are confirmed in [03_loading_the_kang_dataset.ipynb](03_loading_the_kang_dataset.ipynb) directly from the real data, not stated here from memory.

You will not download this yourself — like Day 2's FASTQs, it's already been fetched once and cached; see [03_loading_the_kang_dataset.ipynb](03_loading_the_kang_dataset.ipynb) for the real one-line command that produced it and why it isn't something to re-run live.

## Today's map

```text
Kang et al. 2018 (cached, multi-donor, multi-condition PBMCs)
  -> differential expression: naive per-cell test vs. proper pseudobulk test
  -> compositional analysis: did cell-type proportions shift with stimulation?
  -> pathway / gene set analysis: what biology do the DE genes point to?
  -> gene expression programs: patterns that cut across cell-type clusters
  -> visualization: turn all four outputs into figures worth showing someone
```

Every step except gene expression programs depends on the donor-condition pairing; gene expression programs (lessons 07-08) don't need conditions at all — they're about finding coherent gene patterns within the data, a different kind of question entirely.

## Further reading

- [Kang et al. 2018, Nature Biotechnology](https://www.nature.com/articles/nbt.4042) — the original paper this dataset comes from.
