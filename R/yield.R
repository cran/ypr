yield <- function(schedule,
                  object,
                  Ly = 0,
                  harvest = TRUE,
                  biomass = FALSE) {
  schedule <- as.list(schedule)

  schedule$pi <- ypr_get_par(object)
  schedule$q <- ypr_get_par(object, "q")
  schedule <- c(schedule, sr(schedule, object))

  yield <- with(schedule, {
    FishedSurvivorship[Length < Ly] <- 0
    yield <- R0F * FishedSurvivorship * Vulnerability * pi
    if (harvest) yield <- yield * Retention
    age <- weighted.mean(Age, yield)
    length <- weighted.mean(Length, yield)
    weight <- weighted.mean(Weight, yield)
    effort <- log(1 - pi) / log(1 - q)
    if (biomass) {
      yield <- yield * Weight / 1000
    }
    yield <- sum(yield)
    if (yield <= 0) {
      age <- NA
      length <- NA
      weight <- NA
    }
    attr(yield, "Age") <- age
    attr(yield, "Length") <- length
    attr(yield, "Weight") <- weight
    attr(yield, "Effort") <- effort

    yield
  })
  yield
}

yield_pi <- function(pi, object, Ly, harvest, biomass) {
  object <- set_par(object, "pi", pi)
  schedule <- ypr_tabulate_schedule(object)
  yield(schedule, object, Ly = Ly, harvest = harvest, biomass = biomass)
}

#' Yield
#'
#' Calculates the yield for a population.
#'
#' By default, with `Rmax = 1` the number of individuals is the proportion of
#' the recruits at the carrying capacity. If the yield is given in terms of the
#' biomass (kg) then the scaling also depends on the value of `Wa` (g).
#'
#' @inheritParams params
#' @return The yield as number of fish or biomass.
#' @family yield
#' @family calculate
#' @export
#' @examples
#' ypr_yield(ypr_population())
#' ypr_yield(ypr_ecotypes(Linf = c(100, 200)))
ypr_yield <- function(object,
                      Ly = 0,
                      harvest = TRUE,
                      biomass = FALSE,
                      ...) {
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)

  schedule <- ypr_tabulate_schedule(object)

  yield <- yield(
    schedule,
    object,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )

  sanitize(yield)
}
