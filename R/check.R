#' Check Population
#'
#' Checks if an ypr_population object with valid parameter values.
#'
#' @inherit chk::check_data
#' @family check
#' @export
#'
#' @examples
#' check_population(ypr_population())
check_population <- function(x, x_name = NULL) {
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))
  chk_string(x_name, x_name = "x_name")

  chk_s3_class(x, "ypr_population", x_name = x_name)
  chk_named(x, x_name = x_name)
  chk_unique(names(x), x_name = x_name)
  chk_superset(names(x), parameters(), x_name = x_name)

  do.call("check_parameters", x)
  invisible(x)
}

#' Check Populations
#'
#' Checks if an ypr_populations object with valid parameter values.
#'
#' @inherit chk::check_data
#' @family check
#' @export
#'
#' @examples
#' check_populations(ypr_populations())
check_populations <- function(x, x_name = NULL) {
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))

  chk_list(x, x_name = x_name)

  chk_s3_class(x, "ypr_populations", x_name)
  x_name <- paste("elements of", x_name)


  chk_all(x, check_population, x_name = x_name)
  invisible(x)
}

#' Check Ecotypes
#'
#' Checks if an ypr_ecotypes object with valid parameter values.
#'
#' @inherit chk::check_data
#' @family check
#' @export
#'
#' @examples
#' check_ecotypes(ypr_ecotypes())
check_ecotypes <- function(x, x_name = NULL) {
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))

  chk_list(x, x_name = x_name)

  chk_s3_class(x, "ypr_ecotypes", x_name)
  x_name <- paste("elements of", x_name)

  chk_all(x, check_population, x_name = x_name)

  check_same(x, "BH")
  check_same(x, "Rk")
  check_same(x, "tR")
  check_same(x, "Rmax")
  check_same(x, "pi")
  check_same(x, "Nc")
  check_same(x, "Hm")
  check_same(x, "Llo")
  check_same(x, "Lup")
  check_same(x, "rho")
  check_same(x, "q")

  data <- as_tibble(x)
  data$RPR <- NULL
  if(anyDuplicated(data)) {
    chk::abort_chk("ecotypes must have unique life-histories.", tidy = FALSE)
  }
  invisible(x)
}

check_same <- function(x, parameter) {
  class(x) <- "ypr_populations"

  values <- ypr_get_par(x, parameter)
  if (length(unique(values)) != 1) {
    chk::abort_chk("`", parameter, "` must be the same across all elements.", tidy = FALSE)
  }
}
