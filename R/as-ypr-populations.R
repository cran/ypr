#' Coerce to a Populations Parameter Object
#'
#' @param x The object to coerce.
#' @param ... Unused.
#' @export
#'
#' @examples
#' as_ypr_populations(as.data.frame(ypr_populations(Rk = c(3, 4))))
as_ypr_populations <- function(x, ...) UseMethod("as_ypr_populations")

#' @describeIn as_ypr_populations Coerce data frame to ypr_populations
#' @export
as_ypr_populations.data.frame <- function(x, ...) {
  chk_unused(...)
  x <- split(x, 1:nrow(x))
  x <- lapply(x, as_ypr_population)
  class(x) <- "ypr_populations"
  names(x) <- ypr_population_names(x)
  x
}
