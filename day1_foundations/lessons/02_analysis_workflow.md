# Analysis Workflow

**REQUIRED DAY 1**

## The ladder

Every analysis in this bootcamp follows the same ladder. Each rung constrains the ones below it — a mistake at the top (a wrong study design) cannot be fixed by better code lower down.

```text
1. Biological question
2. Study design
3. Data and metadata
4. Reproducible computation
5. Validation
6. Interpretation
```

**The rule that governs all six steps: the claim should never be stronger than the measurement.** If your measurement is an association in one cell line, your claim cannot be "this mechanism generalizes to patients."

## Walking the ladder with an example

**1. Biological question.** "Does treatment X change expression of gene Y in liver?"

**2. Study design.** Decide the experimental unit (mouse, not read; patient, not sample), the comparison (treated vs. control), the number of independent replicates, and what would count as a confound (batch, sex, litter, sequencing run).

**3. Data and metadata.** The count matrix or table alone is not enough — you need a sample sheet that records treatment group, batch, sex, date, and any other covariate that could explain a difference. Metadata that is incomplete or wrong will silently corrupt every step after it. See [03_data_generation_and_sequencing.md](03_data_generation_and_sequencing.md).

**4. Reproducible computation.** The analysis should be re-runnable by someone else (or by you, in six months) and produce the same result. This depends on version control ([06_git_basics.md](06_git_basics.md)) and a pinned software environment ([07_environments_and_reproducibility.md](07_environments_and_reproducibility.md)).

**5. Validation.** Before you trust a result: check that identifiers matched correctly, that no samples were silently dropped or duplicated, that the statistical test's assumptions hold, and that an independent reviewer (human or agent) agrees with the implementation. See [09_agent_validation.md](09_agent_validation.md).

**6. Interpretation.** State the result, its biological meaning, its limitations, and what would strengthen it (a replicate, an orthogonal assay, a different cohort). A cautious, well-scoped claim is more valuable than a strong, fragile one.

## A short checklist

Before you call an analysis "done," you should be able to answer yes to each of these:

- [ ] Can I state the biological question in one sentence?
- [ ] Do I know the independent experimental unit (not "row in the table")?
- [ ] Is there a metadata table separate from the raw data, and does it match the data 1:1?
- [ ] Can someone else clone the repository, build the environment, and reproduce my output?
- [ ] Have I (or an independent agent) audited the code for silently dropped/duplicated samples and mismatched identifiers?
- [ ] Does my written interpretation stay within what the measurement can support?

## Further reading

- [Ten Simple Rules for Reproducible Computational Research (PLOS Comp Bio)](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003285)
- [FAIR Guiding Principles for scientific data management](https://www.go-fair.org/fair-principles/)
