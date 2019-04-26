bh <- function(stock, alpha, beta) {
  unname(alpha * stock / (1 + (beta * stock)))
}

ri <- function(stock, alpha, beta) {
  unname(alpha * stock * exp(-beta * stock))
}

add_parameters <- function(x, object) {
  object <- as.data.frame(unclass(object))
  object$pi <- NULL
  merge(x, object)
}

as_tibble <- function(x) {
  class(x) <- c("tbl_df", "tbl", "data.frame")
  x
}

drop_constant_parameters <- function(x) {
  parameters <- .parameters$Parameter
  parameters <- parameters[parameters != "pi"]
  bol <- vapply(parameters, function(y) length(unique(x[[y]])) == 1, TRUE)
  parameters <- parameters[bol]
  x[parameters] <- NULL
  x
}

quantiles <- function(x, level) {
  x <- unlist(x)
  x <- stats::quantile(x, c(0.5, (1-level)/2, (1-level)/2 + level))
  setNames(x, c("estimate", "lower", "upper"))
}

sanitize <- function(x) {
  x[is.nan(x)] <- 0
  x[x < 0] <- 0
  x
}

tabulate_yield_pi <- function(pi, object, Ly, harvest, biomass, all) {
  object$pi <- pi
  yield <- ypr_tabulate_yield(object = object, Ly = Ly,
                              harvest = harvest, biomass = biomass,
                              type = "actual", all = all)
  yield$Type <- NULL
  yield
}

sum_fish <- function(x) {
  x[] <- lapply(x, sum)
  x[[1]] <- x[[1]] / nrow(x)
  x[1,]
}

population_names <- function(x) {
  length <- vapply(x, function(x) length(unique(x)), 1L)
  x <- x[length > 1L]
  names <- names(x)
  x <- apply(x, 1, function(x) sub("[.]", "_", x))
  if(identical(length(names), 1L))
    return(paste0(names, "_", x))
  x <- apply(x, 2, function(x, names) paste0(names, "_", x), names = names)
  apply(x, 2, function(x) paste0(x, collapse = "_"))
}
