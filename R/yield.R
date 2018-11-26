yield <- function(schedule, population, Ly = 0, harvest = TRUE, biomass = FALSE) {
  schedule <- as.list(schedule)

  schedule$pi <- population$pi
  schedule$q <- population$q

  schedule <- c(schedule, sr(schedule, population))

  yield <- with(schedule, {
    FishedSurvivorship[Length < Ly] <- 0
    yield <- R0F * FishedSurvivorship * Vulnerability * pi
    if(harvest) yield <- yield * Retention
    age <- weighted.mean(Age, yield)
    length <- weighted.mean(Length, yield)
    weight <- weighted.mean(Weight, yield)
    effort <- log(1-pi) / log(1-q)
    if(biomass)
      yield <- yield * Weight / 1000
    yield <- sum(yield)
    if(yield <= 0) {
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

yield_pi <- function(pi, population, Ly, harvest, biomass) {
  population$pi <- pi
  schedule <- ypr_schedule(population)
  yield(schedule, population, Ly = Ly, harvest = harvest, biomass = biomass)
}

#' Yield
#'
#' Calculates the yield for a population.
#'
#' By default, with \code{Rmax = 1} the number of individuals is the proportion of the recruits at the carrying capacity.
#' If the yield is given in terms of the biomass (kg) then the scaling also depends on the value of \code{Wa} (g).
#'
#' @inheritParams ypr_schedule
#' @param Ly The minimum length (trophy) fish to consider when calculating the yield.
#' @param harvest A flag indicating whether to calculate the yield for harvested fish or captures.
#' @param biomass A flag indicating whether to calculate the yield in terms of the biomass versus number of individuals.
#' @return The yield as number of fish or biomass.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_optimize}}
#' @export
#' @examples
#' ypr_yield(ypr_population())
ypr_yield <- function(population, Ly = 0, harvest = TRUE, biomass = FALSE) {
  check_yield_parameters(population, Ly, harvest, biomass)

  schedule <- ypr_schedule(population)

  yield <- yield(schedule, population, Ly = Ly, harvest = harvest, biomass = biomass)

  sanitize(yield)
}
