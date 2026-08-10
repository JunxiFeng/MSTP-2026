# Gene Expression Programs And HPC Practice

**REQUIRED DAY 3**

## A different kind of question

Everything through lesson 06 asked "did X change between stim and ctrl?" — a question about *conditions*. Gene expression programs ask something else entirely: **within a set of cells, are there coherent groups of genes that tend to turn on and off together, cutting across (not aligned with) the cell-type clusters from Day 2?** A "program" might be an activation state, a stress response, or a cell-cycle signature — something a cell can be doing regardless of which discrete cluster it landed in.

The tool: **cNMF** (consensus non-negative matrix factorization) — [Kotliar et al. 2019, eLife](https://elifesciences.org/articles/43803), the field's standard method. It factors a cell x gene matrix into a small number of "programs" (K of them) x their per-cell usage, run many times with different random seeds, then keeps only the programs that show up consistently — a *consensus*, not a single lucky factorization.

## Already run: the full grid

A methodologically real cNMF analysis needs many values of K and many random-seed replicates per K — not because any single run is slow, but because you need to see which K produces *stable* programs across replicates, not just whichever K a single run happened to converge to. Confirmed on today's data — **11,238 CD4 T cells**, K = [5, 7, 8, 10, 12, 15], 100 iterations per K (**600 total NMF runs**) — this took **22.3 minutes, in one single process, no Slurm array job needed.** That number surprised us going into building this course: Day 2's STAR alignment genuinely needed heavy, hard-to-parallelize compute; this doesn't. Not every "many independent runs" problem needs parallel infrastructure — sometimes checking is cheaper than assuming.

The stability results (silhouette score, higher = more stable) picked a clear winner:

| K | Silhouette |
| --- | --- |
| 5 | 0.872 |
| **7** | **0.917** |
| 8 | 0.846 |
| 10 | 0.760 |
| 12 | 0.781 |
| 15 | 0.790 |

**K=7 has the clearly highest stability** — not the highest K, not an arbitrary round number, the one the data actually supports. [08_gene_expression_programs_interpretation.ipynb](08_gene_expression_programs_interpretation.ipynb) uses this K=7 consensus result.

## Your turn: the same skill, a smaller version

You won't run the full grid — but you will run a real, working cNMF job yourself, the same "same skill, smaller scale" pattern as [Day 2's HPC practice](../../day2_single_cell/lessons/04_hpc_practice.md): one K (7), only 10 iterations instead of 100.

Run from this repository's root (same convention as Day 1/Day 2's practice jobs):

```bash
sbatch day3_biological_inference/templates/slurm_templates/day3_practice_job.slurm
squeue -u $USER
```

Confirmed real runtime: **23 seconds.** Once it finishes, check `results/cnmf_practice/cd4_toy_run/` for your own consensus output and K-selection plot.

**The point isn't speed — it's instability.** Your run used 10 iterations; the instructor's used 100. Compare your K=7 consensus program definitions (in your output folder) against the instructor's (loaded in the next notebook) — expect yours to look noisier, less crisp, possibly missing a program the full run found cleanly. That difference *is* the lesson: Agent-B checklist item 23 (was K and its gene loadings checked for stability across replicates?) exists because a single run, or too few replicates, can hand you a confident-looking answer that doesn't reproduce.

## Agent-assisted GEP discovery, done right

> Weak: "Run cNMF and tell me the gene programs."
>
> Strong: "Run cNMF across a range of K with at least 20-100 replicates per K, and report the stability (silhouette) for each K before picking one — don't just pick the K I asked for or the default; show me the stability comparison first."

## Practice

Submit your own job above. Open a fresh Agent B session and run checklist item 23 against the difference between your toy run and the instructor's full run.

## Further reading

- [Kotliar et al. 2019, "Identifying gene expression programs of cell-type identity and cellular activity with single-cell RNA-Seq," eLife](https://elifesciences.org/articles/43803)
- [cNMF documentation (GitHub)](https://github.com/dylkot/cNMF)
