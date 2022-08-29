#' Populations
#'
#' @inheritParams params
#' @inheritParams ypr_update
#'
#' @return A list of [ypr_population()] objects
#' @family populations
#' @export
#' @examples
#' ypr_populations(Rk = c(2.5, 4.6), Hm = c(0.2, 0.05))
ypr_populations <- function(..., expand = TRUE, names = NULL) {
  chk_flag(expand)
  chk_null_or(names, vld = vld_character)

  population <- ypr_population()

  parameters <- list(...)

  if (!length(parameters)) {
    populations <- list(population)
    class(populations) <- "ypr_populations"
    return(populations)
  }
  chk_named(parameters, x_name = "`...`")
  chk_subset(names(parameters), parameters(), x_name = "`names(...)`")
  chk_unique(names(parameters), x_name = "`names(...)`")

  if (expand) {
    parameters <- lapply(parameters, function(x) sort(unique(x)))
    parameters <- expand.grid(parameters)
  } else {
    lengths <- vapply(parameters, length, FUN.VALUE = 1L)
    lengths <- unique(lengths)
    lengths <- lengths[lengths != 1]
    if (length(lengths) > 1) {
      err(
        "Non-scalar parameter values must all be the same length (not ",
        cc(sort(lengths), conj = " and ", brac = ""), ")"
      )
    }
    parameters <- as.data.frame(parameters)
  }
  populations <- list()
  for (i in seq_len(nrow(parameters))) {
    population <- as.list(parameters[i, , drop = FALSE])
    attr(population, "out.attrs") <- NULL
    populations[[i]] <- do.call("ypr_population", population)
  }
  class(populations) <- "ypr_populations"

  if(!is.null(names)) {
    chk_not_any_na(names)
    chk_unique(names)
    if (!chk::vld_equal(length(populations), length(names))) {
      chk::abort_chk(paste0("Number of populations and names do not match. ",
                            length(populations), " != ", length(names)))
    }
  } else {
    names <- ypr_names(populations)
  }

  names(populations) <- names
  populations
}
