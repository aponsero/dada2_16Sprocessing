#!/bin/bash
#SBATCH --job-name=dada2
### REQUIRED. Specify the PI group for this job
#SBATCH --account=bhurwitz
### Optional. Request email when job begins and ends
### SBATCH --mail-type=ALL
### Optional. Specify email address to use for notification
### SBATCH --mail-user=aponsero@email.arizona.edu
### REQUIRED. Set the partition for your job.
#SBATCH --partition=standard
### REQUIRED. Set the number of cores that will be used for this job.
#SBATCH --ntasks=20
### REQUIRED. Set the memory required for this job.
#SBATCH --mem=268gb
### REQUIRED. Specify the time required for this job, hhh:mm:ss
#SBATCH --time=72:00:00
#SBATCH -e dada2-%j.err
#SBATCH -o dada2-%j.out


source ~/.bashrc
source activate dada2
cd /xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_scripts/16S_dada2

Rscript 1_FilterTrim.R

Rscript 2_FilterError.R

Rscript 3_mergeTax.R

