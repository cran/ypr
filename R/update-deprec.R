#' Update a Population Object
#'
#' `r lifecycle::badge('deprecated')` for [`ypr_update()`].
#'
#' @param population A ypr_population object.
#' @param ... One or more parameter values from `ypr_population()`.
#'
#' @export
ypr_population_update <- function(population, ...) {
  lifecycle::deprecate_soft(" 0.5.3", "ypr_population_update()", "ypr_update()")
  check_population(population)
  ypr_update(population, ...)
}
