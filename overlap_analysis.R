# Compact Area Overlap analysis — tidyverse + sf + terra
# Packages: tidyverse, sf, terra (optional local fallback: same paths under data/)
#
# Config -------------------------------------------------------------------
# After you push this folder to GitHub, set GITHUB_REPO once (or edit the default below).
repo   <- Sys.getenv("GITHUB_REPO", unset = "charles-patrick-lavin/md-mpa-area-overlap")
ref    <- Sys.getenv("GITHUB_REF",  unset = "main")                 # branch or tag
outdir <- Sys.getenv("OVERLAP_OUTDIR", unset = "output")
# Package root OR .../data — both work (script always looks under data/)
local_root <- Sys.getenv("OVERLAP_LOCAL_DATA", unset = "")
if (identical(repo, "YOUR_USER/YOUR_REPO") || !nzchar(repo)) {
  stop("Set Sys.setenv(GITHUB_REPO='user/repo') or edit the default `repo` at the top of this script.")
}

# Layer inventory (Area Overlap vectors; each GPKG should have a `sublayer` column)
layers <- c(
  verneplan_oppstart          = "verneplan_oppstart.gpkg",
  verneplan_ikke_oppstart     = "verneplan_ikke_oppstart.gpkg",
  naturtyper_hb19             = "naturtyper_hb19_study_area.gpkg",
  stromrike                   = "stromrike.gpkg",
  wave_exposed_coastline      = "wave_exposed_coastline.gpkg",
  fjords_ryfylke              = "fjord_sf_Ryfylke_intersects.gpkg",
  fjords_nordvestlandet       = "fjord_sf_Nordvestlandet_intersects.gpkg",
  fjords_nordland             = "fjord_sf_Nordland_intersects.gpkg",
  fjords_skagerrak            = "fjord_sf_Skagerrak_intersects.gpkg",
  liste_c_fjords              = "Liste_C_fjords.gpkg",
  fishing_spawning            = "fishing_spawning.gpkg",
  svos                        = "svos.gpkg",
  vmes                        = "vmes.gpkg"
)
layer_labels <- c(
  verneplan_oppstart = "Verneplan - oppstart",
  verneplan_ikke_oppstart = "Verneplan - ikke oppstart",
  naturtyper_hb19 = "Marine naturtyper HB19",
  stromrike = "Stromrike",
  wave_exposed_coastline = "Wave Exposed Coastline",
  fjords_ryfylke = "Fjords - Ryfylke",
  fjords_nordvestlandet = "Fjords - Nordvestlandet",
  fjords_nordland = "Fjords - Nordland",
  fjords_skagerrak = "Fjords - Skagerrak",
  liste_c_fjords = "Liste C - fjords",
  fishing_spawning = "Fishing spawning",
  svos = "SVOs",
  vmes = "VMEs"
)

# ---------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(tidyverse)
  library(sf)
  library(terra)
})
sf_use_s2(FALSE)
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

use_local <- nzchar(local_root)
if (use_local) {
  local_root <- normalizePath(local_root, winslash = "/", mustWork = TRUE)
  # Accept either package root or the data/ folder
  if (basename(local_root) == "data" && dir.exists(file.path(dirname(local_root), "data"))) {
    local_root <- dirname(local_root)
  }
  raw_base <- local_root
} else {
  raw_base <- sprintf("https://raw.githubusercontent.com/%s/%s", repo, ref)
}

path_or_url <- function(...) {
  parts <- c(...)
  if (use_local) {
    do.call(file.path, as.list(c(raw_base, parts)))
  } else {
    # GDAL /vsicurl/ makes remote GeoPackage + GeoTIFF reads reliable
    paste0("/vsicurl/", paste(c(raw_base, parts), collapse = "/"))
  }
}

read_vec <- function(rel) {
  u <- path_or_url("data", "layers", rel)
  message("Reading ", u)
  x <- st_read(u, quiet = TRUE)
  if (!"sublayer" %in% names(x)) x$sublayer <- "(all)"
  x$sublayer <- as.character(x$sublayer)
  st_make_valid(x) |> (\(z) z[!st_is_empty(z), , drop = FALSE])()
}

to_mask <- function(x, tpl) {
  if (inherits(x, "SpatRaster")) return(ifel(x, 1, NA))
  if (is.null(x) || nrow(x) == 0) return(rast(tpl) * NA)
  x <- st_transform(st_sf(geometry = st_geometry(x), crs = st_crs(x)), crs(tpl))
  rasterize(vect(x), tpl, touches = TRUE, background = NA)
}
km2_area  <- function(m, km2) { v <- global(km2 * ifel(!is.na(m), 1, NA), "sum", na.rm = TRUE)[1, 1]; if (is.na(v)) 0 else v }
km2_inter <- function(a, b, km2) { v <- global(km2 * ifel(!is.na(a) & !is.na(b), 1, NA), "sum", na.rm = TRUE)[1, 1]; if (is.na(v)) 0 else v }
props_one <- function(m, refs, rank, km2) {
  a <- km2_area(m, km2)
  tibble(
    layer_area_km2 = a,
    established_MPAs = if (a == 0) NA_real_ else km2_inter(m, refs$established_MPAs, km2) / a,
    proposed_MPAs    = if (a == 0) NA_real_ else km2_inter(m, refs$proposed_MPAs, km2) / a,
    top_30           = if (a == 0) NA_real_ else km2_inter(m, refs$top_30, km2) / a,
    top_10           = if (a == 0) NA_real_ else km2_inter(m, refs$top_10, km2) / a,
    CAZ_NA           = if (a == 0) NA_real_ else {
      v <- global(km2 * ifel(!is.na(m) & is.na(rank), 1, NA), "sum", na.rm = TRUE)[1, 1]
      (if (is.na(v)) 0 else v) / a
    }
  )
}

# Reference stack -----------------------------------------------------------
message("Loading reference rasters...")
rank <- rast(path_or_url("data", "reference", "caz_rank.tif"))
sa   <- st_read(path_or_url("data", "reference", "study_area.gpkg"), quiet = TRUE)
rank <- mask(rank, vect(st_transform(st_make_valid(sa), crs(rank))), touches = TRUE)
km2  <- cellSize(rank, unit = "km")

# Prefer precomputed MPA masks when present; else build from vector layers
est_path <- path_or_url("data", "reference", "established_mpa_mask.tif")
prop_path <- path_or_url("data", "reference", "proposed_mpa_mask.tif")
refs <- list(
  established_MPAs = if (use_local && file.exists(est_path)) {
    rast(est_path)
  } else {
    tryCatch(rast(est_path), error = function(e) {
      to_mask(read_vec("verneplan_oppstart.gpkg"), rank)
    })
  },
  proposed_MPAs = if (use_local && file.exists(prop_path)) {
    rast(prop_path)
  } else {
    tryCatch(rast(prop_path), error = function(e) {
      to_mask(read_vec("verneplan_ikke_oppstart.gpkg"), rank)
    })
  },
  top_30 = ifel(rank >= 0.7, 1, NA),
  top_10 = ifel(rank >= 0.9, 1, NA)
)

# Overlap all layers × sublayers -------------------------------------------
overlap_layer <- function(id) {
  lab <- unname(layer_labels[[id]])
  x <- read_vec(unname(layers[[id]]))
  map_dfr(sort(unique(x$sublayer)), function(s) {
    message("  ", lab, " / ", s)
    m <- to_mask(x[x$sublayer == s, , drop = FALSE], rank)
    bind_cols(tibble(layer = lab, sublayer = s), props_one(m, refs, rank, km2))
  })
}

message("Running overlaps...")
results <- imap_dfr(layers, ~ overlap_layer(.y))
out_csv <- file.path(outdir, "overlap_sublayers_vs_four_columns.csv")
write_excel_csv(results, out_csv)
message("Wrote ", nrow(results), " rows → ", normalizePath(out_csv, winslash = "/"))
