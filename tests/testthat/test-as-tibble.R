test_that("as_tibble ypr_population", {
  data <- as_tibble(ypr_population())
  expect_s3_class(data, "tbl_df")
  expect_snapshot_data(data, "population")
})

test_that("as_tibble ypr_populations", {
  data <- as_tibble(ypr_populations(Rk = c(3, 4)))
  expect_s3_class(data, "tbl_df")
  expect_snapshot_data(data, "populations")
})

test_that("as_tibble ypr_ecotypes", {
  data <- as_tibble(as_ypr_ecotypes(ypr_populations(Linf = c(100, 200), RPR = c(0.75, 0.25), expand = FALSE)))
  expect_s3_class(data, "tbl_df")
  expect_snapshot_data(data, "ecotypes")
})
