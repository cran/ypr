#' Create Ecotypes Object
#'
#' Creates an ypr_ecotypes object.
#'
#' @inheritParams params
#' @return An [ypr_ecotypes()] objects
#' @family ecotypes
#' @export
#' @examples
#' ypr_ecotypes(Linf = c(1, 2))
#' ypr_ecotypes(Linf = c(1, 2), t0 = c(0, 0.5))
ypr_ecotypes <- function(..., names = NULL) {
  chk_null_or(names, vld = vld_character)
  x <- ypr_populations(..., expand = FALSE, names = names)
  x <- as_ypr_ecotypes(x)
  if(is.null(names)) {
    names <- ypr_names(x)
  }
  names(x) <- names
  x
}
