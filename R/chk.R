chk_population <- function(x, x_name = NULL) {
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))
  chk_string(x_name, x_name = "x_name")

  chk_s3_class(x, "ypr_population", x_name = x_name)
  chk_named(x, x_name = x_name)
  chk_unique(names(x), x_name = x_name)
  chk_superset(names(x), .parameters$Parameter, x_name = x_name)

  do.call("chk_parameters", x)
  x
}

chk_populations <- function(x, x_name = NULL) {
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))

  chk_list(x, x_name = x_name)

  x_name <- paste("elements of", x_name)

  chk_s3_class(x, "ypr_populations")

  chk_all(x, chk_population, x_name = x_name)

  x
}
