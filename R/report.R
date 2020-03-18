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

lines_head <- function(population, title, description, date) {
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

', description, "

```{r}
library(ypr)
population <- ", lines_population(population), "
```")
}

lines_body <- function(Ly, harvest, biomass) {
  p0('```{r}
knitr::kable(ypr_tabulate_parameters(population))
```

```{r}
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
ypr_plot_fish(population, "Age", "Spawners", color = "white")
ypr_plot_fish(population, "Length", "Spawners")
ypr_plot_biomass(population, color = "white")
ypr_plot_biomass(population, y = "Eggs", color = "white")
```

```{r, fig.width = 6, fig.height = 4}
ypr_plot_sr(population)
knitr::kable(ypr_sr(population))
knitr::kable(ypr_tabulate_sr(population))
```

```{r, fig.width = 6, fig.height = 4}
ypr_plot_yield(population, Ly = ', Ly, ", harvest = ", harvest, ", biomass = ", biomass, ")
knitr::kable(ypr_tabulate_yield(population, Ly = ", Ly, ", harvest = ", harvest, ", biomass = ", biomass, "))
```")
}

#' Report
#'
#' Creates an Rmd file that can be used to generate a report.
#'
#' @inheritParams params
#' @return An invisible character vector of the contents of the file.
#' @export
#' @examples
#' ypr_report(ypr_population(), file = tempfile(), ask = FALSE)
ypr_report <- function(population,
                       Ly = 0,
                       harvest = TRUE,
                       biomass = FALSE,
                       title = "Population Report",
                       description = "",
                       date = Sys.Date(),
                       file = "report", view = FALSE, ask = TRUE) {
  chk_population(population)
  chk_number(Ly)
  chk_gte(Ly)
  chk_flag(biomass)
  chk_flag(harvest)
  chk_string(title)
  chk_string(description)
  chk_date(date)
  chk_string(file)
  chk_flag(view)
  chk_flag(ask)

  if (grepl("[.](R|r)md$", file)) {
    wrn("File extension on argument `file` is deprecated (please remove).")
    file <- sub("[.](R|r)md$", "", file)
  }
  file <- p0(file, ".Rmd")

  if (!ask_file(file, ask)) {
    return(invisible(character(0)))
  }

  file.create(file)
  con <- file(file, "w")
  writeLines(lines_head(
    population = population, title = title,
    description = description, date = date
  ),
  con = con
  )
  writeLines(lines_body(
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  ), con = con)
  close(con)
  if (view) {
    if (!requireNamespace("rmarkdown")) {
      err("Package 'rmarkdown' is required to render the report to html.")
    }
    file_html <- p0(sub("[.](R|r)md$", "", file), ".html")
    if (!ask_file(file_html, ask)) {
      return(invisible(readLines(file)))
    }
    rmarkdown::render(file, output_format = "html_document", quiet = TRUE)
    if (!requireNamespace("rstudioapi")) {
      err("Package 'rstudioapi' is required to view the html report.")
    }
    rstudioapi::viewer(file_html)
  }
  invisible(readLines(file))
}
