context("as-ypr-populations")

test_that("as_ypr_populations", {
  expect_identical(as_ypr_populations(as.data.frame(ypr_populations(Rk = c(4, 5)))), ypr_populations(Rk = c(4, 5)))
})
