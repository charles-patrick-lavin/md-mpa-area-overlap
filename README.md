# MDir MPA — Area Overlap analysis (GitHub data package)

Compact, reproducible Area Overlap runner for the MDir MPA Norge work.
Loads all Area Overlap vector layers + reference masks from this repository
and writes `overlap_sublayers_vs_four_columns.csv`.

**Default repo name used by the script:** `charles-patrick-lavin/md-mpa-area-overlap`  
(Change the name below if you create a different repository.)

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

## 1. Create the GitHub repository and upload (one-time)

### Option A — GitHub website + Git (simplest on Windows)

1. Open https://github.com/new  
2. Owner: **charles-patrick-lavin**  
3. Repository name: **md-mpa-area-overlap** (or another name — then update `GITHUB_REPO` / script default)  
4. Visibility: **Public** (needed for raw URLs without a token) or Private (then use a PAT / local data fallback)  
5. Do **not** add a README / .gitignore / license on GitHub (this folder already has them)  
6. Click **Create repository**

7. In PowerShell:

```powershell
cd "C:\Users\CPL\OneDrive - NIVA\2025\MD_Anbud_2025\github_overlap_package"

git init
git add README.md overlap_analysis.R .gitignore data/
git commit -m "Add Area Overlap analysis package (vectors + reference masks)"
git branch -M main
git remote add origin https://github.com/charles-patrick-lavin/md-mpa-area-overlap.git
git push -u origin main
```

When Git asks you to sign in, use the browser / GitHub credential helper.

### Option B — GitHub CLI (`gh`)

```powershell
winget install --id GitHub.cli -e
# restart PowerShell, then:
gh auth login

cd "C:\Users\CPL\OneDrive - NIVA\2025\MD_Anbud_2025\github_overlap_package"
git init
git add README.md overlap_analysis.R .gitignore data/
git commit -m "Add Area Overlap analysis package (vectors + reference masks)"
git branch -M main
gh repo create md-mpa-area-overlap --public --source=. --remote=origin --push
```

### Large files

Largest GeoPackages are ~30–42 MB (under GitHub’s 100 MB hard limit).
If you later add files >100 MB, use Git LFS or GitHub Releases + `piggyback`.

---

## 2. Run the analysis (user-ready)

### From GitHub (after push)

```r
# Optional if you used the default repo name already baked into the script:
# Sys.setenv(GITHUB_REPO = "charles-patrick-lavin/md-mpa-area-overlap")
Sys.setenv(GITHUB_REF = "main")
Sys.setenv(OVERLAP_OUTDIR = "output")

# Download/copy overlap_analysis.R, then:
source("overlap_analysis.R")
```

Or one-liner from raw URL (after the repo is public):

```r
Sys.setenv(GITHUB_REPO = "charles-patrick-lavin/md-mpa-area-overlap")
source("https://raw.githubusercontent.com/charles-patrick-lavin/md-mpa-area-overlap/main/overlap_analysis.R")
```

First remote run downloads GeoPackages via GDAL `/vsicurl/` — expect several minutes.

### Offline / local test (no GitHub needed)

```r
Sys.setenv(
  OVERLAP_LOCAL_DATA = "C:/Users/CPL/OneDrive - NIVA/2025/MD_Anbud_2025/github_overlap_package/data",
  OVERLAP_OUTDIR = "C:/Users/CPL/OneDrive - NIVA/2025/MD_Anbud_2025/github_overlap_package/output"
)
source("C:/Users/CPL/OneDrive - NIVA/2025/MD_Anbud_2025/github_overlap_package/overlap_analysis.R")
```

Output: `output/overlap_sublayers_vs_four_columns.csv`

---

## 3. VMEs

Layer label: **VMEs**  
Sublayers: `Glass_sponge_community`, `Hard_bottom_coral_garden`,
`Hard_bottom_sponge_garden`, `Radicipes`, `Sponge_spicule_bottom`,
`Umbellula_stands`  
File: `data/layers/vmes.gpkg`

---

## 4. Sharing with colleagues

1. Repo must be **public**, or they need a GitHub token / local clone.  
2. Point them at this README + the one-liner `source("https://raw.githubusercontent.com/...")`.  
3. Or: `git clone https://github.com/charles-patrick-lavin/md-mpa-area-overlap.git` and use `OVERLAP_LOCAL_DATA`.

## Do not

- Commit shinyapps tokens or `.Renviron` secrets into this package.
