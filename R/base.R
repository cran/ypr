#' @export
as.data.frame.ypr_population <- function(x, ...) {
  x <- unclass(x)
  as_tibble(as.data.frame(x))
}

#' @export
as.data.frame.ypr_populations <- function(x, ...) {
  x <- lapply(x, as.data.frame)
  as_tibble(do.call("rbind", x))
}

#' Plot Population Schedule
#'
#' @param x The population to plot.
#' @inheritParams graphics::plot.default
#' @param ... Additional arguments passed to graphics::plot.formula functions.
#' @return An invisible copy of the original object.
#' @seealso [ypr_population()] and [ypr_tabulate_schedule()]
#' @export
#' @examples
#' \dontrun{
#' plot(ypr_population())
#' }
plot.ypr_population <- function(x, type = "b", ...) {
  chk_population(x)

  schedule <- ypr_tabulate_schedule(x)

  with(schedule, {
    plot(Length ~ Age,
      xlim = c(0, max(Age)), ylim = c(0, max(Length)),
      type = type, ...
    )
    plot(Weight ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, max(Weight)),
      type = type, ...
    )
    plot(Fecundity ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, max(Fecundity)),
      type = type, ...
    )
    plot(Spawning ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, 1),
      type = type, ...
    )
    plot(Vulnerability ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, 1),
      type = type, ...
    )
    plot(NaturalMortality ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, 1),
      type = type, ...
    )
    plot(FishingMortality ~ Length,
      xlim = c(0, max(Length)), ylim = c(0, 1),
      type = type, ...
    )
    plot(Survivorship ~ Age,
      xlim = c(0, max(Age)), ylim = c(0, 1),
      type = type, ...
    )
    plot(FishedSurvivorship ~ Age,
      xlim = c(0, max(Age)), ylim = c(0, 1),
      type = type, ...
    )
  })
  invisible(x)
}

#' @export
print.ypr_population <- function(x, ...) {
  suppressWarnings(chk_population(x))
  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(nchar, function(x) paste0(rep(" ", times = x), collapse = ""), "")
  x <- paste0(names(x), ":", space, x, collapse = "\n")
  x <- paste0(x, "\n", collapse = "")
  cat(x)
  invisible(x)
}

#' @export
print.ypr_populations <- function(x, ...) {
  suppressWarnings(chk_populations(x))
  if (length(x) == 1) {
    return(print(x[[1]]))
  }
  x$FUN <- c
  x <- do.call("mapply", x)
  x <- as.data.frame(x)
  x <- lapply(x, function(x) if (length(unique(x)) == 1) x[1] else x)

  nchar <- nchar(names(x))
  nchar <- max(nchar) - nchar + 1
  space <- vapply(nchar, function(x) paste0(rep(" ", times = x), collapse = ""), "")
  names <- names(x)
  x <- lapply(x, paste0, collapse = ", ")
  x <- paste0(names, ":", space, x, collapse = "\n")
  x <- paste0(x, "\n", collapse = "")
  cat(x)
  invisible(x)
}

#' @export
unique.ypr_populations <- function(x, ...) {
  x <- as.data.frame(x)
  x <- unique(x)
  as_ypr_populations(x)
}

#' @describeIn ypr_population_update Update Population Parameters
#' @export
update.ypr_population <- function(object, ...) {
  ypr_population_update(object, ...)
}

#' @describeIn ypr_populations_update Update Populations Parameters
#' @export
update.ypr_populations <- function(object, ...) {
  ypr_population_update(object, ...)
}
