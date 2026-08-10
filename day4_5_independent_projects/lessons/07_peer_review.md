# Peer Review

**REQUIRED DAY 4/5**

## Pick a reviewer

No assigned pairs today. Find one other person — ideally someone using a different dataset than yours — and trade notebooks, mutually: you review theirs, they review yours. Someone who doesn't already know your dataset can't fill in gaps you didn't actually close in the notebook, which is closer to what checklist item 27 (reproducibility by someone else) is actually testing than a reviewer who already knows the answer.

## What you hand your reviewer

1. Your completed starter notebook, run top to bottom, with all output visible.
2. Your filled-in Agent B prompt fields (Biological question, Experimental design, Independent biological unit, Main comparison) from lesson 02.

## What your reviewer does

Run the full 30-item Agent B checklist against your notebook and prompt fields, same PASS/WARNING/FAIL/evidence/smallest-correction format used all week. Give real weight to items 25-30 — those are the ones nobody has pre-checked for either of you before today:

- **25**: Does the notebook's own narrative show the scope was decided before results, or does it read like it was adjusted afterward?
- **26**: If the checkpoint includes any pre-computed labels, were they spot-checked?
- **27**: Can you, the reviewer, actually re-run this notebook top to bottom yourself and get the same thing?
- **28**: Does the stated conclusion match the actual species/tissue/timepoint/n, or does it overreach?
- **29**: If code was adapted from Day 2, Day 3, or someone else's project, was it re-justified against this dataset?
- **30**: Is any stretch content clearly marked as stretch, separate from the core claim?

## Resolving disagreements

If you and your reviewer disagree about a PASS vs. WARNING vs. FAIL, don't average it or split the difference — trace the specific item back to the actual code and data together, the same rule this course has used since Day 1. Whoever is right should be able to point at a specific line or number, not just an impression.

## Practice

Budget the full 40 minutes in the Day 5 schedule for this — 20 minutes to hand off and read, 20 minutes to run the checklist and write feedback. Bring disagreements you couldn't resolve into the mini-symposium Q&A; a reviewer's unresolved WARNING is a legitimate thing to raise from the audience.

## Further reading

- [09_agent_validation.md](../../day1_foundations/lessons/09_agent_validation.md) — where the "trace it back, don't average" rule was first stated, for Agent A/Agent B disagreements specifically.
