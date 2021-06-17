library(dada2); packageVersion("dada2")


# File parsing
filtpath <- "input/filtered"

filtFs <- list.files(filtpath, pattern="_F_filt.fastq.gz", full.names = TRUE)
filtRs <- list.files(filtpath, pattern="_R_filt.fastq.gz", full.names = TRUE)
sample.names <- sapply(strsplit(basename(filtFs), "_F_filt"), `[`, 1)

names(filtFs) <- sample.names
names(filtRs) <- sample.names

set.seed(100)
# Learn forward error rates
errF <- learnErrors(filtFs, nbases=1e8, multithread=TRUE)
# Learn reverse error rates
errR <- learnErrors(filtRs, nbases=1e8, multithread=TRUE)
# Sample inference and merger of paired-end reads
mergers <- vector("list", length(sample.names))
names(mergers) <- sample.names
for(sam in sample.names) {
  cat("Processing:", sam, "\n")
    derepF <- derepFastq(filtFs[[sam]])
    ddF <- dada(derepF, err=errF, multithread=TRUE)
    derepR <- derepFastq(filtRs[[sam]])
    ddR <- dada(derepR, err=errR, multithread=TRUE)
    merger <- mergePairs(ddF, derepF, ddR, derepR)
    mergers[[sam]] <- merger
}
rm(derepF); rm(derepR)
# Construct sequence table and remove chimeras
seqtab <- makeSequenceTable(mergers)
saveRDS(seqtab, "input/seqtab.rds")

# print statistics
getN <- function(x) sum(getUniques(x))
out <- cbind(sapply(mergers, getN))
colnames(out) <- c("merged")
write.table(out, "input/stats_merge.tsv", sep="\t", quote=F, col.names=NA)


