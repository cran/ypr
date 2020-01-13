#' Yields
#'
#' Calculates the yield(s) for a population based on one or more capture rates.
#'
#' @inheritParams params
#' @param pi A vector of probabilities of capture to calculate the yield for.
#' @seealso [ypr_yield()]
#' @return A numeric vector of the yields.
#' @export
#' @examples
#' pi <- seq(0, 1, length.out = 30)
#' plot(pi, ypr_yields(ypr_population(), pi), type = "l")
ypr_yields <- function(population, pi = seq(0, 1, length.out = 100),
                       Ly = 0, harvest = TRUE, biomass = FALSE) {
  chk_population(population)
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)
  chk_numeric(pi)
  chk_not_empty(pi)
  chk_not_any_na(pi)
  chk_range(pi, c(0, 1))

  yields <- vapply(pi,
    FUN = yield_pi, FUN.VALUE = 1,
    population = population, Ly = Ly, harvest = harvest,
    biomass = biomass
  )
  sanitize(yields)
}
