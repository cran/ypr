test_that("tabulate schedule population", {
  schedule <- ypr_tabulate_schedule(ypr_population())
  expect_s3_class(schedule, "tbl_df")
  expect_snapshot_data(schedule, "population")
})

test_that("tabulate schedule complex population", {
  schedule <- ypr_tabulate_schedule(ypr_population(Rmax = 100, Rk = 2, Wa = 0.01,
                                                   n = ypr:::inst2inter(0.2), fa = 0.1))
  expect_s3_class(schedule, "tbl_df")
  expect_equal(schedule$Weight[20], 8579.51642)
  expect_equal(schedule$Fecundity[20], 857.9516, tolerance = 1e-6)
  expect_snapshot_data(schedule, "population_complex")
})

test_that("tabulate schedule with biphasic length loss", {
  schedule <- ypr_tabulate_schedule(ypr_population(Linf = 300, L2 = 150))
  expect_equal(
    schedule$Length,
    c(
      41.7876070724827, 77.7545337954846, 108.711554513468, 135.356509171792,
      147.236655274101, 140.65696597406, 134.993774911116, 130.11942119122,
      125.924026064589, 122.313016014843, 119.204990862075, 116.529888822159,
      114.227407158651, 112.245642825298, 110.539922456186, 109.071795328941,
      107.808166600115, 106.720551273975, 105.784432087484, 104.978706836786
    )
  )
  expect_snapshot_data(schedule, "populationbiphasic")
})

test_that("tabulate schedule low mortality", {
  schedule <- ypr_tabulate_schedule(ypr_population(n = 0.1))
  expect_s3_class(schedule, "tbl_df")
  expect_snapshot_data(schedule, "lowmortality")
})

test_that("tabulate schedule errors populations", {
  expect_error(ypr_tabulate_schedule(ypr_populations()),
               "no applicable method for 'ypr_tabulate_schedule' applied to an object of class \"ypr_populations\"")
})

test_that("tabulate schedule ecotypes 1", {
  schedule <- ypr_tabulate_schedule(ypr_ecotypes())
  expect_s3_class(schedule, "tbl_df")
  expect_snapshot_data(schedule, "ecotypes1")
})

test_that("tabulate schedule ecotypes 2", {
  schedule <- ypr_tabulate_schedule(ypr_ecotypes(Linf = c(100, 800)))
  expect_s3_class(schedule, "tbl_df")
  expect_snapshot_data(schedule, "ecotypes2")
})

test_that("tabulate schedule ecotypes 2 diff proportion", {
  schedule <- ypr_tabulate_schedule(ypr_ecotypes(Linf = c(70, 80), RPR = c(0.8, 0.2)))
  expect_s3_class(schedule, "tbl_df")
  expect_snapshot_data(schedule, "ecotypes2rpr")
})

test_that("tabulate schedule ecotypes 3 produces 60 rows", {
  schedule <- ypr_tabulate_schedule(ypr_ecotypes(Linf = c(10, 100, 1000)))
  expect_s3_class(schedule, "tbl_df")
  expect_equal(nrow(schedule), 60)
  expect_snapshot_data(schedule, "ecotypes3")
})
