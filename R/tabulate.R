#' Tabulate Stock-Recruitment Parameters
#'
#' @inheritParams params
#' @return A data.frame of stock-recruitment parameters.
#' @family tabulate
#' @export
#' @examples
#' ypr_tabulate_sr(ypr_population()) # Beverton-Holt
#' ypr_tabulate_sr(ypr_population(BH = 0L)) # Ricker
#' ypr_tabulate_sr(ypr_populations(Rk = c(2.5, 4.6)))
ypr_tabulate_sr <- function(object, ...) {
  UseMethod("ypr_tabulate_sr")
}

#' Tabulate Yield
#'
#' @inheritParams params
#'
#' @return A data frame.
#' @family tabulate
#' @export
#' @examples
#' ypr_tabulate_yield(ypr_population())
#' ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)))
ypr_tabulate_yield <- function(object, ...) {
  UseMethod("ypr_tabulate_yield")
}

#' Tabulate Yields
#'
#' @inheritParams params
#'
#' @return A data frame.
#' @family tabulate
#' @export
#' @examples
#' ypr_tabulate_yields(ypr_population())
#' ypr_tabulate_yields(ypr_populations(Rk = c(3, 5)), pi = seq(0, 1, length.out = 10))
ypr_tabulate_yields <- function(object, ...) {
  UseMethod("ypr_tabulate_yields")
}

#' Tabulate Population Parameters
#'
#' @inheritParams params
#' @return A table of population parameters
#' @family tabulate
#' @seealso [ypr_detabulate_parameters()]
#' @export
#' @examples
#' ypr_tabulate_parameters(ypr_population())
ypr_tabulate_parameters <- function(population) {
  chk_population(population)

  parameters <- data.frame(
    Parameter = names(population),
    Value = unname(unlist(population)),
    stringsAsFactors = FALSE
  )

  pattern <- "(\\\\item[{])([^}]+)([}])([{])([^}]+)([}])"
  rd <- tools::Rd_db("ypr")$ypr_population.Rd
  rd <- paste0(as.character(rd), collapse = "")
  gp <- gregexpr(pattern, rd)
  rd <- regmatches(rd, gp)[[1]]

  data <- data.frame(
    Parameter = sub(pattern, "\\2", rd),
    Description = sub(pattern, "\\5", rd),
    stringsAsFactors = FALSE
  )

  parameters <- merge(parameters, data, by = "Parameter", sort = FALSE)

  as_tibble(parameters)
}

#' Detabulate Population Parameters
#'
#' @param x A data frame with columns Parameter and Value specifying
#' one or more parameters and their values.

#' @return An object of class [ypr_population()]
#' @seealso [ypr_tabulate_parameters()]
#' @export
#' @examples
#' ypr_detabulate_parameters(ypr_tabulate_parameters(ypr_population()))
ypr_detabulate_parameters <- function(x) {
  chk_s3_class(x, "data.frame")
  chk_superset(colnames(x), c("Parameter", "Value"))
  chk_s3_class(x$Parameter, "character")
  chk_not_any_na(x$Parameter)
  chk_subset(x$Parameter, .parameters$Parameter)
  chk_unique(x$Parameter)

  chk_numeric(x$Value)
  chk_not_any_na(x$Value)
  chk_range(x$Value, c(min(.parameters$Lower), max(.parameters$Upper)))

  x <- merge(x, .parameters[c("Parameter", "Integer")], by = "Parameter", sort = FALSE)

  parameters <- as.list(x$Value)
  names(parameters) <- x$Parameter

  parameters <- mapply(function(x, y) if (y == 1) as.integer(x) else x,
    parameters, x$Integer,
    SIMPLIFY = FALSE
  )

  population <- do.call("ypr_population", parameters)
  population
}

#' Tabulate Fish Numbers
#'
#' Produces a data frame of the number of fish in the
#' 'Survivors', 'Spawners', 'Caught', 'Harvested', 'Released' and 'HandlingMortalities' categories by
#' 'Length', 'Age' or 'Weight' class.
#'
#' @inheritParams params
#' @inheritParams ypr_plot_schedule
#' @return A data frame
#' @family tabulate
#' @export
#' @examples
#' ypr_tabulate_fish(ypr_population())
ypr_tabulate_fish <- function(population, x = "Age", binwidth = 1L) {
  chk_population(population)
  chk_string(x)
  chk_subset(x, c("Age", "Length", "Weight"))
  chk_whole_number(binwidth)
  chk_range(binwidth, c(1L, 1000L))

  table <- ypr_tabulate_schedule(population = population)
  table <- as.data.frame(table)

  R0F <- sr(table, population)$R0F
  R0F <- max(0, R0F)

  table$Survivors <- table$FishedSurvivorship * R0F
  table$Spawners <- table$Survivors * table$Spawning
  table$Caught <- table$Survivors * table$Vulnerability * population$pi
  table$Harvested <- table$Caught * table$Retention
  table$Released <- table$Caught * (1 - table$Retention)
  table$HandlingMortalities <- table$Released * population$Hm

  table <- table[c(
    x, "Survivors", "Spawners", "Caught", "Harvested",
    "Released", "HandlingMortalities"
  )]

  breaks <- seq(0, max(table[[1]] + binwidth), by = binwidth)
  table[[1]] <- cut(table[[1]], breaks = breaks)
  table[[1]] <- as.integer(table[[1]]) * binwidth
  table <- split(table, table[[1]])
  table <- lapply(table, sum_fish)
  table <- do.call("rbind", table)
  row.names(table) <- NULL

  as_tibble(table)
}

#' Tablulate Biomass (and Eggs)
#'
#' Produces a data frame of the 'Weight' and 'Fecundity' and the number of
#' 'Survivors' and 'Spawners' and the total 'Biomass' and 'Eggs' by
#' 'Age' class.
#'
#' @inheritParams params
#' @return A data frame
#' @family tabulate
#' @export
#' @examples
#' ypr_tabulate_biomass(ypr_population())
ypr_tabulate_biomass <- function(population) {
  schedule <- ypr_tabulate_schedule(population)
  fish <- ypr_tabulate_fish(population)

  schedule <- schedule[c("Age", "Length", "Weight", "Fecundity")]
  fish <- fish[c("Survivors", "Spawners")]

  biomass <- cbind(schedule, fish)
  biomass$Biomass <- biomass$Weight * biomass$Survivors
  biomass$Eggs <- (biomass$Fecundity * biomass$Spawners) / 2

  as_tibble(biomass)
}


#' @describeIn ypr_tabulate_sr Tabulate Stock-Recruitment Parameters
#' @export
ypr_tabulate_sr.ypr_population <- function(object, Ly = 0, harvest = TRUE,
                                           biomass = FALSE, all = FALSE, ...) {
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
    fun <- if (BH == 1L) bh else ri
    data$Recruits <- fun(data$Eggs, alpha, beta)
    data$Spawners <- c(S0, S0F, optimal_sr$S0F)
    data$Fecundity <- data$Eggs / data$Spawners * 2
    data
  })

  if (all) table <- add_parameters(table, object)

  as_tibble(table)
}

#' @describeIn ypr_tabulate_sr Tabulate Stock-Recruitment Parameters
#' @export
ypr_tabulate_sr.ypr_populations <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                            all = FALSE, ...) {
  chk_flag(all)

  sr <- lapply(object, ypr_tabulate_sr,
    Ly = Ly, harvest = harvest,
    biomass = biomass, all = TRUE, ...
  )

  sr <- do.call("rbind", sr)

  if (!all) sr <- drop_constant_parameters(sr)

  as_tibble(sr)
}

#' @describeIn ypr_tabulate_yield Tabulate Yield
#' @export
ypr_tabulate_yield.ypr_population <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                              type = "both", all = FALSE, ...) {
  chk_string(type)
  chk_subset(type, c("both", "actual", "optimal"))
  actual_pi <- object$pi

  actual_yield <- ypr_yield(object,
    Ly = Ly, harvest = harvest,
    biomass = biomass
  )

  if (type == "actual") {
    yield <- data.frame(
      Type = "actual",
      pi = actual_pi,
      u = ypr_exploitation(object, actual_pi),
      Yield = actual_yield,
      Age = attr(actual_yield, "Age"),
      Length = attr(actual_yield, "Length"),
      Weight = attr(actual_yield, "Weight"),
      Effort = attr(actual_yield, "Effort"),
      stringsAsFactors = FALSE
    )
  } else {
    optimal_pi <- ypr_optimize(object,
      Ly = Ly, harvest = harvest,
      biomass = biomass
    )

    object <- ypr_population_update(object, pi = optimal_pi)

    optimal_yield <- ypr_yield(object,
      Ly = Ly, harvest = harvest,
      biomass = biomass
    )
    yield <- data.frame(
      Type = c("actual", "optimal"),
      pi = c(actual_pi, optimal_pi),
      u = ypr_exploitation(object, c(actual_pi, optimal_pi)),
      Yield = c(actual_yield, optimal_yield),
      Age = c(attr(actual_yield, "Age"), attr(optimal_yield, "Age")),
      Length = c(attr(actual_yield, "Length"), attr(optimal_yield, "Length")),
      Weight = c(attr(actual_yield, "Weight"), attr(optimal_yield, "Weight")),
      Effort = c(attr(actual_yield, "Effort"), attr(optimal_yield, "Effort")),
      stringsAsFactors = FALSE
    )

    if (type == "optimal") {
      yield <- yield[yield$Type == "optimal", ]
    }
  }

  if (all) yield <- add_parameters(yield, object)

  as_tibble(yield)
}

#' @describeIn ypr_tabulate_yield Tabulate Yield
#' @export
ypr_tabulate_yield.ypr_populations <- function(object, Ly = 0, harvest = TRUE, biomass = FALSE,
                                               type = "both", all = FALSE, ...) {
  chk_flag(all)

  yield <- lapply(object, ypr_tabulate_yield,
    Ly = Ly, harvest = harvest,
    biomass = biomass, type = type, all = TRUE, ...
  )

  yield <- do.call("rbind", yield)

  if (!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}

#' @describeIn ypr_tabulate_yields Tabulate Yields
#' @export
ypr_tabulate_yields.ypr_population <- function(object, pi = seq(0, 1, length.out = 100),
                                               Ly = 0, harvest = TRUE, biomass = FALSE, all = FALSE, ...) {
  chk_number(Ly)
  chk_numeric(pi)
  chk_not_empty(pi)
  chk_not_any_na(pi)
  chk_range(pi, c(0, 1))

  yields <- lapply(pi, tabulate_yield_pi,
    object = object, Ly = Ly,
    harvest = harvest, biomass = biomass, all = all
  )

  yields <- do.call(rbind, yields)

  as_tibble(yields)
}

#' @describeIn ypr_tabulate_yields Tabulate Yields
#' @export
ypr_tabulate_yields.ypr_populations <- function(object, pi = seq(0, 1, length.out = 100),
                                                Ly = 0, harvest = TRUE, biomass = FALSE,
                                                all = FALSE, ...) {
  chk_flag(all)

  yield <- lapply(object, ypr_tabulate_yields,
    pi = pi, Ly = Ly, harvest = harvest,
    biomass = biomass, all = TRUE, ...
  )

  yield <- do.call("rbind", yield)

  if (!all) yield <- drop_constant_parameters(yield)

  as_tibble(yield)
}
