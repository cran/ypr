#' @export
as.data.frame.ypr_population <- function(x, ...) {
  chk_unused(...)
  x <- unclass(x)
  as.data.frame(x)
}

#' @export
as.data.frame.ypr_populations <- function(x, ...) {
  chk_unused(...)
  x <- lapply(x, as.data.frame)
  do.call("rbind", x)
}

#' @export
as.data.frame.ypr_ecotypes <- function(x, ...) {
  chk_unused(...)
  rname <- attr(x, "names")
  x <- lapply(x, as.data.frame)
  do.call("rbind", x)
}
