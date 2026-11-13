# Data inventory - Area Overlap package

All paths relative to `github_overlap_package/data/`.

## `layers/` (analysis vectors - prefer GeoPackage)

| File | Shiny layer label | `sublayer` source | Notes |
|------|-------------------|-------------------|-------|
| `vmes.gpkg` | VMEs | VME class / basename | |
| `fishing_spawning.gpkg` | Fishing spawning | Kyst / Hav / Arktis | |
| `svos_by_group.gpkg` | SVOs by group | `group \| kart_eng` | |
| `svo_omrader.gpkg` | SVO Omraader | SVO area name | |
| `seabirds.gpkg` | Seabirds | species | seasonal top-10% union |
| `coastal_habitats.gpkg` | Coastal habitats | Type / Name nest | HB19 + Stromrike + Wave exposed coastline |
| `existing_protection.gpkg` | Existing protection | Type (incl. OECM anbefaling 2026) | |
| `proposed_protection.gpkg` | Proposed protection | Type / Name | |
| `liste_a.gpkg` | Liste A | area name | |
| `liste_c_fjords.gpkg` | Liste C | `navn` | |
| `fjords.gpkg` | Fjords | Region / Fjord nest | merged Ryfylke, Nordvestlandet, Nordland, Skagerrak |
| `seamounts.gpkg` | Seamounts | | |
| `seasonally_ice_covered_areas.gpkg` | Seasonally ice-covered areas | | |
| `territorialgrense.gpkg` | Maritime grenser - territorialgrense | line | mapping |
| `grunnlinje.gpkg` | Maritime grenser - grunnlinje | line | mapping |

Legacy split fjord region files, standalone OECM / verneplan / HB19 / Stromrike /
wave-exposed / SVOs parent layers were removed; use the merged layers above
(`fjords.gpkg`, `coastal_habitats.gpkg`, `existing_protection.gpkg`,
`svos_by_group.gpkg` / `svo_omrader.gpkg`).

## `reference/` (masks & study area)

| File | Role |
|------|------|
| `caz_rank.tif` | CAZ rank raster (masked to study area in script) |
| `study_area.gpkg` | MPA kandidatomraader study area |
| `established_mpa_mask.tif` | Established MPA mask (optional shortcut) |
| `proposed_mpa_mask.tif` | Proposed MPA mask (optional shortcut) |
| `mpa_top10.tif` | Top 10% mask (optional; script can rebuild as rank >= 0.9) |
| `mpa_masked.tif` | Deploy CAZ masked to study area (optional) |

## Root

| File | Role |
|------|------|
| `overlap_sublayers_vs_four_columns.csv` | Current results used by the shiny Area Overlap tab |

## `carbon/` (Area Overlap raster)

| File | Role |
|------|------|
| `carbon_average_top10.tif` | Carbon `average` band, top 10% values (CAZ-aligned) |
| `carbon_average_top10_mask.tif` | Binary presence mask for overlap / violin |
| `carbon_average_top10_display.tif` | Map display (continuous top-10% values) |

Source: `Results_September_2026/carbon_map_log_cog.tif` -> `average` -> p90 threshold.

## `Bio_Oracle/masks/` (Chlorophyll / Primary production / Sea ice)

Analysis masks and display rasters for Area Overlap Bio-Oracle layers
(~24 MB; 23 mask + 23 display GeoTIFFs). Groups: `chl_p90`, `phyc_p90`, `siconc`.

## Example raw URLs

```
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/layers/vmes.gpkg
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/reference/caz_rank.tif
https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/data/overlap_sublayers_vs_four_columns.csv
```

Release-asset alternative (large files):

```r
# piggyback::pb_download("fishing_spawning.gpkg", repo = "charles-patrick-lavin/md-mpa-area-overlap", tag = "v1")
```
