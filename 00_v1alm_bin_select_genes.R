library(geneBasisR)
library(SingleCellExperiment)
library(feather)

df <- read_feather("/Users/fruity/Local/datasets/RGS/v1alm_neuronal_raw.feather")
cols = colnames(df)
genes <- cols[2:10001]
samples <- df$X

counts <- t(as.matrix(df[, genes]))
counts[counts>0] = 1.0
colnames(counts) <- samples
rownames(counts) <- genes

rm(df)
sce <- SingleCellExperiment(list(logcounts = counts))
rm('counts', 'cols', 'genes', 'samples')

# Track elapsed time for each experiment
time_df <- data.frame (n_genes  = 0, time = 0)

for (n_genes in c(256)) {
    fname <-
        paste0("/Users/fruity/Local/datasets/RGS/v1alm_bin_gene_list_",
               n_genes,
               ".feather")
    startt <- Sys.time()
    gene_list = gene_search(sce, n_genes_total = n_genes)
    write_feather(gene_list, fname)
    elapsed_time <- Sys.time() - startt
    time_df[nrow(time_df) + 1,] <- c(n_genes, elapsed_time)
    print(time_df)
}
write_feather(time_df, "/Users/fruity/Local/datasets/RGS/v1alm_bin_elapsed_time.feather")