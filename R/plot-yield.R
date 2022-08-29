#' Plot Yield by Capture
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE' by the
#' annual interval capture/exploitation probability.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @family populations
#' @family yield
#' @family plot
#' @examples
#' \dontrun{
#' ypr_plot_yield(ypr_populations(
#'   Rk = c(2.5, 4.6),
#'   Llo = c(0, 60)
#' ),
#' plot_values = FALSE
#' ) +
#'   ggplot2::facet_wrap(~Llo) +
#'   ggplot2::aes_string(group = "Rk", color = "Rk") +
#'   ggplot2::scale_color_manual(values = c("black", "blue"))
#'
#' ypr_plot_yield(ypr_populations(Rk = c(2.5, 4.6), Llo = c(0, 60))) +
#'   ggplot2::facet_grid(Rk ~ Llo)
#' }
#'
#' ypr_plot_yield(ypr_population())
#' @export
#'
ypr_plot_yield <- function(object, ...) {
  UseMethod("ypr_plot_yield")
}

#' @describeIn ypr_plot_yield Plot Yield by Capture
#' @export
ypr_plot_yield.default <- function(object,
                                          y = "Yield",
                                          pi = seq(0, 1, length.out = 100),
                                          Ly = 0,
                                          harvest = TRUE,
                                          biomass = FALSE,
                                          u = harvest,
                                          plot_values = TRUE,
                                          ...) {
  chkor_vld(vld_is(object, "ypr_population"), vld_is(object, "ypr_ecotypes"))

  if (!requireNamespace("ggplot2")) err("Package 'ggplot2' must be installed.")
  if (!requireNamespace("scales")) err("Package 'scales' must be installed.")
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)

  chk_string(y)
  chk_subset(y, c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  chk_flag(u)

  data <- ypr_tabulate_yields(
    object,
    pi = pi,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )

  data2 <- ypr_tabulate_yield(
    object = object,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  data1 <- data2
  data3 <- data2

  data1[c("Yield", "Age", "Length", "Weight", "Effort", "YPUE")] <- 0
  data3[c("pi", "u")] <- 0

  data2 <- rbind(data1, data2, data3, stringsAsFactors = FALSE)

  xlab <- if (u) "Exploitation Probability (%)" else "Capture Probability (%)"
  x <- if (u) "u" else "pi"

  ggplot2::ggplot(data = data, ggplot2::aes_string(x = x, y = y)) +
    (
      if (plot_values) {
        list(
          ggplot2::geom_path(
            data = data2,
            ggplot2::aes_string(
              group = "Type",
              color = "Type"
            ),
            linetype = "dotted"
          ),
          ggplot2::scale_color_manual(values = c("red", "blue"))
        )
      } else {
        NULL
      }) +
    ggplot2::geom_line() +
    ggplot2::expand_limits(x = 0) +
    ggplot2::scale_x_continuous(xlab, labels = scales::percent) +
    NULL
}

#' @describeIn ypr_plot_yield Plot Yield by Capture
#' @export
ypr_plot_yield.ypr_populations <- function(object,
                                           y = "Yield",
                                           pi = seq(0, 1, length.out = 100),
                                           Ly = 0,
                                           harvest = TRUE,
                                           biomass = FALSE,
                                           u = harvest,
                                           plot_values = TRUE,
                                           ...) {
  if (!requireNamespace("ggplot2")) err("Package 'ggplot2' must be installed.")
  if (!requireNamespace("scales")) err("Package 'scales' must be installed.")
  chk_string(y)
  chk_subset(y, c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  chk_flag(u)

  data <- ypr_tabulate_yields(object,
                              pi = pi, Ly = Ly, harvest = harvest,
                              biomass = biomass
  )

  data2 <- ypr_tabulate_yield(
    object = object,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  parameters <- setdiff(intersect(colnames(data), parameters()), "pi")

  for (parameter in parameters) {
    data[[parameter]] <- factor(
      paste0(parameter, ": ", data[[parameter]]),
      levels = unique(paste0(parameter, ": ", sort(data[[parameter]])))
    )
    data2[[parameter]] <- factor(
      paste0(parameter, ": ", data2[[parameter]]),
      levels = unique(paste0(parameter, ": ", sort(data2[[parameter]])))
    )
  }

  data1 <- data2
  data3 <- data2

  data1[c("Yield", "Age", "Length", "Weight", "Effort", "YPUE")] <- 0
  data3[c("pi", "u")] <- 0

  data2 <- rbind(data1, data2, data3, stringsAsFactors = FALSE)

  xlab <- if (u) "Exploitation Probability (%)" else "Capture Probability (%)"
  x <- if (u) "u" else "pi"

  ggplot2::ggplot(data = data, ggplot2::aes_string(x = x, y = y)) +
    (
      if (plot_values) {
        list(
          ggplot2::geom_path(
            data = data2,
            ggplot2::aes_string(
              group = "Type",
              color = "Type"
            ),
            linetype = "dotted"
          ),
          ggplot2::scale_color_manual(values = c("red", "blue"))
        )
      } else {
        NULL
      }) +
    ggplot2::geom_line() +
    ggplot2::expand_limits(x = 0) +
    ggplot2::scale_x_continuous(xlab, labels = scales::percent) +
    NULL
}
