import os
import sys

import anndata
import scanpy
import squidpy

print(sys.executable)
print(sys.version)
print(os.getcwd())
print("scanpy", scanpy.__version__)
print("anndata", anndata.__version__)
print("squidpy", squidpy.__version__)
