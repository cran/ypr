optimize <- function(object, Ly, harvest, biomass) {
  stats::optimize(yield_pi, c(0, 1),
    object = object,
    Ly = Ly, harvest = harvest, biomass = biomass,
    maximum = TRUE
  )$maximum
}

#' Optimize Capture
#'
#' Finds the interval annual capture probability (pi) that maximises the yield
#' for a given population.
#'
#' @inheritParams params
#' @return The interval annual capture probability (pi) that maximises the
#'   yield.
#' @family calculate
#' @aliases ypr_optimise
#' @export
#' @examples
#' ypr_optimize(ypr_population())
ypr_optimize <- function(object,
                         Ly = 0,
                         harvest = TRUE,
                         biomass = FALSE) {
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)

  yield <- optimize(
    object = object, Ly = Ly,
    harvest = harvest, biomass = biomass
  )
  sanitize(yield)
}

#' @export
ypr_optimise <- ypr_optimize
