test_that("ypr_population works", {
  population <- ypr_population()
  expect_s3_class(population, "ypr_population")
  expect_length(population, 32L)
  expect_snapshot_output(population)
})

test_that("ypr_population set values", {
  population <- ypr_population(Rk = 2.5)
  expect_identical(population$Rk, 2.5)
})

test_that("ypr_population errors multiple values", {
  expect_error(ypr_population(Rk = c(2.5, 5)),
               "`Rk` must be a scalar \\(length 1\\)\\.")
})

test_that("ypr_population errors outside range", {
  expect_error(ypr_population(pi = 1.1),
               "`pi` must be between 0 and 1, not 1.1.")
})

test_that("ypr_population errors unrecognised parameter", {
  expect_error(ypr_population(thing = c(2.5, 5)),
               "unused argument")
})

test_that("ypr_population errors missing value", {
  expect_error(ypr_population(Rk = NA_real_),
               "`Rk` must not have any missing values\\.")
})
