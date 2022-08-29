test_that("ypr_population_names deprecated", {
  expect_deprecated(ypr_population_names(ypr_populations(Rk = c(2.5, 3, 2.5))))
})
