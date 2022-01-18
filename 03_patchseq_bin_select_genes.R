library(geneBasisR)
library(SingleCellExperiment)
library(feather)

df <- read.csv("/Users/fruity/Local/datasets/RGS/patchseq_raw_counts.csv", header = TRUE, sep = ",")
genes = colnames(df)
samples <- 1:dim(df)[1]

bincounts <- t(as.matrix(df[, genes]))
bincounts[counts>0] = 1.0
colnames(counts) <- samples
rownames(counts) <- genes

rm(df)
sce <- SingleCellExperiment(list(logcounts =  bincounts))
rm('counts', 'cols', 'genes', 'samples')

# Track elapsed time for each experiment
time_df <- data.frame (n_genes  = 0, time = 0)

for (n_genes in c(256)) {
    fname <-
        paste0("/Users/fruity/Local/datasets/RGS/patchseq_bin_gene_list_",
               n_genes,
               ".feather")
    startt <- Sys.time()
    gene_list = gene_search(sce, n_genes_total = n_genes)
    write_feather(gene_list, fname)
    elapsed_time <- Sys.time() - startt
    time_df[nrow(time_df) + 1,] <- c(n_genes, elapsed_time)
    print(time_df)
}
write_feather(time_df, "/Users/fruity/Local/datasets/RGS/patchseq_bin_elapsed_time.feather")