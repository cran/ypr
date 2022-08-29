#' Coerce to an Ecotypes Object
#'
#' @param x The object to coerce.
#' @param ... Additional arguments.
#' @return An object of class ypr_ecotypes.
#' @family ecotypes
#' @export
as_ypr_ecotypes <- function(x, ...) {
  UseMethod("as_ypr_ecotypes")
}

#' @describeIn as_ypr_ecotypes Coerce a data.frame to an Ecotypes Object
#'
#' @export
#' @examples
#' as_ypr_ecotypes(as.data.frame(ypr_ecotypes(Ls = c(10, 15, 20))))
as_ypr_ecotypes.data.frame <- function(x, ...) {
  chk_data(x)
  chk_unused(...)

  x <- split(x, seq_len(nrow(x)))
  x <- lapply(x, as_ypr_population)
  class(x) <- "ypr_ecotypes"
  check_ecotypes(x)
  names(x) <- ypr_names(x)
  x
}

#' @describeIn as_ypr_ecotypes Coerce a Population Object to an Ecotypes Object
#' @export
#' @examples
#' as_ypr_ecotypes(ypr_population())
as_ypr_ecotypes.ypr_population <- function(x, ...) {
  check_population(x)
  chk_unused(...)

  x <- list(x)
  class(x) <- "ypr_ecotypes"
  names(x) <- ypr_names(x)
  x
}

#' @describeIn as_ypr_ecotypes Coerce a Populations Object to an Ecotypes Object
#'
#' @export
#' @examples
#' as_ypr_ecotypes(ypr_populations(Ls = c(10, 15, 20)))
as_ypr_ecotypes.ypr_populations <- function(x, ...) {
  check_populations(x)
  chk_unused(...)

  class(x) <- c("ypr_ecotypes")
  check_ecotypes(x)
  x
}

#' @describeIn as_ypr_ecotypes Coerce an Ecotypes Object to an Ecotypes Object
#'
#' @export
#' @examples
#' as_ypr_ecotypes(ypr_ecotypes(Ls = c(10, 15, 20)))
as_ypr_ecotypes.ypr_ecotypes <- function(x, ...) {
  check_ecotypes(x)
  chk_unused(...)

  x
}
