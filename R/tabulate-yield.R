#' Tabulate Yield
#'
#' @inheritParams params
#'
#' @return A data frame.
#' @family tabulate
#' @family populations
#' @family yield
#' @export
#' @examples
#' ypr_tabulate_yield(ypr_population())
#' ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)))
ypr_tabulate_yield <- function(object, ...) {
  UseMethod("ypr_tabulate_yield")
}

#' @describeIn ypr_tabulate_yield Tabulate Yield
#' @export
ypr_tabulate_yield.default <- function(object,
                                              Ly = 0,
                                              harvest = TRUE,
                                              biomass = FALSE,
                                              type = "both",
                                              all = FALSE,
                                              ...) {
  chkor_vld(vld_is(object, "ypr_population"), vld_is(object, "ypr_ecotypes"))
  chk_string(type)
  chk_subset(type, c("both", "actual", "optimal"))

  actual_pi <- ypr_get_par(object)

  actual_yield <- ypr_yield(object,
    Ly = Ly, harvest = harvest,
    biomass = biomass
  )

  if (type == "actual") {
    yield <- data.frame(
      Type = "actual",
      pi = actual_pi,
      u = ypr_exploitation(object, actual_pi),
      Yield = actual_yield,
      Age = attr(actual_yield, "Age"),
      Length = attr(actual_yield, "Length"),
      Weight = attr(actual_yield, "Weight"),
      Effort = attr(actual_yield, "Effort"),
      stringsAsFactors = FALSE
    )
  } else {
    optimal_pi <- ypr_optimize(object,
      Ly = Ly, harvest = harvest,
      biomass = biomass
    )

    object <- ypr_update(object, pi = optimal_pi)

    optimal_yield <- ypr_yield(object,
      Ly = Ly, harvest = harvest,
      biomass = biomass
    )
    yield <- data.frame(
      Type = c("actual", "optimal"),
      pi = c(actual_pi, optimal_pi),
      u = ypr_exploitation(object, c(actual_pi, optimal_pi)),
      Yield = c(actual_yield, optimal_yield),
      Age = c(attr(actual_yield, "Age"), attr(optimal_yield, "Age")),
      Length = c(attr(actual_yield, "Length"), attr(optimal_yield, "Length")),
      Weight = c(attr(actual_yield, "Weight"), attr(optimal_yield, "Weight")),
      Effort = c(attr(actual_yield, "Effort"), attr(optimal_yield, "Effort")),
      stringsAsFactors = FALSE
    )

    if (type == "optimal") {
      yield <- yield[yield$Type == "optimal", ]
    }
  }

  if (all) yield <- add_parameters(yield, object)

  as_tibble(yield)
}

#' @describeIn ypr_tabulate_yield Tabulate Yield
#' @export
ypr_tabulate_yield.ypr_populations <- function(object,
                                               Ly = 0,
                                               harvest = TRUE,
                                               biomass = FALSE,
                                               type = "both",
                                               all = FALSE,
                                               ...) {
  chk_flag(all)

  yield <- lapply(object, ypr_tabulate_yield,
    Ly = Ly, harvest = harvest,
    biomass = biomass, type = type, all = TRUE, ...
  )

  yield <- do.call("rbind", yield)

  if (!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}
