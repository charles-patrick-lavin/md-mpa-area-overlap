# MDir MPA — Area Overlap analysis (GitHub data package)

Compact, reproducible Area Overlap runner for the MDir MPA Norge work.
Loads all Area Overlap vector layers + reference masks from this repository
and writes `overlap_sublayers_vs_four_columns.csv`.

**Default repo name used by the script:** `charles-patrick-lavin/md-mpa-area-overlap`  


## Contents

| Path | Role |
|------|------|
| `overlap_analysis.R` | Compact tidyverse + sf + terra overlap script |
| `data/layers/*.gpkg` | All Area Overlap vector themes (`sublayer` column) |
| `data/reference/` | CAZ rank, study area, MPA masks |
| `data/overlap_sublayers_vs_four_columns.csv` | Current shiny-app results (incl. 6 VMEs) |

## Required R packages

```r
install.packages(c("tidyverse", "sf", "terra"))
```

---

