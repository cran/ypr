#' Tabulate Yields
#'
#' @inheritParams params
#'
#' @return A data frame.
#' @family tabulate
#' @family populations
#' @export
#' @examples
#' ypr_tabulate_yields(ypr_population())
#' ypr_tabulate_yields(
#'   ypr_populations(
#'     Rk = c(3, 5)
#'   ),
#'   pi = seq(0, 1, length.out = 10)
#' )
#' ypr_tabulate_yields(ypr_ecotypes(Linf = c(10, 20)))
ypr_tabulate_yields <- function(object, ...) {
  UseMethod("ypr_tabulate_yields")
}

#' @describeIn ypr_tabulate_yields Tabulate Yields
#' @export
ypr_tabulate_yields.default <- function(object,
                                               pi = seq(0, 1, length.out = 100),
                                               Ly = 0,
                                               harvest = TRUE,
                                               biomass = FALSE,
                                               all = FALSE,
                                               ...) {

  chkor_vld(vld_is(object, "ypr_population"), vld_is(object, "ypr_ecotypes"))

  chk_number(Ly)
  chk_numeric(pi)
  chk_not_empty(pi)
  chk_not_any_na(pi)
  chk_range(pi, c(0, 1))

  yields <- lapply(pi, tabulate_yield_pi,
                   object = object, Ly = Ly,
                   harvest = harvest, biomass = biomass, all = all
  )

  yields <- do.call(rbind, yields)

  as_tibble(yields)
}

#' @describeIn ypr_tabulate_yields Tabulate Yields
#' @export
ypr_tabulate_yields.ypr_populations <- function(object,
                                                pi = seq(0, 1, length.out = 100),
                                                Ly = 0,
                                                harvest = TRUE,
                                                biomass = FALSE,
                                                all = FALSE,
                                                ...) {
  chk_flag(all)

  yield <- lapply(object, ypr_tabulate_yields,
                  pi = pi, Ly = Ly, harvest = harvest,
                  biomass = biomass, all = TRUE, ...
  )

  yield <- do.call("rbind", yield)

  if (!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}
