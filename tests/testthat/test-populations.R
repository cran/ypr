test_that("ypr_populations works", {
  populations <- ypr_populations()
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 1L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations element is a population", {
  populations <- ypr_populations()
  expect_identical(populations[[1]], ypr_population())
})

test_that("ypr_populations creates an population with 2 elements", {
  populations <- ypr_populations(Linf = c(1, 2))
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 2L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations creates names", {
  populations <- ypr_populations(Linf = c(1, 2.5))
  expect_named(populations, c("Linf_1", "Linf_2_5"))
})

test_that("ypr_populations allows names to be specified", {
  populations <- ypr_populations(Linf = c(1, 2), names = c("t2", "t1"))
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 2L)
  expect_named(populations, c("t2", "t1"))
})

test_that("ypr_populations creates populations with 1 element when parameters same if expand", {
  populations <- ypr_populations(Linf = c(1, 1), expand = TRUE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 1L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations creates populations with 2 elements even when parameters same if not expand", {
  populations <- ypr_populations(Linf = c(1, 1), expand = FALSE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 2L)
  expect_named(populations, c("Pop_1", "Pop_2"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations make unique names for duplicates when not expand", {
  populations <- ypr_populations(Rk = c(2.5, 4.6, 2.5), expand = FALSE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 3L)
  expect_named(populations, c("Rk_2_5_Pop_1", "Rk_4_6", "Rk_2_5_Pop_2"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations names when not expand preserves order", {
  populations <- ypr_populations(Rk = c(2.5, 4.6, 2.5), Ls = c(60, 50, 50), expand = FALSE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 3L)
  expect_named(populations, c("Ls_60_Rk_2_5", "Ls_50_Rk_4_6", "Ls_50_Rk_2_5"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations names when expand reorders", {
  populations <- ypr_populations(Rk = c(2.5, 4.6, 2.5), Ls = c(60, 50, 50), expand = TRUE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 4L)
  expect_named(populations, c("Ls_50_Rk_2_5", "Ls_50_Rk_4_6", "Ls_60_Rk_2_5", "Ls_60_Rk_4_6"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations make unique names for duplicates even with multiple parameters when not expand", {
  populations <- ypr_populations(Rk = c(2.5, 4.6, 2.5), Ls = c(60, 50, 60), expand = FALSE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 3L)
  expect_named(populations, c("Ls_60_Rk_2_5_Pop_1", "Ls_50_Rk_4_6", "Ls_60_Rk_2_5_Pop_2"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations fails when different length parameters if not expand", {
  expect_error(ypr_populations(Linf = c(1, 1), k = c(0.1, 0.2, 0.3), expand = FALSE),
               "Non-scalar parameter values must all be the same length \\(not 2 and 3\\)\\.")
})

test_that("ypr_populations but works when different length parameters if expand", {
  populations <- ypr_populations(Linf = c(1, 1), k = c(0.2, 0.1, 0.3), expand = TRUE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 3L)
  expect_named(populations, c("k_0_1", "k_0_2", "k_0_3"))
  expect_snapshot_output(populations)
})

test_that("ypr_populations creates 2 populations when 2 parameters are provided", {
  populations <- ypr_populations(Linf = c(1, 2), RPR = c(1, 1))
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 2L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations creates 2 populations when 3 parameters are provided and not expand", {
  populations <- ypr_populations(Linf = c(1, 2), k2 = c(0.15, 0.25), RPR = c(2, 1), expand = FALSE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 2L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations creates 8 populations when 3 parameters are provided and expand", {
  populations <- ypr_populations(Linf = c(1, 2), k2 = c(0.15, 0.25), RPR = c(2, 1),
                                 expand = TRUE)
  expect_s3_class(populations, "ypr_populations")
  expect_length(populations, 8L)
  expect_snapshot_output(populations)
})

test_that("ypr_populations preserves RPR", {
  populations <- ypr_populations(Linf = c(1, 2), RPR = c(1, 3.5), expand = FALSE)
  expect_equal(populations[[1]]$RPR, 1)
  expect_equal(populations[[2]]$RPR, 3.5)
})

test_that("as_ypr_populations works if sr values are not the same", {
  populations <- ypr_populations(Rk = c(10, 20),
                                 BH = c(1L, 0L),
                                 tR = c(1L, 2L),
                                 Rmax = c(2, 3), expand = FALSE)

  expect_length(populations, 2L)
  expect_snapshot_output(populations)
})

test_that("as_ypr_populations works if fishery values are not the same", {

  populations <- ypr_populations(  pi = c(0.1, 0.2),
                                   Nc = c(0, 1),
                                   Hm = c(0, 1),
                                   Llo = c(10, 100),
                                   Lup = c(10, 100),
                                   rho = c(0, 1),
                                   q = c(0, 1), expand = FALSE)

  expect_length(populations, 2L)
  expect_snapshot_output(populations)
})
