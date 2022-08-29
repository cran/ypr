test_that("as.data.frame ypr_population", {
  data <- as.data.frame(ypr_population())
  expect_identical(class(data), "data.frame")
  expect_snapshot_data(data, "population")
})

test_that("as.data.frame ypr_populations", {
  data <- as.data.frame(ypr_populations(Rk = c(3, 4)))
  expect_identical(class(data), "data.frame")
  expect_snapshot_data(data, "populations")
})

test_that("as.data.frame ypr_ecotypes", {
  data <- as.data.frame(as_ypr_ecotypes(ypr_populations(Linf = c(100, 200), RPR = c(0.75, 0.25), expand = FALSE)))
  expect_identical(class(data), "data.frame")
  expect_snapshot_data(data, "ecotypes")
})
