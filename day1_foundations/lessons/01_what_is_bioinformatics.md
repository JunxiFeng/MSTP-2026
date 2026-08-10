# What Bioinformatics Is

**REQUIRED DAY 1**

## The core idea

Bioinformatics connects a biological question to computational evidence. It is not "learn Python" or "learn a pipeline" — it is the discipline of turning biological measurements into data, and turning data into a claim you can defend. Software is a means to that end, chosen *after* the scientific design is clear, not before.

Before opening a terminal or a notebook, you should be able to name four things:

| Element | Question to ask | Example (bulk RNA-seq) |
| --- | --- | --- |
| **System** | What biological system produces the signal? | Mouse liver tissue |
| **Measurement** | What is actually being measured, and by what instrument/assay? | Illumina short-read sequencing of polyadenylated RNA |
| **Experimental unit** | What is the independent, replicable unit? (Not "how many reads" — "how many mice") | One mouse per sample; treated vs. control |
| **Claim** | What statement do you want to defend at the end, and how strong can it be? | "Gene X is differentially expressed between treated and control livers" — not "Gene X causes the phenotype" |

If you cannot fill in this table, you are not ready to write code yet — you are still doing study design, which is exactly where you should start.

## Why this order matters

A common failure mode is: pick a tool or tutorial first, run it on whatever data is available, and only afterward ask what the result means biologically. This produces analyses that run without errors but that don't actually answer the question, because the *unit of replication* or *metadata* needed to answer it was never captured. Bioinformatics as a discipline is the habit of designing the analysis around the biology first, so that the computation that follows is answerable to a real claim. [02_analysis_workflow.md](02_analysis_workflow.md) turns this into a concrete ladder you will use for every analysis this week.

## What this looks like in practice

- A biologist asks "did the drug change gene expression in liver?"
- You restate it as: system = mouse liver; measurement = RNA-seq counts per gene; experimental unit = mouse (not sample, not read); claim = a *statistical association* between treatment and expression, with a stated limitation about causality.
- Only now do you choose file formats, alignment tools, statistical tests, and visualization — because you know what they need to produce.

## AI is accelerating this field faster than almost any other

Everything above has been true of bioinformatics for two decades. What's new, and worth naming explicitly, is how fast AI is now compressing each rung of that process:

- **Structure prediction that used to take a PhD now takes minutes.** [AlphaFold](https://alphafold.ebi.ac.uk/) turned protein structure prediction from a career-defining experimental result into a database lookup for over 200 million proteins; [AlphaGenome](https://deepmind.google/discover/blog/alphagenome-ai-for-better-understanding-the-genome/) extends this to predicting regulatory and functional effects across long stretches of DNA.
- **Coding agents change who can build an analysis, not just how fast.** The same DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET loop you'll practice in [08_coding_agents.md](08_coding_agents.md) lets someone without years of software training go from a biological question to working, checked code in the same afternoon — which is also exactly why the validation discipline in [09_agent_validation.md](09_agent_validation.md) matters more, not less.
- **"Co-scientist" agents are starting to run parts of the research loop themselves.** Systems like Stanford's [Biomni](https://biomni.stanford.edu/) (see also [08_coding_agents.md](08_coding_agents.md)) combine LLMs with hundreds of bioinformatics tools and curated databases to read literature, choose tools, write code, and propose next experiments across tasks like variant prioritization, rare disease diagnosis, and single-cell annotation.

None of this changes the core lesson of this page: a faster way to get an answer is not a faster way to know whether the answer is *right*. If anything, as the computational half of the ladder gets cheaper and faster, the biological judgment in the other half — the question, the design, the claim you can actually defend — becomes the part that most differentiates good bioinformatics from a plausible-looking mistake.

## Further reading

- [Luscombe, Greenbaum & Gerstein — "What is Bioinformatics? A Proposed Definition and Overview of the Field" (2001)](https://pubmed.ncbi.nlm.nih.gov/11552348/) — the classic review this section's framing draws from; short and worth reading in full.
- [Xiaole Shirley Liu — STAT115/215: Introduction to Bioinformatics and Computational Biology (Harvard)](https://liulab-dfci.github.io/bioinfo-combio/) — a full graduate course (syllabus, slides, and recorded lectures) from one of the field's leading computational biologists; a good next step once Day 1 is done.
- [Tommy Tang — "How I Would Learn Bioinformatics From Scratch, 12 Years Later: A Roadmap"](https://divingintogeneticsandgenomics.com/post/bioinfo-roadmap/) — a practicing computational biologist's candid, opinionated roadmap for what to actually learn and in what order.
- [Biology Meets Programming: Bioinformatics for Beginners (UC San Diego, Coursera)](https://www.coursera.org/learn/bioinformatics) — free-to-audit "Python for bioinformatics" course that pairs classic algorithms (e.g., finding patterns in DNA) with the code that implements them.
