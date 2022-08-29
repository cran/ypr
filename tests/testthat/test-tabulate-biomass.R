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
