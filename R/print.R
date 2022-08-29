
#' @export
print.ypr_population <- function(x, ...) {
  suppressWarnings(check_population(x))
  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(
    nchar,
    function(x) paste0(rep(" ", times = x), collapse = ""), ""
  )
  x <- paste0(names(x), ":", space, x, collapse = "\n")
  x <- paste0(x, "\n", collapse = "")
  cat(x)
  invisible(x)
}

#' @export
print.ypr_populations <- function(x, ...) {
  suppressWarnings(check_populations(x))
  if (length(x) == 1) {
    return(print(x[[1]]))
  }
  x$FUN <- c
  x <- do.call("mapply", x)
  x <- as.data.frame(x)
  x <- lapply(x, function(x) if (length(unique(x)) == 1) x[1] else x)

  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(
    nchar,
    function(x) paste0(rep(" ", times = x), collapse = ""), ""
  )
  names <- names(x)
  x <- lapply(x, paste0, collapse = ", ")
  x <- paste0(names, ":", space, x, collapse = "\n")
  x <- paste0(x, "\n", collapse = "")
  cat(x)
  invisible(x)
}

### Add ecotype and proportion and weight formatted as other things
#' @export
print.ypr_ecotypes <- function(x, ...) {
  suppressWarnings(check_ecotypes(x))
  if (length(x) == 1) { ### should print with name and weight so not confused
    return(print(x[[1]]))
  }
  eco_names <- attr(x, "names")

  x$FUN <- c
  x <- do.call("mapply", x)
  x <- as.data.frame(x)
  x <- lapply(x, function(x) if (length(unique(x)) == 1) x[1] else x)

  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(
    nchar,
    function(x) paste0(rep(" ", times = x), collapse = ""), ""
  )
  names <- names(x)
  x <- lapply(x, paste0, collapse = ", ")
  x <- paste0(names, ":", space, x, collapse = "\n")
  x <- paste0(x, "\n", collapse = "")

  eco_names <- paste0(eco_names, collapse = ", ")
  eco_names <- paste0("Ecotype", ": ", eco_names, collapse = "\n")
  eco_names <- paste0(eco_names, "\n", collapse = "")

  cat(x, eco_names, sep = "")
  invisible(x)
}
