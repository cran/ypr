test_that("check_population", {
  expect_identical(check_population(ypr_population()), ypr_population())
  expect_error(check_population(ypr_populations()))
})

test_that("check_populations", {
  expect_identical(check_populations(ypr_populations()), ypr_populations())
  expect_error(check_populations(ypr_population()))
})

test_that("check_ecotypes", {
  expect_identical(check_ecotypes(ypr_ecotypes()), ypr_ecotypes())
  expect_error(check_ecotypes(ypr_populations()))
})

