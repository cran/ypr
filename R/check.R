check_population <- function(x, exclusive = TRUE, order = TRUE, x_name = substitute(x)) {
  x_name <- chk_deparse(x_name)
  check_string(x_name, x_name = "x_name")

  check_inherits(x, "ypr_population", x_name = x_name)

  check_names(x, .parameters$Parameter,
              exclusive = exclusive, unique = TRUE, x_name = x_name)

  parameters <- .parameters

  parameters$Code <- paste0(
    "check_scalar(", parameters$Parameter, ", c(",
    parameters$Lower, ifelse(parameters$Integer == 1, "L", ""), ",",
    parameters$Upper, ifelse(parameters$Integer == 1, "L", ""), "))")

  code <- paste0(parameters$Code, collapse = "\n")
  code <- paste0("with(x, {\n", code, "\n})")

  eval(parse(text = code))

  x
}

check_populations <- function(x, exclusive = TRUE, order = TRUE, x_name = substitute(x)) {
  x_name <- chk_deparse(x_name)
  check_string(x_name, x_name = "x_name")

  x_name <- paste("elements of", x_name)

  check_inherits(x, "ypr_populations")

  lapply(x, check_population, exclusive = exclusive, order = order,
         x_name = x_name)

  x
}

check_yield_parameters <- function(population, Ly, harvest, biomass) {
  check_population(population)
  check_scalar(Ly, c(0, Inf))
  check_flag(biomass)
  check_flag(harvest)
  population
}

