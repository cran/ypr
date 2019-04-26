#' Stock-Recruitment Parameters
#'
#' @param object The populations or populations.
#' @param ... Unused parameters.
#' @return A table of stock-recruitment parameters.
#' @export
#' @examples
#' ypr_tabulate_sr(ypr_population()) # Beverton-Holt
#' ypr_tabulate_sr(ypr_population(BH = 0L)) # Ricker
ypr_tabulate_sr <- function(object, ...) {
  UseMethod("ypr_tabulate_sr")
}

#' Tabulate Yield
#'
#' @inheritParams ypr_tabulate_sr
#'
#' @return A data frame.
#' @seealso \code{\link{ypr_population}}, \code{\link{ypr_populations}} and \code{\link{ypr_yield}}
#' @export
#' @examples
#' ypr_tabulate_yield(ypr_population())
ypr_tabulate_yield <- function(object, ...) {
  UseMethod("ypr_tabulate_yield")
}

#' Tabulate Yields
#'
#' @inheritParams ypr_tabulate_sr
#'
#' @return A data frame.
#' @seealso \code{\link{ypr_population}}, \code{\link{ypr_populations}} and \code{\link{ypr_yields}}
#' @export
#' @examples
#' ypr_tabulate_yields(ypr_population())
ypr_tabulate_yields <- function(object, ...) {
  UseMethod("ypr_tabulate_yields")
}

#' Population Parameters
#'
#' @inheritParams ypr_schedule
#' @return A table of population parameters
#' @seealso \code{\link{ypr_population}}
#' @export
#' @examples
#' ypr_tabulate_parameters(ypr_population())
ypr_tabulate_parameters <- function(population) {
  check_population(population)

  parameters <- data.frame(Parameter = names(population),
                           Value = unname(unlist(population)),
                           stringsAsFactors = FALSE)

  pattern <- "(\\\\item[{])([^}]+)([}])([{])([^}]+)([}])"
  rd <- tools::Rd_db("ypr")$ypr_population.Rd
  rd <- paste0(as.character(rd), collapse = "")
  gp <- gregexpr(pattern, rd)
  rd <- regmatches(rd, gp)[[1]]

  data <- data.frame(Parameter = sub(pattern, "\\2", rd),
                     Description = sub(pattern, "\\5", rd),
                     stringsAsFactors = FALSE)

  parameters <- merge(parameters, data, by = "Parameter", sort = FALSE)

  as_tibble(parameters)
}

#' Detabulate Parameters
#'
#' @param x A data frame with columns Parameter and Value specifying
#' one or more parameters and their values.
#' @return An object of class \code{\link{ypr_population}}
#' @seealso \code{\link{ypr_population}}
#' @export
#' @examples
#' ypr_detabulate_parameters(ypr_tabulate_parameters(ypr_population()))
ypr_detabulate_parameters <- function(x) {
  check_data(
    x,
    values = list(Parameter = .parameters$Parameter,
                  Value = c(min(.parameters$Lower), max(.parameters$Upper))),
    key = "Parameter")

  x <- merge(x, .parameters[c("Parameter", "Integer")], by = "Parameter", sort = FALSE)

  parameters <- as.list(x$Value)
  names(parameters) <- x$Parameter

  parameters <- mapply(function(x, y) if(y == 1) as.integer(x) else x,
                       parameters, x$Integer, SIMPLIFY = FALSE)

  population <- do.call("ypr_population", parameters)
  population
}

#' Table Fish
#'
#' Produces a data frame of the number of fish in the
#' 'Surviving', 'Spawning', 'Caught', 'Harvested', 'Released' and 'HandlingMortality' categories by
#' 'Length', 'Age' or 'Weight' class.
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_plot_schedule
#' @param binwidth A positive integer of the width of the bins for grouping.
#' @return A data frame
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_plot_fish}}
#' @export
#' @examples
#' ypr_tabulate_fish(ypr_population())
ypr_tabulate_fish <- function(population, x = "Age", binwidth = 1L) {
  check_population(population)
  check_scalar(x, c("Age", "Length", "Weight"))
  check_scalar(binwidth, c(1L, 1000L))

  table <- ypr_schedule(population = population)
  table <- as.data.frame(table)

  table$Surviving <- table$FishedSurvivorship * sr(table, population)$R0F
  table$Spawning <- table$Surviving * table$Spawning
  table$Caught <- table$Surviving *  table$Vulnerability * population$pi
  table$Harvested <- table$Caught * table$Retention
  table$Released <- table$Caught * (1 - table$Retention)
  table$HandlingMortality <- table$Released * population$Hm

  table <- table[c(x, "Surviving", "Spawning", "Caught", "Harvested",
                         "Released", "HandlingMortality")]

  breaks <- seq(0, max(table[[1]] + binwidth), by = binwidth)
  table[[1]] <- cut(table[[1]], breaks = breaks)
  table[[1]] <- as.integer(table[[1]]) * binwidth
  table <- split(table, table[[1]])
  table <- lapply(table, sum_fish)
  table <- do.call("rbind", table)
  row.names(table) <- NULL

  as_tibble(table)
}

#' Stock-Recruitment Parameters
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @inheritParams ypr_tabulate_sr
#' @param all A flag indicating whether to include all parameter values.
#' @return A data frame of stock-recruitment parameters.
#' @export
#' @examples
#' ypr_tabulate_sr(ypr_population()) # Beverton-Holt
#' ypr_tabulate_sr(ypr_population(BH = 0L)) # Ricker
ypr_tabulate_sr.ypr_population <- function(object, Ly = 0, harvest = TRUE,
                                           biomass = FALSE, all = FALSE,...) {
  sr <- ypr_sr(object)
  sr$BH <- object$BH

  pi <- object$pi
  object$pi <- ypr_optimise(object, Ly = Ly, harvest = harvest, biomass = biomass)
  optimal_sr <- ypr_sr(object)

  table <- with(sr, {
    data <- data.frame(
      Type = c("unfished", "actual", "optimal"),
      pi = c(0, pi, object$pi),
      u = ypr_exploitation(object, c(0, pi, object$pi)),
      Eggs = c(phi * R0, phiF * R0F, optimal_sr$phiF * optimal_sr$R0F),
      stringsAsFactors = FALSE
    )
    fun <- if(BH == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data$Spawners = c(S0, S0F, optimal_sr$S0F)
    data$Fecundity <- data$Eggs / data$Spawners * 2
    data
  })

  if(all) table <- add_parameters(table, object)

  as_tibble(table)
}

#' Stock-Recruitment Parameters
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @inheritParams ypr_tabulate_sr
#' @param all A flag indicating whether to include all parameter values.
#' @return A table of stock-recruitment parameters.
#' @export
#' @examples
#' ypr_tabulate_sr(ypr_populations(Rk = c(2.5, 4.6)))
ypr_tabulate_sr.ypr_populations <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                            all = FALSE, ...) {
  check_flag(all)

  sr <- lapply(object, ypr_tabulate_sr, Ly = Ly, harvest = harvest,
               biomass = biomass, all = TRUE,...)

  sr <- do.call("rbind", sr)

  if(!all) sr <- drop_constant_parameters(sr)

  as_tibble(sr)
}

#' Tabulate Yield
#'
#' @inheritParams ypr_tabulate_yield
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @inheritParams ypr_tabulate_sr.ypr_population
#' @param type A string indicating whether to include 'both' or just the 'actual' or 'optimal' yield.
#' @return A data frame.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yield}}
#' @export
#' @examples
#' ypr_tabulate_yield(ypr_population())
ypr_tabulate_yield.ypr_population <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                              type = "both", all = FALSE, ...) {

  check_scalar(type, c("both", "actual", "optimal"))

  actual_pi <- object$pi

  actual_yield <- ypr_yield(object, Ly = Ly, harvest = harvest,
                            biomass = biomass)

  if(type == "actual") {
    yield <- data.frame(Type = "actual",
                        pi = actual_pi,
                        u = ypr_exploitation(object, actual_pi),
                        Yield = actual_yield,
                        Age = attr(actual_yield, "Age"),
                        Length = attr(actual_yield, "Length"),
                        Weight = attr(actual_yield, "Weight"),
                        Effort = attr(actual_yield, "Effort"),
                        stringsAsFactors = FALSE)
  } else {
    optimal_pi <- ypr_optimize(object, Ly = Ly, harvest = harvest,
                               biomass = biomass)

    object <- ypr_population_update(object, pi = optimal_pi)

    optimal_yield <- ypr_yield(object, Ly = Ly, harvest = harvest,
                               biomass = biomass)
    yield <- data.frame(Type = c("actual", "optimal"),
                        pi = c(actual_pi, optimal_pi),
                        u = ypr_exploitation(object, c(actual_pi, optimal_pi)),
                        Yield = c(actual_yield, optimal_yield),
                        Age = c(attr(actual_yield, "Age"), attr(optimal_yield, "Age")),
                        Length = c(attr(actual_yield, "Length"), attr(optimal_yield, "Length")),
                        Weight = c(attr(actual_yield, "Weight"), attr(optimal_yield, "Weight")),
                        Effort = c(attr(actual_yield, "Effort"), attr(optimal_yield, "Effort")),
                        stringsAsFactors = FALSE)

    if(type == "optimal")
      yield <- yield[yield$Type == "optimal", ]
  }

  if(all) yield <- add_parameters(yield, object)

  as_tibble(yield)
}

#' Tabulate Yield
#'
#' @inheritParams ypr_tabulate_yield
#' @inheritParams ypr_tabulate_yield.ypr_population
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @return A data frame.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yield}}
#' @export
#' @examples
#' ypr_tabulate_yield(ypr_populations(Rk = c(3,5)))
ypr_tabulate_yield.ypr_populations <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                               type = "both", all = FALSE, ...) {

  check_flag(all)

  yield <- lapply(object, ypr_tabulate_yield, Ly = Ly, harvest = harvest,
                  biomass = biomass, type = type, all = TRUE, ...)

  yield <- do.call("rbind", yield)

  if(!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}

#' Tabulate Yields
#'
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yields
#' @inheritParams ypr_yield
#' @inheritParams ypr_tabulate_yield.ypr_population
#' @return A data frame.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yields}}
#' @export
#' @examples
#' ypr_tabulate_yields(ypr_population())
ypr_tabulate_yields.ypr_population <- function(object, pi = seq(0, 1, length.out = 100),
                                               Ly = 0, harvest = TRUE, biomass = FALSE, all = FALSE, ...) {

  check_vector(pi, c(0, 1), length = TRUE)

  yields <- lapply(pi, tabulate_yield_pi, object = object, Ly = Ly,
                   harvest = harvest, biomass = biomass, all = all)

  yields <- do.call(rbind, yields)

  as_tibble(yields)
}

#' Tabulate Yields
#'
#' @inheritParams ypr_tabulate_yields
#' @inheritParams ypr_tabulate_yields.ypr_population
#' @inheritParams ypr_schedule
#' @inheritParams ypr_yield
#' @return A data frame.
#' @seealso \code{\link{ypr_population}} and \code{\link{ypr_yield}}
#' @export
#' @examples
#' ypr_tabulate_yields(ypr_populations(Rk = c(3,5)), pi = seq(0, 1, length.out = 10))
ypr_tabulate_yields.ypr_populations <- function(object, pi = seq(0, 1, length.out = 100),
                                                Ly = 0, harvest = TRUE, biomass = FALSE,
                                                all = FALSE, ...) {

  check_flag(all)

  yield <- lapply(object, ypr_tabulate_yields, pi = pi, Ly = Ly, harvest = harvest,
                  biomass = biomass, all = TRUE,...)

  yield <- do.call("rbind", yield)

  if(!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}
