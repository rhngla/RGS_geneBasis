# This code verifies that geneBasis selects genes in the same order across 
# runs, and that the 'n_genes' input does not affect selection order.
import feather
df = {}
for ngenes in [256, 192 ,128 ,64 ,32 ,16 ,8]:
    df[ngenes] = feather.read_dataframe(f'v1alm_gene_list_{ngenes}.feather')


assert df[256]['gene'][:192].tolist()==df[192]['gene'].tolist(), '192'
assert df[256]['gene'][:128].tolist()==df[128]['gene'].tolist(), '128'
assert df[256]['gene'][:64].tolist()==df[64]['gene'].tolist(), '64'
assert df[256]['gene'][:32].tolist()==df[32]['gene'].tolist(), '32'
assert df[256]['gene'][:16].tolist()==df[16]['gene'].tolist(), '16'
assert df[256]['gene'][:8].tolist()==df[8]['gene'].tolist(), '8'
