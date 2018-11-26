#' @export
print.ypr_population <- function(x, ...) {
  check_population(x)
  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(nchar, function(x) paste0(rep(" ", times = x), collapse = ""), "")
  x <- paste0(names(x), ":", space, x, collapse = "\n")
  cat(x)
  invisible(x)
}

#' @export
print.ypr_populations <- function(x, ...) {
  check_populations(x)
  if(length(x) == 1) return(print(x[[1]]))
  x$FUN = c
  x <- do.call("mapply", x)
  x <- as.data.frame(x)
  x <- lapply(x, function(x) sort(unique(x)))

  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(nchar, function(x) paste0(rep(" ", times = x), collapse = ""), "")
  names <- names(x)
  x <- lapply(x, paste0, collapse = ", ")
  x <- paste0(names, ":", space, x, collapse = "\n")
  cat(x)
  invisible(x)
}
