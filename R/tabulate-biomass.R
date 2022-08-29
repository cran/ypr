#' Tabulate Biomass (and Eggs)
#'
#' Produces a data frame of the 'Weight' and 'Fecundity' and the number of
#' 'Survivors' and 'Spawners' and the total 'Biomass' and 'Eggs' by 'Age' class.
#'
#' @inheritParams params
#' @return A data frame
#' @family tabulate
#' @family biomass
#' @export
#' @examples
#' ypr_tabulate_biomass(ypr_population())
ypr_tabulate_biomass <- function(population) {
  schedule <- ypr_tabulate_schedule(population)
  fish <- ypr_tabulate_fish(population)

  schedule <- schedule[c("Age", "Length", "Weight", "Fecundity")]
  fish <- fish[c("Survivors", "Spawners")]

  biomass <- cbind(schedule, fish)
  biomass$Biomass <- biomass$Weight * biomass$Survivors
  biomass$Eggs <- (biomass$Fecundity * biomass$Spawners) / 2

  as_tibble(biomass)
}
