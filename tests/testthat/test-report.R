test_that("report", {
  expect_identical(integer_parameters(), c("tmax", "tR", "BH"))
  # used to create temp package for testing
  suppressMessages(create_local_package())
  report <- suppressMessages(ypr_report(ypr_population(), ask = FALSE))
  expect_type(report, "character")
  expect_identical(report[1], "---")
  expect_identical(report[2], "title: \"Population Report\"")
  expect_identical(
    report[55],
    "ypr_plot_yield(population, Ly = 0, harvest = TRUE, biomass = FALSE)"
  )
  expect_identical(
    report[56],
    "knitr::kable(ypr_tabulate_yield(population, Ly = 0, harvest = TRUE, biomass = FALSE))"
  )
})

test_that("report setting yield parameters", {
  expect_identical(integer_parameters(), c("tmax", "tR", "BH"))
  # used to create temp package for testing
  suppressMessages(create_local_package())
  report <- suppressMessages(
    ypr_report(
      ypr_population(),
      Ly = 10,
      harvest = FALSE,
      biomass = TRUE,
      file = "file1",
      ask = FALSE
    )
  )
  expect_type(report, "character")
  expect_identical(
    report[55],
    "ypr_plot_yield(population, Ly = 10, harvest = FALSE, biomass = TRUE)"
  )
  expect_identical(
    report[56],
    "knitr::kable(ypr_tabulate_yield(population, Ly = 10, harvest = FALSE, biomass = TRUE))"
  )
})
