#' Plot Yield by Capture
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE'
#' by the annual interval capture probability.
#'
#' @inheritParams ypr_tabulate_sr
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yields}}
#' @export
#' @examples
#' ypr_plot_yield(ypr_population())
ypr_plot_yield <- function(object, ...) {
  UseMethod("ypr_plot_yield")
}

#' Plot Population Schedule
#'
#' @param x The population to plot.
#' @inheritParams graphics::plot.default
#' @param ... Additional arguments passed to graphics::plot.formula functions.
#' @return An invisible copy of the original object.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_schedule}}
#' @export
#' @examples
#' \dontrun{
#' plot(ypr_population())
#' }
plot.ypr_population <- function(x, type = "b", ...) {
  check_population(x)

  schedule <- ypr_schedule(x)

  with(schedule, {
    plot(Length ~ Age, xlim = c(0, max(Age)), ylim = c(0, max(Length)),
         type = type, ...)
    plot(Weight ~ Length, xlim = c(0, max(Length)), ylim = c(0, max(Weight)),
         type = type, ...)
    plot(Fecundity ~ Length, xlim = c(0, max(Length)), ylim = c(0, max(Fecundity)),
         type = type, ...)
    plot(Spawning ~ Length, xlim = c(0, max(Length)), ylim = c(0, 1),
         type = type, ...)
    plot(Vulnerability ~ Length, xlim = c(0, max(Length)), ylim = c(0, 1),
         type = type, ...)
    plot(NaturalMortality ~ Length, xlim = c(0, max(Length)), ylim = c(0,1),
         type = type, ...)
    plot(FishingMortality ~ Length, xlim = c(0, max(Length)), ylim = c(0,1),
         type = type, ...)
    plot(Survivorship ~ Age, xlim = c(0, max(Age)), ylim = c(0,1),
         type = type, ...)
    plot(FishedSurvivorship ~ Age, xlim = c(0, max(Age)), ylim = c(0,1),
         type = type, ...)
  })
  invisible(x)
}

#' Plot Population Schedule Terms
#'
#' Produces a bivariate line plot of two schedule terms.
#'
#' @inheritParams ypr_schedule
#' @param x A string of the term on the x-axis.
#' @param y A string of the term on the y-axis.
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_schedule}}
#' @export
#' @examples
#' ypr_plot_schedule(ypr_population())
ypr_plot_schedule <- function(population, x = "Age", y = "Length") {
  schedule <- ypr_schedule(population = population)

  check_scalar(x, values = colnames(schedule))
  check_scalar(y, values = colnames(schedule))

  ggplot(data = schedule, aes_string(x = x, y = y)) +
    geom_line() +
    expand_limits(x = 0, y = 0)
}

#' Plot Fish
#'
#' Produces a frequency histogram of the number of fish in the
#' 'Surviving', 'Spawning', 'Caught', 'Harvested' or 'Released' categories by
#' 'Length', 'Age' or 'Weight' class.
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_plot_schedule
#' @inheritParams ypr_tabulate_fish
#' @param color A string of the color around each bar (or NULL).
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_population}} and \code{\link[ggplot2]{geom_histogram}}
#' @export
#' @examples
#' ypr_plot_fish(ypr_population(), color = "white")
ypr_plot_fish <- function(population, x = "Age", y = "Surviving",
                          binwidth = 1L, color = NULL) {
  check_scalar(y, c("Surviving", "Spawning", "Caught", "Harvested",
                    "Released", "HandlingMortality"))

  fish <- ypr_tabulate_fish(population, x = x, binwidth = binwidth)

  ggplot(data = fish, aes_string(x = x, weight = y)) +
    (if(is.null(color)) geom_bar(width = binwidth) else
      geom_bar(width = binwidth, color = color)) +
    ylab(y) +
    expand_limits(x = 0, y = 0)
}

#' Plot Stock-Recruitment Curve
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @param plot_values A flag indicating whether to plot the actual and optimal values.
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_sr}}
#' @export
#' @examples
#' ypr_plot_sr(ypr_population(Rk = 10))
#' ypr_plot_sr(ypr_population(Rk = 10, BH = 0L))
ypr_plot_sr <- function(population, Ly = 0, harvest = TRUE, biomass = FALSE, plot_values = TRUE) {
  check_yield_parameters(population, Ly, harvest, biomass)
  check_flag(plot_values)
  schedule <- ypr_schedule(population)

  schedule <- as.list(schedule)
  schedule$BH <- population$BH
  schedule$Rmax <-population$Rmax
  schedule <- c(schedule, sr(schedule, population))

  data <- with(schedule, {
    data <- data.frame(Eggs = seq(0, to = phi * R0 * 2, length.out = 100))
    fun <- if(BH == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data
  })

  data2 <- ypr_tabulate_sr(population, Ly = Ly, harvest = harvest, biomass = biomass)
  data2$Type <- factor(data2$Type, levels = c("actual", "optimal", "unfished"))
  data2 <- rbind(data2, data2, data2)
  data2$Recruits[1:3] <- 0
  data2$Eggs[7:9] <- 0

  ggplot(data = data, aes_string(x = "Eggs", y = "Recruits")) +
    (
      if(plot_values)
        geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted")
      else NULL
    ) +
    geom_line() +
    expand_limits(x = 0, y = 0) +
    scale_x_continuous(labels = scales::comma) +
    scale_color_manual(values = c("red", "blue", "black")) +
    NULL
}

#' Plot Yield by Exploitation/Capture Probability
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE'
#' by the annual interval exploitation/capture probability.
#'
#' @inheritParams ypr_tabulate_sr
#' @inheritParams ypr_plot_schedule
#' @inheritParams ypr_yield
#' @inheritParams ypr_yields
#' @param u A flag indicating whether to plot the exploitation rate as opposed to the capture rate.
#' @inheritParams ypr_plot_sr
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yields}}
#' @export
#' @examples
#' ypr_plot_yield(ypr_population())
ypr_plot_yield.ypr_population <- function(object, y = "Yield", pi = seq(0, 1, length.out = 100),
                                          Ly = 0, harvest = TRUE, biomass = FALSE,
                                          u = harvest, plot_values = TRUE, ...) {
  check_yield_parameters(object, Ly, harvest, biomass)

  check_scalar(y, values = c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  check_flag(u)

  data <- ypr_tabulate_yields(object, pi = pi, Ly = Ly, harvest = harvest,
                              biomass = biomass)

  data2 <- ypr_tabulate_yield(object = object, Ly = Ly, harvest = harvest, biomass = biomass)

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  data1 <- data2
  data3 <- data2

  data1[c("Yield", "Age", "Length", "Weight", "Effort", "YPUE")] <- 0
  data3[c("pi", "u")] <- 0

  data2 <- rbind(data1, data2, data3, stringsAsFactors = FALSE)

  xlab <- if(u) "Exploitation Probability (%)" else "Capture Probability (%)"
  x <- if(u) "u" else "pi"

  ggplot(data = data, aes_string(x = x, y = y)) +
    (
      if(plot_values)
        list(
          geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted"),
          scale_color_manual(values = c("red", "blue"))
        )
      else NULL
    ) +
    geom_line() +
    expand_limits(x = 0) +
    scale_x_continuous(xlab, labels = scales::percent) +
    NULL
}

#' Plot Yield by Exploitation/Capture Probability
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE'
#' by the annual interval exploitation/capture probability.
#'
#' @inheritParams ypr_tabulate_sr
#' @inheritParams ypr_plot_schedule
#' @inheritParams ypr_yield
#' @inheritParams ypr_yields
#' @param u A flag indicating whether to plot the exploitation rate as opposed to the capture rate.
#' @inheritParams ypr_plot_sr
#' @return A ggplot2 object.
#' @seealso \code{\link{ypr_populations}} and \code{\link{ypr_yields}}
#' @export
#' @examples
#' \dontrun{
#' ypr_plot_yield(ypr_populations(Rk = c(2.5, 4.6), Llo = c(0, 60)), plot_values = FALSE) +
#'   ggplot2::facet_wrap(~Llo) +
#'   ggplot2::aes_string(group = "Rk", color = "Rk") +
#'   ggplot2::scale_color_manual(values = c("black", "blue"))
#'
#' ypr_plot_yield(ypr_populations(Rk = c(2.5, 4.6), Llo = c(0, 60))) +
#'   ggplot2::facet_grid(Rk~Llo)
#'  }
ypr_plot_yield.ypr_populations <- function(
  object, y = "Yield", pi = seq(0, 1, length.out = 100),
  Ly = 0, harvest = TRUE, biomass = FALSE, u = harvest, plot_values = TRUE, ...) {

  check_scalar(y, values = c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  check_flag(u)

  data <- ypr_tabulate_yields(object, pi = pi, Ly = Ly, harvest = harvest,
                              biomass = biomass)

  data2 <- ypr_tabulate_yield(object = object, Ly = Ly, harvest = harvest, biomass = biomass)

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  parameters <- setdiff(intersect(colnames(data), .parameters$Parameter), "pi")

  for(parameter in parameters) {
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

  xlab <- if(u) "Exploitation Probability (%)" else "Capture Probability (%)"
  x <- if(u) "u" else "pi"

  ggplot(data = data, aes_string(x = x, y = y)) +
    (
      if(plot_values)
        list(
          geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted"),
          scale_color_manual(values = c("red", "blue"))
        )
      else NULL
    ) +
    geom_line() +
    expand_limits(x = 0) +
    scale_x_continuous(xlab, labels = scales::percent) +
    NULL
}
