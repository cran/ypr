% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update.R
\name{ypr_update}
\alias{ypr_update}
\alias{ypr_update.ypr_population}
\alias{ypr_update.ypr_populations}
\alias{ypr_update.ypr_ecotypes}
\title{Update a YPR Object
Currently just works with scalar parameters for populations and ecotypes.}
\usage{
ypr_update(x, ...)

\method{ypr_update}{ypr_population}(x, ...)

\method{ypr_update}{ypr_populations}(x, ...)

\method{ypr_update}{ypr_ecotypes}(x, ...)
}
\arguments{
\item{x}{A population, populations or ecotypes object to update.}

\item{...}{One or more parameter values from \code{ypr_population()}.}
}
\description{
Update a YPR Object
Currently just works with scalar parameters for populations and ecotypes.
}
\section{Methods (by class)}{
\itemize{
\item \code{ypr_update(ypr_population)}: Update Population Parameters

\item \code{ypr_update(ypr_populations)}: Update Populations Parameters

\item \code{ypr_update(ypr_ecotypes)}: Update Populations Parameters

}}
\examples{
ypr_update(ypr_population(), Rk = 2.5)
ypr_update(ypr_populations(Rk = c(2.5, 4)), Rk = 2.5)
ypr_update(ypr_ecotypes(Linf = c(2.5, 4)), k = 1.5)
}
