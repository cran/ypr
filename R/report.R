integer_parameters <- function() {
  .parameters$Parameter[.parameters$Integer == 1]
}

lines_population <- function(population) {
  population <- unclass(population)
  population <- lapply(population, as.character)
  population <- mapply(paste, names(population), population, sep = " = ")
  population <- unlist(population)
  population[integer_parameters()] <- paste0(population[integer_parameters()], "L")
  population <- paste(population, collapse = ", ")
  paste0("ypr_population(", population, ")", collapse = "")
}

lines_head <- function(population, title, date) {
paste0('---
title: "', title, '"
date: "', date, '"
output: html_document
---

```{r setup, include = FALSE}
knitr::opts_chunk$set(
  echo = FALSE,
  fig.width = 4,
  fig.height = 4
)
```

```{r, echo = TRUE}
library(ypr)
population <- ', lines_population(population),'
```')
}

lines_body <- function() {
'```{r}
ypr_plot_schedule(population)
ypr_plot_schedule(population, "Length", "Weight")
ypr_plot_schedule(population, "Weight", "Fecundity")
ypr_plot_schedule(population, "Length", "Spawning")
```

```{r}
ypr_plot_schedule(population, "Length", "Vulnerability")
ypr_plot_schedule(population, "Length", "Retention")
ypr_plot_schedule(population, "Length", "FishingMortality")
ypr_plot_schedule(population, "Length", "NaturalMortality")
```

```{r}
ypr_plot_fish(population, color = "white")
ypr_plot_fish(population, "Length", "Caught")
ypr_plot_fish(population, "Age", "Spawning", color = "white")
ypr_plot_fish(population, "Length", "Spawning")
```

```{r, fig.width = 6, fig.height = 4}
ypr_plot_sr(population)
knitr::kable(ypr_sr(population))
knitr::kable(ypr_tabulate_sr(population))
```

```{r, fig.width = 6, fig.height = 4}
ypr_plot_yield(population)
knitr::kable(ypr_tabulate_yield(population))
```'
}

#' Report
#'
#' Creates an Rmd file that can be used to generate a report.
#'
#' @inheritParams ypr_schedule
#' @param title A string of the report title.
#' @param date A date of the report date.
#' @param file A string of the file name.
#' @return An invisible character vector of the contents of the file.
#' @export
#' @examples
#' \dontrun{
#' cat(ypr_report(ypr_population(), file = tempfile()), sep = "\n")
#' }
ypr_report <- function(population, title = "Population Report",
                       date = Sys.Date(),
                       file = "report.Rmd") {
  check_population(population)
  check_string(title)
  check_date(date)
  check_string(file)

  file.create(file)
  con <- file(file, "w")
  writeLines(lines_head(population = population, title = title, date = date),
             con = con)
  writeLines(lines_body(), con = con)
  close(con)
  invisible(readLines(file))
}
