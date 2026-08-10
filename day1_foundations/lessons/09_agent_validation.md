# Agent Validation

**REQUIRED DAY 1**

Agent A helps construct an analysis. Agent B independently audits assumptions, implementation, and interpretation. The researcher resolves disagreements and makes the scientific judgment. **Multiple agents agreeing is not proof** — they can share the same blind spot, especially if given the same incomplete context.

In practice: after Agent A produces an analysis, open a **new session** of Claude Code or Codex (or a fresh conversation in the same tool) and paste in the prompt below. A fresh session hasn't seen Agent A's reasoning, so it isn't anchored to it.

## Reusable Agent B Prompt

```text
You are independently reviewing another coding agent's bioinformatics analysis.

Biological question:
[fill in]

Experimental design:
[fill in]

Independent biological unit:
[fill in]

Main comparison:
[fill in]

Audit the code, outputs, and interpretation.

Check:
1. Is the independent experimental unit handled correctly?
2. Is pairing/repeated-measure structure preserved?
3. Are identifiers matched safely?
4. Are samples silently dropped, duplicated, or reordered?
5. Are missing values handled transparently?
6. Are transformations appropriate?
7. Could batch or another covariate explain the result?
8. Does the visualization represent biological replication correctly?
9. Are statistical assumptions supported?
10. Does the interpretation go beyond what the measurement supports?
11. Can the result be reproduced from the provided inputs?
12. Are there hard-coded paths or environment assumptions?

For each item return PASS / WARNING / FAIL, evidence, smallest correction, automated checks, and remaining uncertainty.
```

If Agent A and Agent B disagree, trace the specific check back to the actual code and data yourself — don't average the two opinions or pick whichever you prefer.
