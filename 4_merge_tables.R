library(tidyverse)
library(dada2); packageVersion("dada2")


######################
# merge ASV counts
#####################

HiSeq4_count <- as_tibble(t(read_rds("input/HiSeq4_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

HiSeq5_count <- as_tibble(t(read_rds("input/HiSeq5_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

HiSeq6_count <- as_tibble(t(read_rds("input/HiSeq6_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

HiSeq7_count <- as_tibble(t(read_rds("input/HiSeq7_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

HiSeq8p1_count <- as_tibble(t(read_rds("input/HiSeq8p1_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

HiSeq8p2_count <- as_tibble(t(read_rds("input/HiSeq8p2_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq13_count <- as_tibble(t(read_rds("input/MiSeq13_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq28_count <- as_tibble(t(read_rds("input/MiSeq28_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq29_count <- as_tibble(t(read_rds("input/MiSeq29_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq31_count <- as_tibble(t(read_rds("input/MiSeq31_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq32_count <- as_tibble(t(read_rds("input/MiSeq32_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq33_count <- as_tibble(t(read_rds("input/MiSeq33_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq34_count <- as_tibble(t(read_rds("input/MiSeq34_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq35_count <- as_tibble(t(read_rds("input/MiSeq35_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq36_count <- as_tibble(t(read_rds("input/MiSeq36_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq37_count <- as_tibble(t(read_rds("input/MiSeq37_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq38_count <- as_tibble(t(read_rds("input/MiSeq38_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

MiSeq39_count <- as_tibble(t(read_rds("input/MiSeq39_seqtab_final.rds")), rownames=NA) %>%
  tibble::rownames_to_column("ASV") 

# divide in two tables for memory requirements
merge_count <- full_join(HiSeq4_count, HiSeq5_count)
merge_count <- full_join(merge_count, HiSeq7_count)
merge_count <- full_join(merge_count, HiSeq8p1_count)
merge_count <- full_join(merge_count, HiSeq8p2_count)
merge_count <- full_join(merge_count, HiSeq6_count)
#
merge_count2 <- full_join(MiSeq13_count, MiSeq29_count)
merge_count2 <- full_join(merge_count2, MiSeq31_count)
merge_count2 <- full_join(merge_count2, MiSeq31_count)
merge_count2 <- full_join(merge_count2, MiSeq32_count)
merge_count2 <- full_join(merge_count2, MiSeq33_count)
merge_count2 <- full_join(merge_count2, MiSeq34_count)
merge_count2 <- full_join(merge_count2, MiSeq35_count)
merge_count2 <- full_join(merge_count2, MiSeq36_count)
merge_count2 <- full_join(merge_count2, MiSeq37_count)
merge_count2 <- full_join(merge_count2, MiSeq38_count)
merge_count2 <- full_join(merge_count2, MiSeq39_count)

merge_count[is.na(merge_count)] = 0
merge_count2[is.na(merge_count2)] = 0
write_csv(merge_count, "HiSeq_counts.csv")
write_csv(merge_count2, "MiSeq_counts.csv")

merge_count <- remove_rownames(merge_count)
sequences <- merge_count %>% select(ASV)

merge_count2 <- remove_rownames(merge_count2)
sequences2 <- merge_count2 %>% select(ASV)

all_ASV <- full_join(sequences2,sequences)

write_csv(all_ASV, "ASV_sequences.csv")









