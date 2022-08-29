test_that("multiplication works", {
  expect_identical(
    ypr_detabulate_parameters(ypr_tabulate_parameters(ypr_population(BH = 1L))),
    ypr_population(BH = 1L)
  )
})
