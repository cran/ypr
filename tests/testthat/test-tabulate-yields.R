test_that("ypr_tabulate_yields populations", {
  yields <- ypr_tabulate_yields(ypr_populations(Rk = c(3, 5)), pi = seq(0, 1, length.out = 2))

  expect_s3_class(yields, "tbl_df")
  expect_snapshot_data(yields, "populations01")
})

test_that("ypr_tabulate_yields populations all", {
  yields <- ypr_tabulate_yields(ypr_populations(Rk = c(3, 5)), pi = seq(0, 1, length.out = 2),
                                all = TRUE)

  expect_s3_class(yields, "tbl_df")
  expect_snapshot_data(yields, "populations01all")
})

test_that("ypr_tabulate_yields ecotypes", {
  yields <- ypr_tabulate_yields(ypr_ecotypes())

  expect_s3_class(yields, "tbl_df")
  expect_snapshot_data(yields, "ecotypes")
})
