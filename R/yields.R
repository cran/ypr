#' Yields
#'
#' Calculates the yield(s) for a population based on one or more capture rates.
#'
#' @param pi A vector of probabilities of capture to calculate the yield for.
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @seealso \code{\link{ypr_yield}}
#' @return A numeric vector of the yields.
#' @export
#' @examples
#' pi <- seq(0, 1, length.out = 30)
#' plot(pi, ypr_yields(ypr_population(), pi), type = "l")
ypr_yields <- function(population, pi = seq(0, 1, length.out = 100),
                       Ly = 0, harvest = TRUE, biomass = FALSE) {

  check_yield_parameters(population, Ly, harvest, biomass)
  check_vector(pi, c(0, 1), length = TRUE)

  yields <- vapply(pi, FUN = yield_pi, FUN.VALUE = 1,
                   population = population, Ly = Ly, harvest = harvest,
                   biomass = biomass)
  sanitize(yields)
}
