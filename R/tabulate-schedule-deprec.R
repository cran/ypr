#' Life-History Schedule
#'
#' Generates the life-history schedule by age for a population.
#'
#' @keywords internal
#' @description
#' `r lifecycle::badge('deprecated')`
#'
#' DEPRECATED: Replace `ypr_schedule()` with `ypr_tabulate_schedule()`
#'
#' @export
ypr_schedule <- function(population) {
  lifecycle::deprecate_warn(
    when = "0.4.0",
    what = "ypr_schedule()",
    with = "ypr_tabulate_schedule()"
  )
  ypr_tabulate_schedule(population)
}
