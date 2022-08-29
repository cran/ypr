test_that("is.ypr_population", {
  expect_true(is.ypr_population(ypr_population()))
  expect_false(is.ypr_population(ypr_populations()))
  expect_false(is.ypr_population(ypr_ecotypes()))
})

test_that("is.ypr_populations", {
  expect_false(is.ypr_populations(ypr_population()))
  expect_true(is.ypr_populations(ypr_populations()))
  expect_false(is.ypr_populations(ypr_ecotypes()))
})

test_that("is.ypr_ecotypes", {
  expect_false(is.ypr_ecotypes(ypr_population()))
  expect_false(is.ypr_ecotypes(ypr_populations()))
  expect_true(is.ypr_ecotypes(ypr_ecotypes()))
})

test_that("is_ypr_population", {
  expect_true(is_ypr_population(ypr_population()))
  expect_false(is_ypr_population(ypr_populations()))
  expect_false(is_ypr_population(ypr_ecotypes()))
})

test_that("is_ypr_populations", {
  expect_false(is_ypr_populations(ypr_population()))
  expect_true(is_ypr_populations(ypr_populations()))
  expect_false(is_ypr_populations(ypr_ecotypes()))
})

test_that("is_ypr_ecotypes", {
  expect_false(is_ypr_ecotypes(ypr_population()))
  expect_false(is_ypr_ecotypes(ypr_populations()))
  expect_true(is_ypr_ecotypes(ypr_ecotypes()))
})
