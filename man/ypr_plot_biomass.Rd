% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-biomass.R
\name{ypr_plot_biomass}
\alias{ypr_plot_biomass}
\title{Plot Biomass}
\usage{
ypr_plot_biomass(population, y = "Biomass", color = NULL)
}
\arguments{
\item{population}{An object of class \code{\link[=ypr_population]{ypr_population()}}.}

\item{y}{A string of the term on the y-axis.}

\item{color}{A string of the color around each bar (or NULL).}
}
\value{
A ggplot2 object.
}
\description{
Produces a frequency histogram of the total fish 'Biomass' or 'Eggs'
deposition by 'Age' class.
}
\examples{
ypr_plot_biomass(ypr_population(), color = "white")
}
\seealso{
\code{\link[ggplot2:geom_histogram]{ggplot2::geom_histogram()}}

Other biomass: 
\code{\link{ypr_tabulate_biomass}()}

Other plot: 
\code{\link{ypr_plot_fish}()},
\code{\link{ypr_plot_schedule}()},
\code{\link{ypr_plot_sr}()},
\code{\link{ypr_plot_yield}()}
}
\concept{biomass}
\concept{plot}
