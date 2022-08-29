#' Tabulate Stock-Recruitment Parameters
#'
#' @inheritParams params
#' @return A data.frame of stock-recruitment parameters.
#' @family tabulate
#' @family populations
#' @family sr
#' @export
#' @examples
#' ypr_tabulate_sr(ypr_population()) # Beverton-Holt
#' ypr_tabulate_sr(ypr_population(BH = 0L)) # Ricker
#' ypr_tabulate_sr(ypr_populations(Rk = c(2.5, 4.6)))
ypr_tabulate_sr <- function(object, ...) {
  UseMethod("ypr_tabulate_sr")
}

#' @describeIn ypr_tabulate_sr Tabulate Stock-Recruitment Parameters
#' @export
ypr_tabulate_sr.default <- function(object, Ly = 0, harvest = TRUE,
                                           biomass = FALSE, all = FALSE, ...) {

  chkor_vld(vld_is(object, "ypr_population"), vld_is(object, "ypr_ecotypes"))

  sr <- ypr_sr(object)
  sr$BH <- ypr_get_par(object, "BH")

  pi <- ypr_get_par(object)

  object_pi <- ypr_optimise(
    object,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )
  object <- set_par(object, "pi", object_pi)
  optimal_sr <- ypr_sr(object)

  table <- with(sr, {
    data <- data.frame(
      Type = c("unfished", "actual", "optimal"),
      pi = c(0, pi, object_pi),
      u = ypr_exploitation(object, c(0, pi, object_pi)),
      Eggs = c(phi * R0, phiF * R0F, optimal_sr$phiF * optimal_sr$R0F),
      stringsAsFactors = FALSE
    )
    fun <- if (only(BH) == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data$Spawners <- c(S0, S0F, optimal_sr$S0F)
    data$Fecundity <- data$Eggs / data$Spawners * 2
    data
  })

  if (all) table <- add_parameters(table, object)

  as_tibble(table)
}

#' @describeIn ypr_tabulate_sr Tabulate Stock-Recruitment Parameters
#' @export
ypr_tabulate_sr.ypr_populations <- function(object,
                                            Ly = 0,
                                            harvest = TRUE,
                                            biomass = FALSE,
                                            all = FALSE, ...) {
  chk_flag(all)

  sr <- lapply(object, ypr_tabulate_sr,
               Ly = Ly, harvest = harvest,
               biomass = biomass, all = TRUE, ...
  )

  sr <- do.call("rbind", sr)

  if (!all) sr <- drop_constant_parameters(sr)

  as_tibble(sr)
}
