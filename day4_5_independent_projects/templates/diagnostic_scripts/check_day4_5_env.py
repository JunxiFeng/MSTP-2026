import os
import sys

import anndata
import cnmf
import decoupler
import pertpy
import pydeseq2
import scanpy
import squidpy

print(sys.executable)
print(sys.version)
print(os.getcwd())
print("scanpy", scanpy.__version__)
print("anndata", anndata.__version__)
print("squidpy", squidpy.__version__)
print("pertpy", pertpy.__version__)
print("pydeseq2", pydeseq2.__version__)
print("decoupler", decoupler.__version__)
print("cnmf", cnmf.__version__ if hasattr(cnmf, "__version__") else "(no __version__ attribute)")
