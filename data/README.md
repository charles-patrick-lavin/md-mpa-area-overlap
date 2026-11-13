# Data inventory - Area Overlap package

All paths relative to `github_overlap_package/data/`.
Trimmed to files needed for the Shiny Area Overlap app and the compact overlap script.

## `layers/` (analysis vectors - GeoPackage)

| File | Shiny layer label | Notes |
|------|-------------------|-------|
| `vmes.gpkg` | VMEs | |
| `fishing_spawning.gpkg` | Fishing spawning | |
| `svos_by_group.gpkg` | SVOs by group | |
| `svo_omrader.gpkg` | SVO Omraader | |
| `seabirds.gpkg` | Seabirds | |
| `coastal_habitats.gpkg` | Coastal habitats | HB19 + Stromrike + Wave exposed coastline |
| `existing_protection.gpkg` | Existing protection | includes OECM anbefaling 2026 |
| `proposed_protection.gpkg` | Proposed protection | |
| `liste_a.gpkg` | Liste A | |
| `liste_c_fjords.gpkg` | Liste C | |
| `fjords.gpkg` | Fjords | merged regions |
| `seamounts.gpkg` | Seamounts | |
| `seasonally_ice_covered_areas.gpkg` | Seasonally ice-covered areas | |
| `territorialgrense.gpkg` | Maritime grenser - territorialgrense | line |
| `grunnlinje.gpkg` | Maritime grenser - grunnlinje | line |

## `reference/` (CAZ + study area + MPA masks)

| File | Role |
|------|------|
| `caz_rank.tif` | **CAZ rank raster** (main Zonation surface) |
| `mpa_masked.tif` | CAZ masked to study area (Shiny deploy) |
| `mpa_top10.tif` | Top 10% mask (rank >= 0.9) |
| `study_area.gpkg` | Study area polygon |
| `established_mpa_mask.tif` | Established MPA mask |
| `proposed_mpa_mask.tif` | Proposed MPA mask |

## `Bio_Oracle/masks/` (Mean surface chlorophyll only)

Only the two Shiny Chlorophyll layers (mask + display each):

| File | Role |
|------|------|
| `chl_p90__chl_baseline_2000_2018_depthsurf_chl_mean_p90top_mask.tif` | Current surface Mean chl-a top 10% |
| `chl_p90__chl_baseline_2000_2018_depthsurf_chl_mean_p90top_display.tif` | Map display |
| `chl_p90__chl_ssp585_2020_2100_depthsurf_chl_mean_p90top_mask.tif` | Future SSP585 surface Mean chl-a top 10% |
| `chl_p90__chl_ssp585_2020_2100_depthsurf_chl_mean_p90top_display.tif` | Map display |

## `carbon/`

| File | Role |
|------|------|
| `carbon_average_top10.tif` | Carbon average top 10% values |
| `carbon_average_top10_mask.tif` | Presence mask |
| `carbon_average_top10_display.tif` | Map display |

## `future_biodiversity/`

| File | Role |
|------|------|
| `future_richness_top10_mask.tif` / `_display.tif` | Future richness top 10% |
| `alpha_delta_positive_top10_mask.tif` / `_display.tif` | Positive alpha-delta top 10% |

## Root

| File | Role |
|------|------|
| `overlap_sublayers_vs_four_columns.csv` | Precomputed Area Overlap table used by Shiny |

## Example URLs

```
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/reference/caz_rank.tif
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/layers/fjords.gpkg
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/overlap_sublayers_vs_four_columns.csv
```
