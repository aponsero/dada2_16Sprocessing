# dada2_16Sprocessing
Simple pipeline for 16S taxonomic analysis using dada2


## Before running:

### conda env
If necessary create the conda environment for dada2 (not necessary in puhti at csc)

```
conda env create -f dada2.yml
```

### Database
Download the appropriate dada2 databases for the taxonomic annotation step:

```
mkdir database
wget https://zenodo.org/record/2541239/files/RefSeq-RDP16S_v2_May2018.fa.gz
```

More databases accessible at https://benjjneb.github.io/dada2/training.html 

### scripts
Make sure to indicate the correct path for input files before running the script (run_pipeline_ua.sh or run_pipeline_csc.sh)

