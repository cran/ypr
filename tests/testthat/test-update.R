test_that("ypr_update population works", {
  expect_identical(ypr_update(ypr_population(), Rk = 2.5), ypr_population(Rk = 2.5))
})

test_that("ypr_update populations works", {
  expect_identical(ypr_update(ypr_populations(), Rk = 2.5), ypr_populations(Rk = 2.5))
})

test_that("ypr_update ecotypes works", {
  expect_identical(ypr_update(ypr_ecotypes(), Rk = 2.5), ypr_ecotypes(Rk = 2.5))
})

test_that("update population works", {
  expect_identical(update(ypr_population(), Rk = 2.5), ypr_population(Rk = 2.5))
})

test_that("update populations works", {
  expect_identical(update(ypr_populations(), Rk = 2.5), ypr_populations(Rk = 2.5))
})

test_that("update ecotypes works", {
  expect_identical(update(ypr_ecotypes(), Rk = 2.5), ypr_ecotypes(Rk = 2.5))
})

test_that("ypr_update population works no update", {
  expect_identical(ypr_update(ypr_population(Rk = 2.5)), ypr_population(Rk = 2.5))
})

test_that("ypr_update populations works no update", {
  expect_identical(ypr_update(ypr_populations(Rk = 2.5)), ypr_populations(Rk = 2.5))
})

test_that("ypr_update ecotypes works", {
  expect_identical(ypr_update(ypr_ecotypes(Rk = 2.5)), ypr_ecotypes(Rk = 2.5))
})

test_that("ypr_update population errors if multiple values", {
  expect_error(ypr_update(ypr_population(), Rk = c(2.5, 1.5)),
               "`Rk` must be a scalar \\(length 1\\)\\.")
})

test_that("ypr_update population errors if missing value", {
  expect_error(ypr_update(ypr_population(), Rk = NA_real_),
               "`Rk` must not have any missing values\\.")
})

test_that("ypr_update population errors if outside range", {
  expect_error(ypr_update(ypr_population(), Rk = 1001),
               "`Rk` must be between 0 and 100, not 1001\\.")
})

test_that("ypr_update populations renames", {
  expect_named(ypr_update(ypr_populations(Rk = c(2.5, 1.5), names = c("t1", "t2")), Linf = 200),
               c("Rk_1_5", "Rk_2_5"))
})

test_that("ypr_update ecotypes renames", {
  expect_named(ypr_update(ypr_ecotypes(k = c(2.5, 1.5), names = c("t1", "t2")), Linf = 200),
               c("k_2_5", "k_1_5"))
})

test_that("ypr_update populations works scalar with multiple parameters", {
  expect_identical(ypr_update(ypr_populations(Rk = c(2.5, 1.5)), Linf = 200), ypr_populations(Rk = c(2.5, 1.5), Linf = 200))
})

test_that("ypr_update populations works on multiple values with scalar", {
  expect_identical(ypr_update(ypr_populations(Rk = c(2.5, 1.5)), Rk = 2.5), ypr_populations(Rk = c(2.5, 2.5), expand = FALSE))
})

test_that("ypr_update ecotypes works multiple scalar if different", {
  expect_identical(ypr_update(ypr_populations(Rk = c(2.5, 1.5)), Linf = 200), ypr_populations(Rk = c(2.5, 1.5), Linf = 200))
})

test_that("ypr_update ecotypes errors if end up with multiple the same", {
  expect_error(ypr_update(ypr_ecotypes(Rk = c(2.5, 1.5)), Rk = 2.5),
               "`Rk` must be the same across all elements\\.")
})
