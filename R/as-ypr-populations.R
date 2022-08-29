#' Coerce to a Populations Object
#'
#' @param x The object to coerce.
#' @param ... Unused.
#' @return An object of class ypr_ecotypes.
#' @family populations
#' @export
as_ypr_populations <- function(x, ...) {
  UseMethod("as_ypr_populations")
}

#' @describeIn as_ypr_population Coerce a data.frame to a Populations Object
#'
#' @export
#' @examples
#' as_ypr_populations(as.data.frame(ypr_populations(Rk = c(3, 4))))
as_ypr_populations.data.frame <- function(x, ...) {
  chk_data(x)
  chk_unused(...)

  x <- split(x, seq_len(nrow(x)))
  x <- lapply(x, as_ypr_population)
  class(x) <- "ypr_populations"
  names(x) <- ypr_names(x)
  x
}

#' @describeIn as_ypr_populations Coerce a Population Object to an Population Object
#'
#' @export
#' @examples
#' as_ypr_populations(ypr_population())
as_ypr_populations.ypr_population <- function(x, ...) {
  check_population(x)
  chk_unused(...)

  x <- list(x)
  class(x) <- "ypr_populations"
  names(x) <- ypr_names(x)
  x
}

#' @describeIn as_ypr_populations Coerce a Populations Object of length 1 to a Population Object
#'
#' @export
#' @examples
#' as_ypr_populations(ypr_populations())
as_ypr_populations.ypr_populations <- function(x, ...) {
  check_populations(x)
  chk_unused(...)

  x
}

#' @describeIn as_ypr_populations Coerce a Ecotypes Object of length 1 to a Population Object
#'
#' @export
#' @examples
#' as_ypr_populations(ypr_ecotypes())
as_ypr_populations.ypr_ecotypes <- function(x, ...) {
  check_ecotypes(x)
  chk_unused(...)

  class(x) <- "ypr_populations"
  x
}
