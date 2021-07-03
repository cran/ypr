#' Plot Yield by Capture
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE'
#' by the annual interval capture probability.
#'
#' @inheritParams params
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ypr_yields()]
#' @export
#' @examples
#' ypr_plot_yield(ypr_population())
ypr_plot_yield <- function(object, ...) {
  UseMethod("ypr_plot_yield")
}

#' Plot Population Schedule Terms
#'
#' Produces a bivariate line plot of two schedule terms.
#'
#' @inheritParams params
#' @param x A string of the term on the x-axis.
#' @param y A string of the term on the y-axis.
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ypr_tabulate_schedule()]
#' @export
#' @examples
#' ypr_plot_schedule(ypr_population())
ypr_plot_schedule <- function(population, x = "Age", y = "Length") {
  schedule <- ypr_tabulate_schedule(population = population)

  chk_string(x)
  chk_subset(x, values = colnames(schedule))

  chk_string(y)
  chk_subset(y, values = colnames(schedule))

  labels <- if (sum(schedule[[y]]) >= 1000) {
    scales::comma
  } else {
    waiver()
  }

  ggplot(data = schedule, aes_string(x = x, y = y)) +
    geom_line() +
    scale_y_continuous(y, labels = labels) +
    expand_limits(x = 0, y = 0)
}

#' Plot Fish
#'
#' Produces a frequency histogram of the number of fish in the
#' 'Survivors', 'Spawners', 'Caught', 'Harvested' or 'Released' categories by
#' 'Length', 'Age' or 'Weight' class.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ggplot2::geom_histogram()]
#' @export
#' @examples
#' ypr_plot_fish(ypr_population(), color = "white")
ypr_plot_fish <- function(population, x = "Age", y = "Survivors",
                          percent = FALSE,
                          binwidth = 1L, color = NULL) {
  chk_string(y)
  chk_subset(y, c(
    "Survivors", "Spawners", "Caught", "Harvested",
    "Released", "HandlingMortalities"
  ))
  chk_flag(percent)

  fish <- ypr_tabulate_fish(population, x = x, binwidth = binwidth)

  if (percent) fish[[y]] <- fish[[y]] / sum(fish[[y]])
  labels <- if (percent) {
    scales::percent
  } else if (sum(fish[[y]]) >= 1000) {
    scales::comma
  } else {
    waiver()
  }

  ggplot(data = fish, aes_string(x = x, weight = y)) +
    (if (is.null(color)) {
      geom_bar(width = binwidth)
    } else {
      geom_bar(width = binwidth, color = color)
    }) +
    scale_y_continuous(y, labels = labels) +
    expand_limits(x = 0, y = 0)
}

#' Plot Biomass
#'
#' Produces a frequency histogram of the total fish 'Biomass' or 'Eggs' deposition by
#' 'Age' class.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ggplot2::geom_histogram()]
#' @export
#' @examples
#' ypr_plot_biomass(ypr_population(), color = "white")
ypr_plot_biomass <- function(population, y = "Biomass", color = NULL) {
  chk_string(y)
  chk_subset(y, c("Biomass", "Eggs"))

  biomass <- ypr_tabulate_biomass(population)

  labels <- if (sum(biomass[[y]]) >= 1000) {
    scales::comma
  } else {
    waiver()
  }

  ggplot(data = biomass, aes_string(x = "Age", weight = y)) +
    (if (is.null(color)) {
      geom_bar(width = 1)
    } else {
      geom_bar(width = 1, color = color)
    }) +
    scale_y_continuous(y, labels = labels) +
    expand_limits(x = 0, y = 0)
}

#' Plot Stock-Recruitment Curve
#'
#' @inheritParams params
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ypr_sr()]
#' @export
#' @examples
#' ypr_plot_sr(ypr_population(Rk = 10))
#' ypr_plot_sr(ypr_population(Rk = 10, BH = 0L))
ypr_plot_sr <- function(population, Ly = 0, harvest = TRUE, biomass = FALSE, plot_values = TRUE) {
  chk_population(population)
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)
  chk_flag(plot_values)
  schedule <- ypr_tabulate_schedule(population)

  schedule <- as.list(schedule)
  schedule$BH <- population$BH
  schedule$Rmax <- population$Rmax
  schedule <- c(schedule, sr(schedule, population))

  data <- with(schedule, {
    data <- data.frame(Eggs = seq(0, to = phi * R0 * 2, length.out = 100))
    fun <- if (BH == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data
  })

  data2 <- ypr_tabulate_sr(population, Ly = Ly, harvest = harvest, biomass = biomass)
  data2$Type <- factor(data2$Type, levels = c("actual", "optimal", "unfished"))
  data2 <- rbind(data2, data2, data2)
  data2$Recruits[1:3] <- 0
  data2$Eggs[7:9] <- 0

  labels_x <- if (sum(data[["Eggs"]]) >= 1000) {
    scales::comma
  } else {
    waiver()
  }

  labels_y <- if (sum(data[["Recruits"]]) >= 1000) {
    scales::comma
  } else {
    waiver()
  }

  ggplot(data = data, aes_string(x = "Eggs", y = "Recruits")) +
    (
      if (plot_values) {
        geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted")
      } else {
        NULL
      }) +
    geom_line() +
    expand_limits(x = 0, y = 0) +
    scale_x_continuous(labels = labels_x) +
    scale_y_continuous(labels = labels_y) +
    scale_color_manual(values = c("red", "blue", "black")) +
    NULL
}

#' Plot Yield by Exploitation/Capture Probability
#'
#' Plots the 'Yield', 'Age', 'Length', 'Weight', 'Effort', or 'YPUE'
#' by the annual interval exploitation/capture probability.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @seealso [ypr_population()] and [ypr_yields()]
#' @export
#' @examples
#' ypr_plot_yield(ypr_population())
ypr_plot_yield.ypr_population <- function(object, y = "Yield", pi = seq(0, 1, length.out = 100),
                                          Ly = 0, harvest = TRUE, biomass = FALSE,
                                          u = harvest, plot_values = TRUE, ...) {
  chk_population(object)
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)

  chk_string(y)
  chk_subset(y, c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  chk_flag(u)

  data <- ypr_tabulate_yields(object,
    pi = pi, Ly = Ly, harvest = harvest,
    biomass = biomass
  )

  data2 <- ypr_tabulate_yield(object = object, Ly = Ly, harvest = harvest, biomass = biomass)

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  data1 <- data2
  data3 <- data2

  data1[c("Yield", "Age", "Length", "Weight", "Effort", "YPUE")] <- 0
  data3[c("pi", "u")] <- 0

  data2 <- rbind(data1, data2, data3, stringsAsFactors = FALSE)

  xlab <- if (u) "Exploitation Probability (%)" else "Capture Probability (%)"
  x <- if (u) "u" else "pi"

  ggplot(data = data, aes_string(x = x, y = y)) +
    (
      if (plot_values) {
        list(
          geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted"),
          scale_color_manual(values = c("red", "blue"))
        )
      } else {
        NULL
      }) +
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
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @seealso [ypr_populations()] and [ypr_yields()]
#' @export
#' @examples
#' \dontrun{
#' ypr_plot_yield(ypr_populations(Rk = c(2.5, 4.6), Llo = c(0, 60)), plot_values = FALSE) +
#'   ggplot2::facet_wrap(~Llo) +
#'   ggplot2::aes_string(group = "Rk", color = "Rk") +
#'   ggplot2::scale_color_manual(values = c("black", "blue"))
#'
#' ypr_plot_yield(ypr_populations(Rk = c(2.5, 4.6), Llo = c(0, 60))) +
#'   ggplot2::facet_grid(Rk ~ Llo)
#' }
ypr_plot_yield.ypr_populations <- function(
                                           object, y = "Yield", pi = seq(0, 1, length.out = 100),
                                           Ly = 0, harvest = TRUE, biomass = FALSE, u = harvest, plot_values = TRUE, ...) {
  chk_string(y)
  chk_subset(y, c("Yield", "Age", "Length", "Weight", "Effort", "YPUE"))
  chk_flag(u)

  data <- ypr_tabulate_yields(object,
    pi = pi, Ly = Ly, harvest = harvest,
    biomass = biomass
  )

  data2 <- ypr_tabulate_yield(object = object, Ly = Ly, harvest = harvest, biomass = biomass)

  data$YPUE <- data$Yield / data$Effort
  data2$YPUE <- data2$Yield / data2$Effort

  parameters <- setdiff(intersect(colnames(data), .parameters$Parameter), "pi")

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

  ggplot(data = data, aes_string(x = x, y = y)) +
    (
      if (plot_values) {
        list(
          geom_path(data = data2, aes_string(group = "Type", color = "Type"), linetype = "dotted"),
          scale_color_manual(values = c("red", "blue"))
        )
      } else {
        NULL
      }) +
    geom_line() +
    expand_limits(x = 0) +
    scale_x_continuous(xlab, labels = scales::percent) +
    NULL
}
