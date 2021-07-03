test_that("schedule", {
  schedule <- ypr_tabulate_schedule(ypr_population(
    Rmax = 100, Rk = 2, Wa = 0.01,
    n = ypr:::inst2inter(0.2), fa = 0.1
  ))
  expect_error(chk::check_data(
    schedule,
    values = list(
      Age = c(0L, 100L),
      Length = c(0, 1000),
      Weight = c(0, .Machine$double.xmax),
      Fecundity = c(0, .Machine$double.xmax),
      Spawning = c(0, 1),
      NaturalMortality = c(0, 1),
      Vulnerability = c(0, 1),
      Retention = c(0, 1),
      FishingMortality = c(0, 1),
      Survivorship = c(0, 1),
      FishedSurvivorship = c(0, 1)
    ),
    nrow = TRUE, exclusive = TRUE, order = TRUE
  ), NA)

  expect_true(all(diff(schedule$Age) == 1L))

  expect_equal(schedule$Weight[20], 8579.51642)
  expect_equal(schedule$Fecundity[20], 857.9516, tolerance = 1e-6)
})

test_that("schedule with biphasic length loss", {
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
})
