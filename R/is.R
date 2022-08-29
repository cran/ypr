#' Tests if is a Population, Populations or Ecotypes
#' @param x The object to test.
#' @export
#' @examples
#' is.ypr_population(ypr_population())
is.ypr_population <- function(x) {
  is_ypr_population(x)
}

#' @describeIn is.ypr_population Test if is a Population
#' @export
#' @examples
#' is_ypr_population(ypr_population())
is_ypr_population <- function(x) {
  inherits(x, "ypr_population")
}

#' @describeIn is.ypr_population Test if is a Populations
#' @export
#' @examples
#' is.ypr_populations(ypr_populations())
is.ypr_populations <- function(x) {
  is_ypr_populations(x)
}

#' @describeIn is.ypr_population Test if is a Populations
#' @export
#' @examples
#' is_ypr_population(ypr_populations())
is_ypr_populations <- function(x) {
  inherits(x, "ypr_populations")
}

#' @describeIn is.ypr_population Test if is an Ecotypes
#' @export
#' @examples
#' is.ypr_ecotypes(ypr_ecotypes())
is.ypr_ecotypes <- function(x) {
  is_ypr_ecotypes(x)
}

#' @describeIn is.ypr_population Test if is an Ecotypes
#' @export
#' @examples
#' is_ypr_ecotypes(ypr_ecotypes())
is_ypr_ecotypes <- function(x) {
  inherits(x, "ypr_ecotypes")
}
