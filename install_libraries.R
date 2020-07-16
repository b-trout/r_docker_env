lapply(
  read.csv("lib_names.csv", header = FALSE, stringsAsFactors = FALSE),
  remotes::install_cran,
  dependencies = TRUE,
  upgrade = "always"
)
