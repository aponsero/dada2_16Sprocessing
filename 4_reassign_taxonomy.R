library(tidyverse)
library(dada2); packageVersion("dada2")

# read ASV sequence file 
ASV <- read_csv("input/xaf")
seq <- ASV %>% pull()

# assign taxonomy
set.seed(100) # Initialize random number generator for reproducibility
tax <- assignTaxonomy(seq, "database/RefSeq-RDP16S_v2_May2018.fa.gz", multithread=TRUE)
# Write to disk
saveRDS(tax, "part6_tax_RefSeqMay2018.rds")


