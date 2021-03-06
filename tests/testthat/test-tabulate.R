check_tabulated_yield <- function(x, exclusive = TRUE, order = TRUE, x_name = substitute(x)) {
  x_name <- deparse(x_name)

  chk::check_data(
    x,
    values = list(
      Type = c("actual", "actual", "optimal"),
      pi = c(0, 1),
      u = c(0, 1),
      Yield = c(0, .Machine$double.xmax),
      Age = c(0, 100),
      Length = c(0, .Machine$double.xmax),
      Weight = c(0, .Machine$double.xmax),
      Effort = c(0, .Machine$double.xmax)
    ),
    nrow = TRUE,
    exclusive = exclusive,
    order = order,
    x_name = x_name
  )

  x
}

test_that("ypr_tabulate_yield", {
  yield <- ypr_tabulate_yield(ypr_population())
  expect_identical(check_tabulated_yield(yield), yield)
  expect_identical(yield$Type, c("actual", "optimal"))

  yield <- ypr_tabulate_yield(ypr_population(), all = TRUE)
  expect_identical(check_tabulated_yield(yield, exclusive = FALSE), yield)
  expect_identical(ncol(yield), 38L)
  expect_identical(yield$Linf, c(100, 100))

  yield <- ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)))
  expect_identical(check_tabulated_yield(yield, exclusive = FALSE), yield)
  expect_identical(colnames(yield), c("Type", "pi", "u", "Yield", "Age", "Length", "Weight", "Effort", "Rk"))
  expect_identical(nrow(yield), 4L)

  yield <- ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)), all = TRUE)
  expect_identical(check_tabulated_yield(yield, exclusive = FALSE), yield)
  expect_identical(ncol(yield), 38L)
  expect_identical(nrow(yield), 4L)

  yields <- ypr_tabulate_yields(ypr_population(n = ypr:::inst2inter(0.2)), pi = seq(0, 1, length.out = 10))
  expect_identical(colnames(yields), c("pi", "u", "Yield", "Age", "Length", "Weight", "Effort"))
  expect_identical(nrow(yields), 10L)

  expect_error(chk::check_data(
    yields,
    values = list(
      pi = c(0, 1),
      u = c(0, 1),
      Yield = c(0, .Machine$double.xmax),
      Age = c(0, 100, NA),
      Length = c(0, .Machine$double.xmax, NA),
      Weight = c(0, .Machine$double.xmax, NA),
      Effort = c(0, Inf)
    ),
    nrow = TRUE,
    exclusive = TRUE,
    order = TRUE
  ), NA)

  expect_identical(yields$pi[1:2], c(0, 1 / 9))
  expect_equal(yields$Effort[1:2], c(0, 1.117905), tolerance = 1e-07)
  expect_equal(yields$Yield[1:2], c(0, 0.0738), tolerance = 1e-04)
  expect_equal(yields$Weight[1:2], c(NA, 3057.662), tolerance = 1e-07)

  yields <- ypr_tabulate_yields(ypr_populations(Rk = c(3, 5)), pi = seq(0, 1, length.out = 2))
  expect_identical(ncol(yields), 8L)
  expect_identical(nrow(yields), 4L)

  yields <- ypr_tabulate_yields(ypr_populations(Rk = c(3, 5)),
    pi = seq(0, 1, length.out = 2),
    all = TRUE
  )
  expect_identical(ncol(yields), 37L)
  expect_identical(nrow(yields), 4L)

  sr <- ypr_tabulate_sr(ypr_population())

  expect_error(chk::check_data(
    sr,
    values = list(
      Type = c("unfished", "actual", "optimal"),
      pi = c(0, 1),
      u = c(0, 1),
      Eggs = c(0, .Machine$double.xmax),
      Recruits = c(0, .Machine$double.xmax),
      Spawners = c(0, .Machine$double.xmax),
      Fecundity = c(0, .Machine$double.xmax)
    ),
    nrow = TRUE,
    exclusive = TRUE,
    order = TRUE
  ), NA)

  expect_identical(sr$Type, c("unfished", "actual", "optimal"))

  fish <- ypr_tabulate_fish(ypr_population(n = ypr:::inst2inter(0.2)))
  expect_identical(colnames(fish), c(
    "Age", "Survivors", "Spawners", "Caught",
    "Harvested", "Released", "HandlingMortalities"
  ))
  expect_identical(fish[[1]], as.double(1:20))
  expect_equal(fish$Survivors[1:2], c(0.134, 0.110), tolerance = 0.001)

  fish <- ypr_tabulate_fish(ypr_population(), x = "Length")
  expect_identical(colnames(fish), c(
    "Length", "Survivors", "Spawners", "Caught",
    "Harvested", "Released", "HandlingMortalities"
  ))
  expect_identical(fish$Length[1:2], c(14, 26))

  sr <- ypr_tabulate_sr(ypr_populations(Rk = c(3, 5)))

  expect_error(chk::check_data(
    sr,
    values = list(
      Type = c("unfished", "actual", "optimal"),
      pi = c(0, 1),
      u = c(0, 1),
      Eggs = c(0, .Machine$double.xmax),
      Recruits = c(0, .Machine$double.xmax),
      Spawners = c(0, .Machine$double.xmax),
      Fecundity = c(0, .Machine$double.xmax),
      Rk = c(3, 3, 5)
    ),
    nrow = TRUE,
    exclusive = TRUE,
    order = TRUE
  ), NA)

  expect_identical(colnames(sr), c(
    "Type", "pi", "u", "Eggs", "Recruits",
    "Spawners", "Fecundity", "Rk"
  ))
  expect_identical(sr$Rk, c(3, 3, 3, 5, 5, 5))

  skip_if(length(tools::Rd_db("ypr")) == 0)
  parameters <- ypr_tabulate_parameters(ypr_population())
  expect_identical(parameters$Description[1], "The maximum age (yr).")

  expect_error(chk::check_data(
    parameters,
    values = list(
      Parameter = ypr:::.parameters$Parameter,
      Value = c(min(ypr:::.parameters$Lower), max(ypr:::.parameters$Upper)),
      Description = ""
    ),
    exclusive = TRUE,
    order = TRUE,
    nrow = nrow(ypr:::.parameters),
    key = "Parameter"
  ), NA)



  expect_identical(
    ypr_detabulate_parameters(ypr_tabulate_parameters(ypr_population(BH = 1L))),
    ypr_population(BH = 1L)
  )
})

test_that("ypr_tabulate_yield extinct population", {
  yield <- ypr_tabulate_yield(ypr_population(Linf = 130), all = TRUE)
  expect_equal(yield$pi, c(0.2, 0.102752704683603))
  expect_equal(yield$Yield, c(0.0273043505036034, 0.0770860806461869))

  yield <- ypr_tabulate_yield(ypr_population(Linf = 140), all = TRUE)
  expect_equal(yield$pi, c(0.2, 0.0926725376181979))
  expect_equal(yield$Yield, c(0, 0.0857039391276462))
})

test_that("ypr_tabulate_biomass", {
  biomass <- ypr_tabulate_biomass(ypr_population())

  expect_error(chk::check_data(
    biomass,
    values = list(
      Age = c(1L, 100L),
      Length = c(0, .Machine$double.xmax),
      Weight = c(0, .Machine$double.xmax),
      Fecundity = c(0, .Machine$double.xmax),
      Survivors = c(0, 1),
      Spawners = c(0, .Machine$double.xmax),
      Biomass = c(0, .Machine$double.xmax),
      Eggs = c(0, .Machine$double.xmax)
    ),
    nrow = TRUE,
    exclusive = TRUE,
    order = TRUE
  ), NA)
})
