# MDir MPA - Area Overlap analysis (GitHub data package)

Compact Area Overlap data + runner for the MDir MPA Norge work.
Trimmed to inputs needed by the Shiny Area Overlap app and `overlap_analysis.R`.

**Repo:** `charles-patrick-lavin/md-mpa-area-overlap`

## Contents

| Path | Role |
|------|------|
| `overlap_analysis.R` | Compact tidyverse + sf + terra overlap script |
| `data/layers/*.gpkg` | Area Overlap vectors |
| `data/reference/` | **CAZ rank** (`caz_rank.tif`), study area, MPA masks |
| `data/Bio_Oracle/masks/` | Surface Mean chl-a current + SSP585 (mask + display) |
| `data/carbon/` | Carbon average top-10% GeoTIFFs |
| `data/future_biodiversity/` | Future richness / alpha-delta top-10% GeoTIFFs |
| `data/overlap_sublayers_vs_four_columns.csv` | Precomputed Area Overlap results for Shiny |
| `data/README.md` | Full data inventory |

## Required R packages

```r
install.packages(c("tidyverse", "sf", "terra"))
```
