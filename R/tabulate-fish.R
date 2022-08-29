sum_fish_table <- function(table, binwidth) {
  breaks <- seq(0, max(table[[1]] + binwidth), by = binwidth)
  table[[1]] <- cut(table[[1]], breaks = breaks)
  table[[1]] <- as.integer(table[[1]]) * binwidth
  table <- split(table, table[[1]])
  table <- lapply(table, sum_fish)
  table <- do.call("rbind", table)
  row.names(table) <- NULL
  table
}

#' Tabulate Fish Numbers
#'
#' Produces a data frame of the number of fish in the 'Survivors', 'Spawners',
#' 'Caught', 'Harvested', 'Released' and 'HandlingMortalities' categories by
#' 'Length', 'Age' or 'Weight' class and 'Ecotype' (NA if not applicable)
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A data frame
#' @family tabulate
#' @family fish
#' @export
#' @examples
#' ypr_tabulate_fish(ypr_population())
ypr_tabulate_fish <- function(population, x = "Age", binwidth = 1L) {
  chk_string(x)
  chk_subset(x, c("Age", "Length", "Weight"))
  chk_whole_number(binwidth)
  chk_range(binwidth, c(1L, 1000L))

  table <- ypr_tabulate_schedule(population)
  table <- as.data.frame(table)

  R0F <- sr(table, population)$R0F
  R0F <- max(0, R0F)

  pi <- ypr_get_par(population)
  Hm <- ypr_get_par(population, "Hm")

  table$Survivors <- table$FishedSurvivorship * R0F
  table$Spawners <- table$Survivors * table$Spawning
  table$Caught <- table$Survivors * table$Vulnerability * pi
  table$Harvested <- table$Caught * table$Retention
  table$Released <- table$Caught * (1 - table$Retention)
  table$HandlingMortalities <- table$Released * Hm
  if(!"Ecotype" %in% colnames(table))
    table$Ecotype <- 1

  table <- table[c(
    x, "Survivors", "Spawners", "Caught", "Harvested",
    "Released", "HandlingMortalities", "Ecotype"
  )]

  table <- split(table, table$Ecotype)
  table <- lapply(table, sum_fish_table, binwidth)
  table <- do.call("rbind", table)
  row.names(table) <- NULL

  if(length(unique(table$Ecotype)) == 1L)
    table$Ecotype <- NA_character_

  as_tibble(table)
}
