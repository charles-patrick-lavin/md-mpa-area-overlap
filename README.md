# MDir MPA — Area Overlap analysis (GitHub data package)

Compact, reproducible Area Overlap runner for the MDir MPA Norge work.
Loads all Area Overlap vector layers + reference masks from this repository
and writes `overlap_sublayers_vs_four_columns.csv`.

**Default repo name used by the script:** `charles-patrick-lavin/md-mpa-area-overlap`  


## Contents

| Path | Role |
|------|------|
| `overlap_analysis.R` | Compact tidyverse + sf + terra overlap script |
| `data/layers/*.gpkg` | All Area Overlap vector themes (`sublayer` column); SVOs include `on_red_list` / seabird red-list attrs; `svos_by_group` uses Seabird / Zooplankton / Fish / … labels plus `has_red_list`, `n_red_list_species`, `red_list_species` |
| `data/reference/` | CAZ rank, study area, MPA masks |
| `data/overlap_sublayers_vs_four_columns.csv` | Current shiny-app results (incl. VMEs, SVOs by group; optional red-list flag columns) |
| `data/svo_redlist_flags.csv` | Lookup of red-list flags by layer/sublayer |
| `data/redlist_svo_overlap.csv` | Red-list species ↔ SVO overlap summary |
| `data/redlist_seabirds_moved_to_svo.csv` | Seabirds removed from Species Occurrence red-list analysis |

## Required R packages

```r
install.packages(c("tidyverse", "sf", "terra"))
```

---

