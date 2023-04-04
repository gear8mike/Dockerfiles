#! /bin/bash
conda env create -f environment.yml
conda activate comb_km3net_cta_env
python -m ipykernel install --user --name=comb_cta
conda deactivate
