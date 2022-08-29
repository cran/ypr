#' Update a YPR Object
#' Currently just works with scalar parameters for populations and ecotypes.
#'
#' @param x A population, populations or ecotypes object to update.
#' @param ... One or more parameter values from `ypr_population()`.
#' @export
ypr_update <- function(x, ...) {
  UseMethod("ypr_update")
}

#' @export
update.ypr_population <- function(object, ...) {
  ypr_update(object, ...)
}

#' @export
update.ypr_populations <- function(object, ...) {
  ypr_update(object, ...)
}

#' @export
update.ypr_ecotypes <- function(object, ...) {
  ypr_update(object, ...)
}

#' @describeIn ypr_update Update Population Parameters
#'
#' @export
#' @examples
#' ypr_update(ypr_population(), Rk = 2.5)
ypr_update.ypr_population <- function(x, ...) {
  parameters <- list(...)
  x[names(parameters)] <- unname(parameters)
  check_population(x)
  x
}

#' @describeIn ypr_update Update Populations Parameters
#'
#' @export
#' @examples
#' ypr_update(ypr_populations(Rk = c(2.5, 4)), Rk = 2.5)
ypr_update.ypr_populations <- function(x, ...) {
  x <- lapply(x, ypr_update, ...)
  class(x) <- "ypr_populations"
  names(x) <- ypr_names(x)
  x
}

#' @describeIn ypr_update Update Populations Parameters
#'
#' @export
#' @examples
#' ypr_update(ypr_ecotypes(Linf = c(2.5, 4)), k = 1.5)
ypr_update.ypr_ecotypes <- function(x, ...) {
  x <- lapply(x, ypr_update, ...)
  class(x) <- "ypr_ecotypes"
  names(x) <- ypr_names(x)
  check_ecotypes(x)
  x
}
