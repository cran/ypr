#' Plot Population Schedule
#'
#' @param x The population to plot.
#' @param type A string specifying the plot type.
#' Possible values include 'b', 'p' and 'l'.
#' @param ... Additional arguments passed to [graphics::plot] function.
#' @return An invisible copy of the original object.
#' @seealso [graphics::plot]
#' @export
#' @examples
#' \dontrun{
#' plot(ypr_population())
#' }
plot.ypr_population <- function(x, type = "b", ...) {
  check_population(x)

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
