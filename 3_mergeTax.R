library(dada2); packageVersion("dada2")

# Merge multiple runs (if necessary)
st.all <- readRDS("input/seqtab.rds")

# Remove chimeras
seqtab <- removeBimeraDenovo(st.all, method="consensus", multithread=TRUE)
saveRDS(seqtab, "input/seqtab_final.rds")

# Assign taxonomy
tax <- assignTaxonomy(seqtab, "database/RefSeq-RDP16S_v2_May2018.fa.gz", multithread=TRUE)
# Write to disk
saveRDS(tax, "input/tax_RefSeqMay2018.rds")

taxa.print <- tax # Removing sequence rownames for display only
rownames(taxa.print) <- NULL

#save taxa table 
write.table(taxa.print, "input/tax_RefSeqMay2018.tsv", sep="\t", quote=F, col.names=NA)

out <- cbind(rowSums(seqtab))
colnames(out) <- c("no_chimera")
write.table(out, "input/stats_chimera.tsv", sep="\t", quote=F, col.names=NA)


