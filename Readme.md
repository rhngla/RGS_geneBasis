
### Environment:
`Tidyverse` is available through Base.

Installed R packages:
```R

install.packages(c("usethis","devtools","remotes","tidyverse"))
BiocManager::install("SingleCellExperiment")
devtools::install_github("MarioniLab/geneBasisR")
devtools::install_github("wesm/feather/R")
```

### Procedure:
1. Raw csv converted to feather format for quick read access:
```R
library(feather)
df <- read.csv(csv_name, header = TRUE, sep = ",")
write_feather(df, feather_name)
```
2. Individual scripts show the settings under which gene selections were obtained.
3. Gene selections are available in the `/data/` folder. 