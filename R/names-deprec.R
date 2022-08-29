#' Population Names
#'
#' Generates set of unique names based on differences in parameter values.
#' `r lifecycle::badge('deprecated')`
#' @param population An object of class ypr_population, ypr_populations or ypr_ecotypes.
#' @return A character vector of the unique parameter based names.
#' @seealso [`ypr_names()`]
#'
#' @export
ypr_population_names <- function(population) {
  lifecycle::deprecate_soft("0.5.3", "ypr_population_names()", "ypr_names()")
  ypr_names(population)
}
