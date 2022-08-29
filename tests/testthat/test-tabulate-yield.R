test_that("ypr_tabulate_yield population", {
  yield <- ypr_tabulate_yield(ypr_population())

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "population")
})

test_that("ypr_tabulate_yield population all", {
  yield <- ypr_tabulate_yield(ypr_population(), all = TRUE)

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "populationall")
})

test_that("ypr_tabulate_yield almost extinct population", {
  yield <- ypr_tabulate_yield(ypr_population(Linf = 130), all = TRUE)

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "almostpopulationextinct")
})

test_that("ypr_tabulate_yield extinct population", {
  yield <- ypr_tabulate_yield(ypr_population(Linf = 140), all = TRUE)

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "populationextinct")
})

test_that("ypr_tabulate_yield population inst2inter", {
  yield <- ypr_tabulate_yield(ypr_population(n = ypr:::inst2inter(0.2)), pi = seq(0, 1, length.out = 10))

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "inst2inter")
})

test_that("ypr_tabulate_yield populations", {
  yield <- ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)))

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "populations")
})

test_that("ypr_tabulate_yield populations all", {
  yield <- ypr_tabulate_yield(ypr_populations(Rk = c(3, 5)), all = TRUE)

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "populationsall")
})

test_that("ypr_tabulate_yield ecotypes 1", {
  yield <- ypr_tabulate_yield(ypr_ecotypes())

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "ecotypes1")
})

test_that("ypr_tabulate_yield ecotypes 2", {
  yield <- ypr_tabulate_yield(ypr_ecotypes(Ls = c(40, 60)))

  expect_s3_class(yield, "tbl_df")
  expect_snapshot_data(yield, "ecotypes")
})
