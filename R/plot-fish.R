
#' Plot Fish
#'
#' Produces a frequency histogram of the number of fish in the 'Survivors',
#' 'Spawners', 'Caught', 'Harvested' or 'Released' categories by 'Length', 'Age'
#' or 'Weight' class.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A ggplot2 object.
#' @seealso [ggplot2::geom_histogram()]
#' @family fish
#' @family plot
#' @export
#' @examples
#' ypr_plot_fish(ypr_population(), color = "white")
ypr_plot_fish <- function(population, x = "Age", y = "Survivors",
                          percent = FALSE,
                          binwidth = 1L, color = NULL) {
  if (!requireNamespace("ggplot2")) err("Package 'ggplot2' must be installed.")
  if (!requireNamespace("scales")) err("Package 'scales' must be installed.")
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
    ggplot2::waiver()
  }

  gp <- ggplot2::ggplot(data = fish) +
    (if(length(unique(fish$Ecotype)) == 1) {
      ggplot2::aes_string(x = x, weight = y)
    } else {
      ggplot2::aes_string(x = x, weight = y, fill = "Ecotype")
    }) +
    (if (is.null(color)) {
      ggplot2::geom_bar(width = binwidth)
    } else {
      ggplot2::geom_bar(width = binwidth, color = color)
    }) +
    ggplot2::scale_y_continuous(y, labels = labels) +
    ggplot2::expand_limits(x = 0, y = 0)
}
