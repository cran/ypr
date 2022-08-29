#' @export
unique.ypr_populations <- function(x, ...) {
  x <- as.data.frame(x)
  x <- unique(x)
  as_ypr_populations(x)
}
