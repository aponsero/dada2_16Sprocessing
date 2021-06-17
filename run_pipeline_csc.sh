#!/bin/bash -l
#SBATCH --job-name=dada2_pipeline
#SBATCH --account=Project_2001503
#SBATCH --output=output_%j.txt
#SBATCH --error=errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=02:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=1000

# Load r-env-singularity
module load r-env-singularity

# Clean up .Renviron file in home directory
if test -f ~/.Renviron; then
    sed -i '/TMPDIR/d' ~/.Renviron
    sed -i '/OMP_NUM_THREADS/d' ~/.Renviron
fi

# Specify a temp folder path
echo "TMPDIR=/scratch/<project>" >> ~/.Renviron

# Run the filtering script
srun singularity_wrapper exec Rscript --no-save 1_FilterTrim.R

# Run the error learning script
srun singularity_wrapper exec Rscript --no-save 2_FilterError.R

# assigne taxonomy
srun singularity_wrapper exec Rscript --no-save 3_mergeTax.R



