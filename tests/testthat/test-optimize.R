test_that("optimize", {
  expect_equal(ypr_optimize(ypr_population(n = ypr:::inst2inter(0.2))), 0.1060144, tolerance = 1e-06)
  expect_equal(ypr_optimize(ypr_population(n = ypr:::inst2inter(0.2)), biomass = TRUE), 0.0938727, tolerance = 1e-06)
  expect_identical(ypr_optimise, ypr_optimize)
})
