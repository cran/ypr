#' Detabulate Population Parameters
#'
#' @param x A data frame with columns Parameter and Value specifying one or more
#'   parameters and their values.
#' @return An object of class [ypr_population()]
#' @family tabulate
#' @family parameters
#' @export
#' @examples
#' ypr_detabulate_parameters(ypr_tabulate_parameters(ypr_population()))
ypr_detabulate_parameters <- function(x) {
  chk_s3_class(x, "data.frame")
  chk_superset(colnames(x), c("Parameter", "Value"))
  chk_s3_class(x$Parameter, "character")
  chk_not_any_na(x$Parameter)
  chk_subset(x$Parameter, parameters())
  chk_unique(x$Parameter)

  chk_numeric(x$Value)
  chk_not_any_na(x$Value)
  chk_range(x$Value, c(min(.parameters$Lower), max(.parameters$Upper)))

  x <- merge(
    x,
    .parameters[c("Parameter", "Integer")],
    by = "Parameter",
    sort = FALSE
  )

  parameters <- as.list(x$Value)
  names(parameters) <- x$Parameter

  parameters <- mapply(function(x, y) if (y == 1) as.integer(x) else x,
                       parameters, x$Integer,
                       SIMPLIFY = FALSE
  )

  population <- do.call("ypr_population", parameters)
  population
}
