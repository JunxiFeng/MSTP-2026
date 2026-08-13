# Coding Agents

**REQUIRED DAY 1**

## What agents are useful for, and what they aren't

Coding agents can draft code, explain errors, create validation checks, refactor scripts, and write Slurm starters. They do **not** automatically know your experimental unit, correct pairing/metadata, or what a biologically sound causal interpretation looks like — those come from you, from [01_what_is_bioinformatics.md](01_what_is_bioinformatics.md) and [02_analysis_workflow.md](02_analysis_workflow.md). An agent is a fast collaborator, not a substitute for the scientific judgment in [09_agent_validation.md](09_agent_validation.md).

## Installing an agent

You'll see two common ones referenced in this course: **Claude Code** (Anthropic) and **Codex CLI** (OpenAI). Both work as a terminal tool and as a VS Code extension; you only need one to complete Day 1.

### Claude Code

Terminal install (macOS/Linux):

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Or via Homebrew (macOS):

```bash
brew install --cask claude-code
```

Then, from inside a project folder:

```bash
claude
```

In VS Code, install the **Claude Code** extension from the Extensions view — it embeds the same agent as a sidebar/inline experience and can share context with the terminal session. Docs: [code.claude.com/docs](https://code.claude.com/docs/en/setup).

### Codex CLI

```bash
npm install -g @openai/codex
```

(Requires Node.js 18+; use the exact scoped package name `@openai/codex` — the unscoped `codex` package on npm is an unrelated, older project.) Then:

```bash
codex
```

A Codex VS Code extension is also available from the Extensions view for an in-editor experience.

### On TSCC

Both tools can also be installed on TSCC itself (e.g., via a local `npm`/Node module, or by connecting VS Code to TSCC over Remote-SSH as in [05_jupyter_on_tscc.md](05_jupyter_on_tscc.md) and installing the extension there). Whether you run the agent locally or on the cluster, the DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET loop below is identical.

## Keep your agent off the login node

An agent has no built-in sense that it's sitting on a shared HPC login node instead of your laptop. Asked to "test this," it will just run it — including a statistical fit, a model training loop, or a library call that quietly grabs every core on the machine by default. This is not hypothetical: building this exact course, an agent ran a DESeq2-style fit directly on a TSCC login node before anyone caught it, only noticed because the node started acting sluggish.

The fix is a standing instruction file the agent reads automatically, so you don't have to repeat the rule every session:

- **Claude Code** reads `CLAUDE.md` at your project root.
- **Codex** (and, increasingly, other tools) reads `AGENTS.md` — the same idea, now an open standard several agents share.

This repository already has one — read [`CLAUDE.md`](../../CLAUDE.md) at the repo root as a real, working example:

```text
# HPC Execution Rules

This project runs on a shared HPC cluster.

- Never run computationally intensive analyses directly on login nodes.
- Never use `n_jobs=-1`, unlimited multiprocessing, or all available CPUs.
- Do not launch large Python/R analyses, model training, or large data processing on login nodes.
- Login nodes are only for lightweight file inspection, code editing, debugging, and Slurm submission.
- Substantial computation must run through Slurm (`sbatch` or an allocated compute node).
- Match multiprocessing workers to the CPUs requested from Slurm.
- Before running a potentially expensive command outside Slurm, ask for confirmation.
```

Put an equivalent file in any HPC project you start, before you start prompting, not after something runs somewhere it shouldn't have.

**An instruction file is not a guarantee — verify, the same way you'd verify anything else an agent tells you.** Ask it to run `hostname` before anything substantial, so you both know which machine you're actually on. If a command that should take seconds is still running after a minute or two, that's a signal to check what's actually happening, not to assume it's fine. This is the same VALIDATE habit from the loop below, applied to where code runs, not just what it computes.

## The workflow: DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET

| Step | What you do | Example |
| --- | --- | --- |
| **DEFINE** | State the biological question, experimental unit, and comparison *before* prompting. | "One mouse per sample; compare treated vs. control liver expression." |
| **ASK** | Prompt the agent with that context, not just a task. | "Given this sample sheet (attach it), write a script that computes per-gene fold change between treated and control, keeping mouse as the unit." |
| **RUN** | Execute the code the agent produced, in your known environment ([07_environments_and_reproducibility.md](07_environments_and_reproducibility.md)). | Run the script and inspect the output table. |
| **VALIDATE** | Check the agent's assumptions against your design — did it match samples correctly? Drop any silently? | Diff the output row count against the input sample count. |
| **TEST** | Add or run automated checks (unit tests, sanity assertions) rather than eyeballing output alone. | `pytest` on a small test asserting expected columns/shape. |
| **INTERPRET** | State the biological claim, scoped to what the measurement supports. | "Gene X shows a statistically significant association with treatment in this cohort" — not a causal claim. |

## The art of prompting

A weak prompt describes the code. A strong prompt describes the biology and lets the agent propose the code:

> Weak: "Write a function to compute fold change."
>
> Strong: "I have RNA-seq counts for 6 mice (3 treated, 3 control), one row per gene, one column per mouse, with a separate sample sheet mapping mouse ID to group. Write a script that computes log2 fold change per gene between groups, keeping mouse (not read or sample column) as the unit of replication, and flags any gene with fewer than 2 valid measurements per group."

A few habits separate prompts that work on the first try from ones that quietly go wrong:

- **Give context, not just a task.** State the biological system, the experimental unit, and known confounds explicitly ([01_what_is_bioinformatics.md](01_what_is_bioinformatics.md)) — an agent cannot infer them from column names alone.
- **Be concrete about shape.** Describe (or paste) the actual columns, an example row, and the expected output format. "A CSV with columns `mouse_id, gene, group`" beats "the data."
- **Say what "wrong" looks like.** "Flag genes with fewer than 2 replicates per group" gives the agent a concrete failure mode to guard against, instead of leaving correctness implicit.
- **Treat the first answer as a draft.** Read the code before running it; ask a follow-up ("why did you use a left join here?") rather than accepting or discarding silently.
- **One task at a time when it matters.** A prompt that asks for data cleaning, statistics, and a plot all at once is harder to check than three smaller prompts you can verify in sequence.

## Agentic workflows

A single prompt-and-response is not what makes these tools "agents." What makes them agentic is that, inside a single ask, the tool can **plan a sequence of steps, use tools (read files, run shell commands, search code), observe the result, and revise its own plan** — often across many turns — before handing control back to you. This is a loop happening *inside* the ASK/RUN steps of the table above, on top of the outer DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET loop you run as the scientist.

Anthropic's [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) describes the common shapes this takes — useful vocabulary even if you never build an agent yourself:

- **Prompt chaining** — break one big task into an ordered sequence of smaller prompts, each checked before the next runs.
- **Routing** — classify a request first, then send it down a different path depending on what it is.
- **Parallelization** — run the same task multiple ways (or split it into independent pieces) and combine the results.
- **Orchestrator-workers** — one agent plans and delegates subtasks to others.
- **Evaluator-optimizer** — one agent produces work, another critiques it, and the loop repeats until it passes.

[09_agent_validation.md](09_agent_validation.md)'s Agent A / Agent B split is a version of evaluator-optimizer, done manually: you are the orchestrator deciding when the loop is done.

## Beyond general coding agents: domain-specific biomedical agents (Biomni)

Claude Code and Codex are *general-purpose* coding agents — they know software, not biomedicine specifically. A newer category of agent is built the other way around: pre-loaded with biomedical tools and knowledge, then wrapped in the same plan -> act -> observe loop.

[Biomni](https://biomni.stanford.edu/), from Stanford (published in *Science*, [Huang et al. 2026](https://www.science.org/doi/10.1126/science.adz4351)), is the leading example: it pairs an LLM with more than 150 bioinformatics tools and dozens of curated databases (protein structures, genomic variants, literature) to autonomously read literature, choose a dataset and tool, write and run code, and interpret the result — across tasks like GWAS causal gene detection, rare disease diagnosis, drug repurposing, and single-cell annotation. It's a preview of where the DEFINE -> ASK -> RUN -> VALIDATE -> TEST -> INTERPRET loop is heading: the same loop, but with more of it delegated to the agent — which is exactly why the independent validation habit in [09_agent_validation.md](09_agent_validation.md) becomes more important as agents get more autonomous, not less.

## Further reading

- [Claude Code documentation](https://code.claude.com/docs/en/overview)
- [Claude Code: best practices for agentic coding](https://code.claude.com/docs/en/best-practices)
- [AGENTS.md — the open standard for project instruction files](https://agents.md/)
- [Anthropic: Prompt engineering overview](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview)
- [Anthropic: Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
- [OpenAI: Prompt engineering guide](https://platform.openai.com/docs/guides/prompt-engineering)
- [OpenAI Codex CLI (npm package)](https://www.npmjs.com/package/@openai/codex)
- [Biomni: A General-Purpose Biomedical AI Agent (Science, 2026)](https://www.science.org/doi/10.1126/science.adz4351)
