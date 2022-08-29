#' @export
tibble::as_tibble

#' @export
as_tibble.ypr_population <- function(x, ...) {
  chk_unused(...)
  as_tibble(as.data.frame(x))
}

#' @export
as_tibble.ypr_populations <- function(x, ...) {
  chk_unused(...)
  as_tibble(as.data.frame(x))
}

#' @export
as_tibble.ypr_ecotypes <- function(x, ...) {
  chk_unused(...)
  as_tibble(as.data.frame(x))
}
