get_prop <- function(x) {
  x <- ypr_get_par(x, "RPR")
  x / sum(x)
}
