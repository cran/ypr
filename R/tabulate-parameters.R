#' Tabulate Population Parameters
#'
#' @inheritParams params
#' @return A table of population parameters
#' @family tabulate
#' @family parameters
#' @export
#' @examples
#' ypr_tabulate_parameters(ypr_population())
ypr_tabulate_parameters <- function(population) {
  check_population(population)

  parameters <- data.frame(
    Parameter = names(population),
    Value = unname(unlist(population)),
    stringsAsFactors = FALSE
  )

  pattern <- "(\\\\item[{])([^}]+)([}])([{])([^}]+)([}])"
  rd <- tools::Rd_db("ypr")$ypr_population.Rd
  rd <- paste0(as.character(rd), collapse = "")
  gp <- gregexpr(pattern, rd)
  rd <- regmatches(rd, gp)[[1]]

  data <- data.frame(
    Parameter = .sub(rd, pattern, "\\2"),
    Description = .sub(rd, pattern, "\\5"),
    stringsAsFactors = FALSE
  )

  parameters <- merge(parameters, data, by = "Parameter", sort = FALSE)

  as_tibble(parameters)
}
