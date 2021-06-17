#!/bin/bash
#SBATCH --job-name=reassign_tax
### REQUIRED. Specify the PI group for this job
#SBATCH --account=bhurwitz
### Optional. Request email when job begins and ends
### SBATCH --mail-type=ALL
### Optional. Specify email address to use for notification
### SBATCH --mail-user=aponsero@email.arizona.edu
### REQUIRED. Set the partition for your job.
#SBATCH --partition=standard
### REQUIRED. Set the number of cores that will be used for this job.
#SBATCH --ntasks=96
### REQUIRED. Set the memory required for this job.
#SBATCH --mem=412gb
### REQUIRED. Specify the time required for this job, hhh:mm:ss
#SBATCH --time=72:00:00
#SBATCH -e dada2-%j.err
#SBATCH -o dada2-%j.out


source ~/.bashrc
source activate dada2
cd /home/u31/aponsero/scripts/16S_dada2



Rscript 4_reassign_taxonomy.R

