# Recap and Independent Project Orientation

**REQUIRED DAY 4/5**

## What changes today

Day 1 gave you the tools. Day 2 gave you a real dataset, a real alignment job, and a worked path from FASTQ to annotated cells. Day 3 gave you a real multi-donor dataset and a worked path from counts to a defensible group-level claim, with visualization as the capstone. Every one of those days handed you the question and walked you through an answer.

Today there's no worked answer, and no assigned group. You get one real, public, PHI-free dataset, matched to something you actually said you were interested in on the first day. You choose the scope, run the pipeline, defend your choices, and present what you found — including if what you found is a clean null result. A careful "we didn't find a significant difference, and here's why that's still a real answer" is a completely legitimate outcome; Day 3's own compositional analysis was exactly that.

Some of you share a dataset with someone else in the room. That's an opportunity, not an assignment — talk to each other, compare thresholds, argue about scope — but the notebook you hand in, the choices you defend, and the talk you give are yours alone.

## The independent unit, one more time

Every day so far has hammered the same point from a different direction: cells are not independent replicates (Day 2), donors are (Day 3). Today, before you load any data, write down what your dataset's independent unit actually is — for some it's an animal, for one it's a tumor sample, for one it's a donor you already know from Day 3, for one it's a human brain donor. Get this wrong and every downstream statistic is wrong regardless of how careful the rest of your pipeline is.

## How today works

Five real datasets, each already downloaded, verified, and checkpointed by the instructor — you're not fetching raw data yourself, you're starting from a real, already-loadable file. See [03_project_assignments_and_datasets.md](03_project_assignments_and_datasets.md) for which dataset is yours and why it was matched to your interests.

Each dataset has a locked-in core comparison and, for some, an optional stretch component (a second cell type, an extra comparison, an additional data modality). The stretch is there if you want to go further, not a requirement.

## Today and tomorrow, at a glance

Day 4 is data and design: dataset introduction, loading your real checkpoint, your own QC, orienting to your grouping variable, and writing down your DEFINE statement before you run any group-level test. Day 5 is analysis and communication: the actual comparison, a pathway/program follow-up if it fits your question, a visualization capstone, a peer review using the full Agent B checklist, and a mini-symposium where everyone presents.

## Practice

Before moving to lesson 02, reread Day 3's [01_recap_and_group_level_questions.md](../../day3_biological_inference/lessons/01_recap_and_group_level_questions.md) and Day 2's [02_agent_assisted_scrna_workflow.md](../../day2_single_cell/lessons/02_agent_assisted_scrna_workflow.md) checklist items 13-18 — you'll need the full accumulated checklist today, not just the new items.

## Further reading

- [Day 3's 01_recap_and_group_level_questions.md](../../day3_biological_inference/lessons/01_recap_and_group_level_questions.md) — the donor-vs-cell independent-unit framing this lesson builds on.
