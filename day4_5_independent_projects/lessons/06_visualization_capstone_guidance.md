# Visualization Capstone Guidance

**REQUIRED DAY 4/5**

## Why this is guidance, not another worked notebook

Day 1, 2, and 3 each ended with a fully-worked visualization capstone — every figure built and rendered as the teaching example. Today can't work that way: the figures *are* your original result. This lesson instead demonstrates the palette and figure choices on synthetic numbers that reveal nothing about anyone's actual data, so you can see the pattern applied without seeing an answer. Your own capstone figures go in your project's starter notebook, scaffolded only.

## Load the `dataviz` skill before writing any plotting code

Same rule as every prior capstone: load it first, don't default to stock matplotlib/seaborn styling. This course's validated categorical pair — blue `#2a78d6` and orange `#eb6834` — has been used consistently across Day 3's figures; keep using it rather than picking new colors per project, so a viewer moving between talks at the mini-symposium isn't relearning a color key each time.

## A small worked example (synthetic numbers only)

```python
import matplotlib.pyplot as plt
import numpy as np

CTRL = "#2a78d6"   # this course's validated categorical pair
STIM = "#eb6834"

groups = ["Group A", "Group B"]
means = [2.1, 3.4]      # illustrative only -- not a real result
sems = [0.3, 0.4]

fig, ax = plt.subplots(figsize=(4, 3.5))
x = np.arange(len(groups))
ax.bar(x, means, yerr=sems, color=[CTRL, STIM], width=0.5, capsize=4)
ax.set_xticks(x)
ax.set_xticklabels(groups)
ax.set_ylabel("Mean expression (illustrative units)")
ax.spines[["top", "right"]].set_visible(False)   # recessive axes, not decoration
fig.tight_layout()
```

This was actually run (not just written) to confirm it executes without error. What it demonstrates: a fixed categorical pair assigned by group identity (never re-cycled if you add a third group — fold it into the pair or facet instead), no dual axis, no rainbow, recessive spines, and — for your real figure — a legend whenever you have 2+ series and direct labels when there's room for a handful, not every point.

## Match the figure to your result, not the other way around

- **A single DE result** → a volcano plot (diverging color for direction, sequential for magnitude if you're doing a heatmap instead).
- **A composition result, including a null one** → per-sample/per-donor paired plot if your design is paired (Day 3's lesson 09 had a real bug here — invisible pairing lines on the first draft, fixed with jittered x-positions; check yours renders visibly before calling it done).
- **A pathway result** → a ranked bar or dot plot, sequential single-hue for magnitude.
- **A gene expression program result (optional)** → a usage heatmap, sequential single-hue.

## Practice

Build 2-4 figures in your project's starter notebook. Before finalizing, actually look at the rendered output — Day 3's own capstone caught a real readability bug this way, not through code review.

## Further reading

- [Day 3's 09_visualization_capstone.ipynb](../../day3_biological_inference/lessons/09_visualization_capstone.ipynb) — the fully-worked example this lesson's guidance is drawn from.
