context("as-ypr-population")

test_that("as_ypr_population", {
  expect_identical(as_ypr_population(as.data.frame(ypr_population())), ypr_population())
})
