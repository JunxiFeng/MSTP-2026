# Tiny Snakemake Preview

**REFERENCE**

```python
rule count_reads:
    input: "reads/sample.fastq"
    output: "counts/sample.txt"
    shell: "wc -l {input} > {output}"
```

Day 1 does not require writing workflows. This preview shows how future days may describe inputs, outputs, and commands.
