"""Automated sanity checks on the shared Day 2 count matrix.

Usage: python verify_counts_matrix.py path/to/counts.h5ad
"""

import sys

import numpy as np
import scanpy as sc

PBMC_MARKERS = [
    "CD3D", "CD8A", "MS4A1", "CD19", "NKG7", "LYZ", "CD14", "FCGR3A", "PPBP",
]


def check(name, condition, detail):
    status = "PASS" if condition else "FAIL"
    print(f"[{status}] {name}: {detail}")
    return condition


def info(name, detail):
    print(f"[INFO] {name}: {detail}")


def main(h5ad_path):
    adata = sc.read_h5ad(h5ad_path)
    ok = True

    ok &= check(
        "cell count in expected range",
        50 <= adata.n_obs <= 5000,
        f"n_obs={adata.n_obs}",
    )
    ok &= check(
        "gene count in expected range",
        5000 <= adata.n_vars <= 60000,
        f"n_vars={adata.n_vars}",
    )
    ok &= check(
        "no duplicate cell barcodes",
        adata.obs_names.is_unique,
        f"{adata.obs_names.duplicated().sum()} duplicates found",
    )
    zero_cells = int((np.asarray(adata.X.sum(axis=1)).ravel() == 0).sum())
    ok &= check("no all-zero cells", zero_cells == 0, f"{zero_cells} all-zero cells")
    zero_genes = int((np.asarray(adata.X.sum(axis=0)).ravel() == 0).sum())
    info(
        "all-zero genes",
        f"{zero_genes}/{adata.n_vars} genes undetected in this sample — normal for a "
        "small cell count, not a failure; filtered out during feature selection "
        "in 06_normalization_and_feature_selection.md, not here.",
    )
    present = [g for g in PBMC_MARKERS if g in adata.var_names]
    missing = [g for g in PBMC_MARKERS if g not in adata.var_names]
    ok &= check(
        "classic PBMC marker genes present in var_names",
        len(missing) == 0,
        f"present={present} missing={missing}",
    )

    if not ok:
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(1)
    main(sys.argv[1])
