# Data inventory — Area Overlap package

All paths relative to `github_overlap_package/data/`.

## `layers/` (analysis vectors — prefer GeoPackage)

| File | Shiny layer label | `sublayer` source | Approx. size |
|------|-------------------|-------------------|--------------|
| `vmes.gpkg` | VMEs | shapefile basename | ~0.3 MB |
| `fishing_spawning.gpkg` | Fishing spawning | Gytefelt / Kysttorsk | ~42 MB |
| `svos.gpkg` | SVOs | `art_latin \| kart_eng` | ~29 MB |
| `verneplan_oppstart.gpkg` | Verneplan - oppstart | `navn_omr` | small |
| `verneplan_ikke_oppstart.gpkg` | Verneplan - ikke oppstart | `navn_omr` | small |
| `naturtyper_hb19_study_area.gpkg` | Marine naturtyper HB19 | `naturtype` | ~23 MB |
| `stromrike.gpkg` | Stromrike | `RegType` | ~0.5 MB |
| `wave_exposed_coastline.gpkg` | Wave Exposed Coastline | `RegType` | ~30 MB |
| `Liste_C_fjords.gpkg` | Liste C - fjords | `navn` | ~0.8 MB |
| `fjord_sf_Ryfylke_intersects.gpkg` | Fjords - Ryfylke | `navn` | ~0.7 MB |
| `fjord_sf_Nordvestlandet_intersects.gpkg` | Fjords - Nordvestlandet | `navn` | ~6 MB |
| `fjord_sf_Nordland_intersects.gpkg` | Fjords - Nordland | `navn` | ~13 MB |
| `fjord_sf_Skagerrak_intersects.gpkg` | Fjords - Skagerrak | `navn` | ~6 MB |

Maritime boundary **line** layers (territorialgrense / grunnlinje) are used
for mapping in the shiny app but are optional for the four-column area overlap
CSV; omit unless regenerating those two rows.

## `reference/` (masks & study area)

| File | Role |
|------|------|
| `caz_rank.tif` | CAZ rank raster (masked to study area in script) |
| `study_area.gpkg` | MPA kandidatområder study area |
| `established_mpa_mask.tif` | Established MPA mask (optional shortcut) |
| `proposed_mpa_mask.tif` | Proposed MPA mask (optional shortcut) |
| `mpa_top10.tif` | Top 10% mask (optional; script can rebuild as rank ≥ 0.9) |
| `mpa_masked.tif` | Deploy CAZ masked to study area (optional) |
| `marin_vp_*.shp` (+ sidecars) | Source shapefiles if present (superseded by gpkgs in `layers/`) |

## Root

| File | Role |
|------|------|
| `overlap_sublayers_vs_four_columns.csv` | Current results used by the shiny Area Overlap tab |

## Optional `rasters/` (not bundled by default)

Copy from `shiny_app/data/Bio_Oracle/masks/` if regenerating Chlorophyll /
Primary production / Sea ice CSV rows (~24 MB total).

## Example raw URLs

```
https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/data/layers/vmes.gpkg
https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/data/reference/caz_rank.tif
https://raw.githubusercontent.com/YOUR_USER/YOUR_REPO/main/data/overlap_sublayers_vs_four_columns.csv
```

Release-asset alternative (large files):

```r
# piggyback::pb_download("fishing_spawning.gpkg", repo = "YOUR_USER/YOUR_REPO", tag = "v1")
```
