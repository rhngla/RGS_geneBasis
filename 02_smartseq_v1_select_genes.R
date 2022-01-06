library(geneBasisR)
library(SingleCellExperiment)
library(feather)

df <- read.csv("/Users/fruity/Local/datasets/RGS/smartseq_v1_raw.csv", header = TRUE, sep = ",")
cols = colnames(df)
genes <- cols[2:254]
samples <- df$sample

counts <- t(as.matrix(df[, genes]))
colnames(counts) <- samples
rownames(counts) <- genes

rm(df)
sce <- SingleCellExperiment(list(logcounts =  log2(counts + 1)))
rm('counts', 'cols', 'genes', 'samples')

# Track elapsed time for each experiment
time_df <- data.frame (n_genes  = 0, time = 0)

for (n_genes in c(196)) {
    fname <-
        paste0("/Users/fruity/Local/datasets/RGS/smartseq_v1_gene_list_",
               n_genes,
               ".feather")
    startt <- Sys.time()
    gene_list = gene_search(sce, n_genes_total = n_genes)
    write_feather(gene_list, fname)
    elapsed_time <- Sys.time() - startt
    time_df[nrow(time_df) + 1,] <- c(n_genes, elapsed_time)
    print(time_df)
}
write_feather(time_df, "/Users/fruity/Local/datasets/RGS/smartseq_v1_elapsed_time.feather")