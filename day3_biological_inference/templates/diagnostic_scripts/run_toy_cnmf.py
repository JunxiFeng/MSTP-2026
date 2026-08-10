"""Run a small, deliberately abbreviated cNMF grid -- your own light version
of the instructor's full run.

Reads the same CD4 T cells subset the instructor's full grid used (already
prepared, read-only, shared). Writes to your OWN results/ folder, not the
shared data directory -- you don't have write access there, and shouldn't.
"""

import sys
from cnmf import cNMF

SUBSET_PATH = "/tscc/nfs/home/juf009/day3_shared_data/cd4_tcells_for_cnmf.h5ad"


def main(output_dir):
    cnmf_obj = cNMF(output_dir=output_dir, name="cd4_toy_run")

    # Deliberately small: one K, few iterations -- fast, but noisier than
    # the instructor's full grid (6 K values, 100 iterations each).
    K_RANGE = [7]
    N_ITER = 10
    cnmf_obj.prepare(counts_fn=SUBSET_PATH, components=K_RANGE, n_iter=N_ITER, seed=1)
    cnmf_obj.factorize(worker_i=0, total_workers=1)
    cnmf_obj.combine()
    cnmf_obj.consensus(k=7, density_threshold=0.5, show_clustering=True, close_clustergram_fig=True)
    cnmf_obj.k_selection_plot(close_fig=True)
    print("DONE -- output in", f"{output_dir}/cd4_toy_run/")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(1)
    main(sys.argv[1])
