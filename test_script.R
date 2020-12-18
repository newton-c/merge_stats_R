#devtools::install_github("newton-c/merge_stats_R")
#library(merge.stats)
source("R/merge_stats.R")

dat.1 <- read.csv("~/Desktop/code_translations_r_package/ucdp-dyadic-201.csv")
dat.2 <- read.csv("~/Desktop/code_translations_r_package/ucdp-prio-acd-201.csv")

#dat.2$merge.y <- 3

merge_df <- merge_stats(dat.1, dat.2, by = c("conflict_id", "year"),
                        show.stats = T)
print(colnames(merge_df))
rm(list = ls())
