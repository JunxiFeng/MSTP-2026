# HPC Practice: Submitting Your Own Job

**REQUIRED DAY 2**

## Same skill, smaller scale

Day 1's [10_hpc_and_slurm.md](../../day1_foundations/lessons/10_hpc_and_slurm.md) taught you `sbatch`/`squeue`/`sacct`/`scancel`. The heavy compute in [03_raw_data_fastq_to_counts.md](03_raw_data_fastq_to_counts.md) doesn't get repeated live in class — but the underlying skill is identical, just at a scale you can actually run and wait for yourself, right now.

## Step 1 — Submit it

**Input:** the checkpoint count matrix. `CHECKPOINT_H5AD` in [templates/slurm_templates/day2_practice_job.slurm](../templates/slurm_templates/day2_practice_job.slurm) already defaults to the right path, so there's nothing to fill in.

**Command** (run from this repository's root — same convention as Day 1's `sbatch day1_foundations/templates/slurm_templates/day1_template.slurm`):

```bash
sbatch day2_single_cell/templates/slurm_templates/day2_practice_job.slurm
```

**Output:**

```text
Submitted batch job 11738204
```

That number is the job ID — yours will differ every time you submit.

## Step 2 — Watch it, then read the result

**Command:**

```bash
squeue -u $USER
```

**Output** (illustrative — your job ID, node, and `TIME` will all be different from this):

```text
  JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
11738204     hotel day2-pra   juf009  R       0:26      1 tscc-11-17
```

`sbatch` printed your own job ID when you submitted (`Submitted batch job <jobid>`) — use that number, not the one above, everywhere below. Once it drops off the `squeue` list (a confirmed run took 1m52s — most of that is Python/scanpy startup, not the checks themselves, but yours may take more or less), check what it did:

```bash
sacct -j <jobid> --format=JobID,JobName,State,Elapsed,ExitCode
```

```text
JobID           JobName      State    Elapsed ExitCode
------------ ---------- ---------- ---------- --------
11738204     day2-prac+  COMPLETED   00:01:52      0:0
```

Then read the log it produced (again, substitute your own job ID for the filename):

```bash
cat logs/day2-practice-<jobid>.out
```

```text
[PASS] cell count in expected range: n_obs=272
[PASS] gene count in expected range: n_vars=57905
[PASS] no duplicate cell barcodes: 0 duplicates found
[PASS] no all-zero cells: 0 all-zero cells
[INFO] all-zero genes: 41198/57905 genes undetected in this sample — normal for a small cell count, not a failure; filtered out during feature selection in 06_normalization_and_feature_selection.ipynb, not here.
[PASS] classic PBMC marker genes present in var_names: present=['CD3D', 'CD8A', 'MS4A1', 'CD19', 'NKG7', 'LYZ', 'CD14', 'FCGR3A', 'PPBP'] missing=[]
```

Everyone runs this against the same shared `CHECKPOINT_H5AD`, so unlike the job ID/node/timing above, these particular numbers (`n_obs`, `n_vars`, marker genes) should come out the same for you as they did here — this is one real run's output, not a hypothetical. Each line is one automated check from [templates/diagnostic_scripts/verify_counts_matrix.py](../templates/diagnostic_scripts/verify_counts_matrix.py) — your first look at the kind of automated check you'll rely on again as the TEST step in every notebook from here on. All nine marker genes present is the direct payoff of the full-genome index decision in lesson 03. Any `FAIL` line, or numbers that don't match, is worth chasing down before moving on — the same instinct as Day 1's [reading errors without panicking](../../day1_foundations/lessons/04_command_line.md).

## If you see `QOSMaxMemoryPerJob`

This account's default QOS caps memory per job at zero — any submission missing `--partition=hotel --qos=hotel` fails immediately, no matter how small `--mem` is. `day2_practice_job.slurm` already has both flags; if you ever copy a Slurm script and strip the header down, keep those two lines.

## Practice

Submit your own job now and read the real log it produces, following the steps above.

## Further reading

- [Day 1: HPC and Slurm](../../day1_foundations/lessons/10_hpc_and_slurm.md) — everything here builds directly on that lesson.
