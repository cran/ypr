optimize <- function(population, Ly, harvest, biomass) {
  stats::optimize(yield_pi, c(0, 1), population = population,
                           Ly = Ly, harvest = harvest, biomass = biomass,
                           maximum = TRUE)$maximum
}

#' Optimize Capture
#'
#' Finds the interval annual capture probability (pi) that maximises the yield for a given population.
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @return The interval annual capture probability (pi) that maximises the yield.
#' @aliases ypr_optimise
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yield}}
#' @export
#' @examples
#' ypr_optimize(ypr_population())
ypr_optimize <- function(population,
                         Ly = 0, harvest = TRUE, biomass = FALSE) {
  check_yield_parameters(population, Ly, harvest, biomass)

  yield <- optimize(population = population, Ly = Ly,
                       harvest = harvest, biomass = biomass)
  sanitize(yield)
}

#' @export
ypr_optimise <- ypr_optimize
