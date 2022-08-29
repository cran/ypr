integer_parameters <- function() {
  .parameters$Parameter[.parameters$Integer == 1]
}

parameters <- function() {
  .parameters$Parameter
}

ecoall_parameters <- function() {
  .parameters$Parameter[.parameters$EcoAll == 1]
}

lines_population <- function(population) {
  population <- unclass(population)
  population <- lapply(population, as.character)
  population <- mapply(paste, names(population), population, sep = " = ")
  population <- unlist(population)
  population[integer_parameters()] <- paste0(
    population[integer_parameters()],
    "L"
  )
  population <- paste(population, collapse = ", ")
  paste0("ypr_population(", population, ")", collapse = "")
}

#' Report
#'
#' Creates an Rmd file that can be used to generate a report.
#'
#' @inheritParams params
#' @return An invisible character vector of the contents of the file.
#' @family tabulate
#' @export
#' @examples
#' \dontrun{
#' ypr_report(ypr_population(), file = tempfile(), ask = FALSE)
#' }
ypr_report <- function(population,
                       Ly = 0,
                       harvest = TRUE,
                       biomass = FALSE,
                       title = "Population Report",
                       description = "",
                       date = Sys.Date(),
                       file = "report",
                       view = FALSE,
                       ask = TRUE) {
  check_population(population)
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
  if (!requireNamespace("usethis")) err("Package 'usethis' must be installed.")

  if (grepl("[.](R|r)md$", file)) {
    wrn("File extension on argument `file` is deprecated (please remove).")
    file <- .sub(file, "[.](R|r)md$", "")
  }
  file <- p0(file, ".Rmd")

  if (!ask_file(file, ask)) {
    return(invisible(character(0)))
  }

  data <- list(
    title = title,
    date = date,
    description = description,
    population = lines_population(population),
    Ly = Ly,
    harvest = harvest,
    biomass = biomass
  )

  usethis::use_template(
    template = "template-report.Rmd",
    save_as = file,
    data = data,
    package = "ypr"
  )

  if (view) {
    if (!requireNamespace("rmarkdown")) {
      err("Package 'rmarkdown' is required to render the report to html.")
    }

    file_html <- p0(.sub(file, "[.](R|r)md$", ""), ".html")
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
