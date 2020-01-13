#' Coerce to a Population Parameter Object
#'
#' @param x The object to coerce.
#' @param ... Unused.
#' @export
#'
#' @examples
#' as_ypr_population(as.data.frame(ypr_population()))
as_ypr_population <- function(x, ...) UseMethod("as_ypr_population")

#' @describeIn as_ypr_population Coerce data frame to ypr_population
#' @export
as_ypr_population.data.frame <- function(x, ...) {
  chk_unused(...)
  do.call("ypr_population", x)
}
