#' @describeIn ypr_tabulate_schedule Tabulate Schedule (Deprecated)
#' @export
ypr_schedule <- function(population) {
  deprecate_soft("0.4.0", "ypr_schedule()", "ypr_tabulate_schedule()")
  ypr_tabulate_schedule(population)
}
