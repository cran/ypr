test_that("ypr_sr population", {
  sr <- ypr_sr(ypr_population())
  expect_s3_class(sr, "tbl_df")
  expect_snapshot_data(sr, "pop")
})

test_that("ypr_sr population Rk", {
  sr <- ypr_sr(ypr_population(Rk = 0.000838134626091548))
  expect_s3_class(sr, "tbl_df")
  expect_snapshot_data(sr, "Rkegg")
})

test_that("ypr_sr population Rk1", {
  sr <- ypr_sr(ypr_population(Rk = 1))
  expect_s3_class(sr, "tbl_df")
  expect_snapshot_data(sr, "Rkegg1")
})

test_that("ypr_sr errors populations", {
  populations <- ypr_populations(Linf = c(10, 100))
  expect_error(ypr_sr(populations))
})

test_that("ypr_sr ecotype 1", {
  expect_identical(ypr_sr(ypr_ecotypes()), ypr_sr(ypr_population()))
})

test_that("ypr_sr ecotype 2 same", {
  expect_equal(ypr_sr(ypr_ecotypes(Linf = c(100, 100.00000000001))), ypr_sr(ypr_population()))
})

test_that("ypr_sr ecotype 2 diff weights", {
  expect_equal(ypr_sr(ypr_ecotypes(Linf = c(100, 50), RPR = c(1, 0.00000000001))), ypr_sr(ypr_population()))
})

test_that("ypr_sr ecotype 2 other diff weights", {
  expect_equal(ypr_sr(ypr_ecotypes(Linf = c(100, 50), RPR = c(0.0000000000001, 1))), ypr_sr(ypr_population(Linf = 50)))
})

test_that("ypr_sr works with 3 ecotypes", {
  ecotype <- ypr_ecotypes(Linf = c(10, 100, 1000), RPR = c(1, 2, 1))
  sr <- ypr_sr(ecotype)
  expect_snapshot_data(sr, "sr3")
})

test_that("ypr_sr intermediate", {
  sr_lower <- ypr_sr(ypr_population(Linf = 90))
  sr_upper <- ypr_sr(ypr_population(Linf = 110))
  sr <- ypr_sr(ypr_ecotypes(Linf = c(90, 110)))
  expect_lt(sr$alpha, sr_lower$alpha)
  expect_gt(sr$alpha, sr_upper$alpha)
  expect_identical(sr$beta, sr$alpha)
  expect_identical(sr_lower$beta, sr_lower$alpha)
  expect_identical(sr_lower$beta, sr_lower$alpha)
  expect_identical(sr$Rk, sr_lower$Rk)
  expect_identical(sr$Rk, sr_upper$Rk)
  expect_gt(sr$phi, sr_lower$phi)
  expect_lt(sr$phi, sr_upper$phi)
  expect_gt(sr$phiF, sr_lower$phiF)
  expect_lt(sr$phiF, sr_upper$phiF)
  expect_equal(sr$R0, sr_lower$R0)
  expect_equal(sr$R0, sr_upper$R0)
  expect_lt(sr$R0F, sr_lower$R0F)
  expect_gt(sr$R0F, sr_upper$R0F)
  expect_gt(sr$S0, sr_lower$S0)
  expect_lt(sr$S0, sr_upper$S0)
  expect_lt(sr$S0F, sr_lower$S0F)
  expect_gt(sr$S0F, sr_upper$S0F)
  expect_snapshot_data(sr, "srinter")
})

test_that("ypr_sr population low mortality", {
  sr <- ypr_sr(ypr_population(n = 0.1))
  expect_s3_class(sr, "tbl_df")
  expect_snapshot_data(sr, "poplow")
})

test_that("ypr_sr population bh n", {
  bh <- ypr_sr(ypr_population(n = ypr:::inst2inter(0.2)))
  expect_s3_class(bh, "data.frame")
  expect_identical(names(bh), c("alpha", "beta", "Rk", "phi", "phiF", "R0", "R0F", "S0", "S0F"))
  expect_equal(bh$alpha, 0.0006708921, tolerance = 1e-06, ignore_attr = TRUE)
  expect_equal(bh$beta, bh$alpha, ignore_attr = TRUE)
  expect_equal(bh$Rk, ypr_population()$Rk, ignore_attr = TRUE)
  expect_equal(bh$R0F, 0.1343839, ignore_attr = TRUE, tolerance = 1e-06)
  expect_equal(bh$phi, 4471.658, ignore_attr = TRUE, tolerance = 1e-07)
  expect_equal(bh$phiF, 1721.956, ignore_attr = TRUE, tolerance = 1e-06)
  expect_equal(bh$S0, 1.583806, ignore_attr = TRUE, tolerance = 1e-06)
  expect_equal(bh$S0F, 0.1746688, ignore_attr = TRUE, tolerance = 1e-06)
  expect_snapshot_data(bh, "bh")
})

test_that("ypr_sr population ri n", {
  ri <- ypr_sr(ypr_population(BH = 0L, n = ypr:::inst2inter(0.2)))
  expect_equal(ri$alpha, 0.0006708921, tolerance = 1e-06, ignore_attr = TRUE)
  expect_equal(ri$Rk, ypr_population()$Rk, ignore_attr = TRUE)
  expect_equal(ri$phi, 4471.658, ignore_attr = TRUE, tolerance = 1e-07)
  expect_equal(ri$phiF, 1721.956, ignore_attr = TRUE, tolerance = 1e-06)
  expect_equal(ri$beta, 0.0002468074, ignore_attr = TRUE, tolerance = 1e-06)
  expect_equal(ri$R0F, 0.3395686, ignore_attr = TRUE, tolerance = 1e-07)
  expect_snapshot_data(ri, "ri")
})

test_that("ypr_sr extinct population BH", {
  bh <- ypr_sr(ypr_population(Linf = 140))
  expect_equal(bh$R0F, 0, ignore_attr = TRUE, tolerance = 1e-06)
  expect_snapshot_data(bh, "bh0")
})

test_that("ypr_sr extinct population RI", {
  ri <- ypr_sr(ypr_population(Linf = 140, BH = 0L))
  expect_equal(ri$R0F, 0, ignore_attr = TRUE, tolerance = 1e-06)
  expect_snapshot_data(ri, "ri0")
})
