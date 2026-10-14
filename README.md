# MDir MPA — Area Overlap analysis (GitHub data package)

Compact, reproducible Area Overlap runner for the MDir MPA Norge work.
Loads all Area Overlap vector layers + reference masks from this repository
and writes `overlap_sublayers_vs_four_columns.csv`.

**Default repo name used by the script:** `charles-patrick-lavin/md-mpa-area-overlap`  


## Contents

| Path | Role |
|------|------|
| `overlap_analysis.R` | Compact tidyverse + sf + terra overlap script |
| `data/layers/*.gpkg` | Area Overlap vectors (`sublayer` column), incl. VMEs, Fishing spawning, SVOs (202 features), SVOs by group, **Seabirds** (44 species) |
| `data/carbon/` | **Carbon** average top-10% GeoTIFFs (values + mask + display) |
| `data/reference/` | CAZ rank, study area, MPA masks |
| `data/overlap_sublayers_vs_four_columns.csv` | Current Area Overlap results (incl. Carbon, Seabirds, SVOs, VMEs, …) |
| `data/svo_redlist_flags.csv` | Lookup of red-list flags by layer/sublayer |
| `data/redlist_svo_overlap.csv` | Red-list species ↔ SVO overlap summary |
| `data/redlist_seabirds_moved_to_svo.csv` | Seabirds removed from Species Occurrence red-list analysis |
| `data/seabirds_seasonal_top10_inventory.csv` | Per-species seasonal top-10% cell counts |

## Required R packages

```r
install.packages(c("tidyverse", "sf", "terra"))
```

---

