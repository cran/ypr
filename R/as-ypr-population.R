#' Coerce to a Population Object
#'
#' @param x The object to coerce.
#' @param ... Unused.
#' @return An object of class ypr_population.
#' @family population
#' @export
as_ypr_population <- function(x, ...) {
  UseMethod("as_ypr_population")
}

#' @describeIn as_ypr_population Coerce a data.frame to an Population Object
#'
#' @export
#' @examples
#' as_ypr_population(as.data.frame(ypr_population()))
as_ypr_population.data.frame <- function(x, ...) {
  chk_data(x)
  chk_unused(...)

  do.call("ypr_population", x)
}

#' @describeIn as_ypr_population Coerce a Population Object to an Population Object
#'
#' @export
#' @examples
#' as_ypr_population(ypr_populations())
as_ypr_population.ypr_population <- function(x, ...) {
  check_population(x)
  chk_unused(...)

  x
}

#' @describeIn as_ypr_population Coerce a Populations Object of length 1 to a Population Object
#'
#' @export
#' @examples
#' as_ypr_population(ypr_populations())
as_ypr_population.ypr_populations <- function(x, ...) {
  chk_list(x)
  chk_unused(...)

  check_dim(x, dim = length, values = 1L)
  x <- check_population(x[[1]])
  x
}

#' @describeIn as_ypr_population Coerce a Ecotypes Object of length 1 to a Population Object
#'
#' @export
#' @examples
#' as_ypr_population(ypr_ecotypes())
as_ypr_population.ypr_ecotypes <- function(x, ...) {
  chk_list(x)
  chk_unused(...)

  check_dim(x, dim = length, values = 1L)
  x <- check_population(x[[1]])
  x
}
