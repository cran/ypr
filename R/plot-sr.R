#' Plot Stock-Recruitment Curve
#'
#' @inheritParams params
#' @return A ggplot2 object.
#' @family sr
#' @family plot
#' @export
#' @examples
#' ypr_plot_sr(ypr_population(Rk = 10))
#' ypr_plot_sr(ypr_population(Rk = 10, BH = 0L))
ypr_plot_sr <- function(population,
                        Ly = 0,
                        harvest = TRUE,
                        biomass = FALSE,
                        plot_values = TRUE) {
  if (!requireNamespace("ggplot2")) err("Package 'ggplot2' must be installed.")
  if (!requireNamespace("scales")) err("Package 'scales' must be installed.")

  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)
  chk_flag(plot_values)

  schedule <- ypr_tabulate_schedule(population)

  BH <- ypr_get_par(population, "BH")
  Rmax <- ypr_get_par(population, "Rmax")

  schedule <- as.list(schedule)
  schedule$BH <- BH
  schedule$Rmax <- Rmax
  schedule <- c(schedule, sr(schedule, population))

  data <- with(schedule, {
    data <- data.frame(Eggs = seq(0, to = only(phi) * only(R0) * 2, length.out = 100))
    fun <- if (BH == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data
  })

  data2 <- ypr_tabulate_sr(
    population,
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )
  data2$Type <- factor(data2$Type, levels = c("actual", "optimal", "unfished"))
  data2 <- rbind(data2, data2, data2)
  data2$Recruits[1:3] <- 0
  data2$Eggs[7:9] <- 0

  labels_x <- if (sum(data[["Eggs"]]) >= 1000) {
    scales::comma
  } else {
    ggplot2::waiver()
  }

  labels_y <- if (sum(data[["Recruits"]]) >= 1000) {
    scales::comma
  } else {
    ggplot2::waiver()
  }

  ggplot2::ggplot(
    data = data,
    ggplot2::aes_string(
      x = "Eggs",
      y = "Recruits"
    )
  ) +
    (
      if (plot_values) {
        ggplot2::geom_path(
          data = data2,
          ggplot2::aes_string(
            group = "Type",
            color = "Type"
          ),
          linetype = "dotted"
        )
      } else {
        NULL
      }) +
    ggplot2::geom_line() +
    ggplot2::expand_limits(x = 0, y = 0) +
    ggplot2::scale_x_continuous(labels = labels_x) +
    ggplot2::scale_y_continuous(labels = labels_y) +
    ggplot2::scale_color_manual(values = c("red", "blue", "black")) +
    NULL
}

