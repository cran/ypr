#' Expand Populations
#'
#' An object of class [ypr_population()] of all unique combinations of parameter
#' values.
#'
#' @inheritParams params
#' @return An object of class `ypr_population`.
#' @family populations
#' @export
#' @examples
#' ypr_populations_expand(
#'   ypr_populations(
#'     Rk = c(2.5, 4, 2.5),
#'     Hm = c(0.1, 0.2, 0.1)
#'   )
#' )
ypr_populations_expand <- function(populations) {
  populations <- as.data.frame(populations)
  populations <- unique(populations)
  populations <- as.list(populations)
  populations <- lapply(populations, function(x) sort(unique(x)))
  populations <- expand.grid(populations)
  populations <- unique(populations)
  as_ypr_populations(populations)
}
