library(dada2); packageVersion("dada2")
library(tidyverse)


# list of directory to assess
path <- "input"

# directory with unziped fastq
list.files(path)

# Forward and reverse fastq filenames 
fnFs <- sort(list.files(path, pattern="R1.fastq.gz", full.names = TRUE))
fnRs <- sort(list.files(path, pattern="R2.fastq.gz", full.names = TRUE))
# Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq
sample.names <- sapply(strsplit(basename(fnFs), "_R"), `[`, 1)

# Place filtered files in filtered/ subdirectory
filtFs <- file.path(path, "filtered", paste0(sample.names, "_F_filt.fastq.gz"))
filtRs <- file.path(path, "filtered", paste0(sample.names, "_R_filt.fastq.gz"))

names(filtFs) <- sample.names
names(filtRs) <- sample.names

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, truncLen=240, trimLeft = c(17,21),
                     maxN=0, maxEE=c(2,2), truncQ=2, rm.phix=TRUE,
                     compress=TRUE, multithread=TRUE)

#out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, orient.fwd="CCTACGGG",
#                     truncLen=240, trimLeft = c(17,21), matchIDs=TRUE,
#                     maxN=0, maxEE=c(1,1), truncQ=10, rm.phix=TRUE,
#                     compress=TRUE, multithread=TRUE, verbose = TRUE)



write.table(out, "input/stats_filter.tsv", sep="\t", quote=F, col.names=NA)


