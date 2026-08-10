# Spatial Transcriptomics Preview

**OPTIONAL / PREVIEW**

Same posture as Day 1's [11_where_to_go_next.md](../../day1_foundations/lessons/11_where_to_go_next.md): this is a conceptual preview, not a hands-on lesson. The goal is knowing this exists and roughly what it's for, not building an analysis today.

## What spatial adds

Everything today has been **dissociated** single-cell data: cells were removed from tissue, so you know each cell's transcriptome but not where it physically sat relative to other cells. Spatial transcriptomics keeps (or approximates) that physical location — each measurement comes with x/y coordinates on a tissue section, sometimes alongside a matching histology image.

This unlocks questions dissociated scRNA-seq structurally cannot answer: which cell types are physically adjacent to each other, whether a gene's expression varies across a tissue region, and whether a group of cells forms a spatially coherent structure (a tumor boundary, a follicle, a cortical layer) rather than just a transcriptional cluster.

## The tool: squidpy

[squidpy](https://squidpy.readthedocs.io/) is the scverse ecosystem's spatial analysis tool — it builds directly on `scanpy`/`AnnData`, so a spatial `AnnData` object looks like what you worked with all day today, plus a `.obsm["spatial"]` array of coordinates.

## Some analysis for reading

Following [sc-best-practices.org's Spatial Omics chapters](https://www.sc-best-practices.org/spatial/neighborhood.html):

- **Neighborhood analysis** — spatial statistics on which cell types tend to sit near each other.
- **Spatial domains** — identifying spatially coherent regions by combining the expression neighbor graph with the physical proximity graph.
- **Spatially variable genes** — genes whose expression follows a spatial pattern, not just a cluster pattern.
- **Spatial deconvolution** — many spatial technologies measure a "spot" containing several cells at once, not one cell; deconvolution methods (Cell2location, SpatialDWLS, RCTD) estimate the cell-type mixture within each spot using a single-cell reference — which is exactly the kind of annotated reference you built in [08_cell_type_annotation.ipynb](08_cell_type_annotation.ipynb).

## Further reading

- [squidpy documentation](https://squidpy.readthedocs.io/)
- [Single-cell best practices — Spatial Omics](https://www.sc-best-practices.org/spatial/neighborhood.html)
- [scanpy: spatial data tutorial](https://scanpy-tutorials.readthedocs.io/en/latest/spatial/basic-analysis.html)
