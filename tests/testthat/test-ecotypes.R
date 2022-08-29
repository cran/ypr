test_that("ypr_ecotypes works", {
  ecotypes <- ypr_ecotypes()
  expect_s3_class(ecotypes, "ypr_ecotypes")
  expect_length(ecotypes, 1L)
  expect_snapshot_output(ecotypes)
})

test_that("ypr_ecotypes element is a population", {
  ecotypes <- ypr_ecotypes()
  expect_identical(ecotypes[[1]], ypr_population())
})

test_that("ypr_ecotypes creates an ecotype with 2 elements", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2))
  expect_s3_class(ecotypes, "ypr_ecotypes")
  expect_length(ecotypes, 2L)
  expect_snapshot_output(ecotypes)
})

test_that("ypr_ecotypes errors if identical ecotypes", {
  expect_error(ypr_ecotypes(Linf = c(1, 1)),
               "ecotypes must have unique life-histories\\.")
})

test_that("ypr_ecotypes errors if identical ecotypes even with multiples", {
  expect_error(ypr_ecotypes(Linf = c(1, 2, 2), k = c(0.1, 0.2, 0.2)),
               "ecotypes must have unique life-histories\\.")
})

test_that("ypr_ecotypes creates names", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2.5))
  expect_named(ecotypes, c("Linf_1", "Linf_2_5"))
})

test_that("ypr_ecotypes allows names to be specified", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2), names = c("t2", "t1"))
  expect_s3_class(ecotypes, "ypr_ecotypes")
  expect_length(ecotypes, 2L)
  expect_named(ecotypes, c("t2", "t1"))
})

test_that("ypr_ecotypes creates an ecotype when 2 parameters are provided", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2), RPR = c(1, 1))
  expect_s3_class(ecotypes, "ypr_ecotypes")
  expect_length(ecotypes, 2L)
  expect_snapshot_output(ecotypes)
})

test_that("ypr_ecotypes creates an ecotype when 3 parameters are provided", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2), k2 = c(0.15, 0.25), RPR = c(2, 1))
  expect_s3_class(ecotypes, "ypr_ecotypes")
  expect_length(ecotypes, 2L)
  expect_snapshot_output(ecotypes)
})

test_that("ypr_ecotypes preserves RPR", {
  ecotypes <- ypr_ecotypes(Linf = c(1, 2), RPR = c(1, 3.5))
  expect_equal(ecotypes[[1]]$RPR, 1)
  expect_equal(ecotypes[[2]]$RPR, 3.5)
})

test_that("as_ypr_ecotypes throws error if sr values are not the same", {
  expect_error(
    ypr_ecotypes(Rk = c(10, 20)),
    "`Rk` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(BH = c(1L, 0L)),
    "`BH` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(tR = c(1L, 2L)),
    "`tR` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(Rmax = c(2, 3)),
    "`Rmax` must be the same across all elements."
  )

})

test_that("as_ypr_ecotypes throws error if fishery values are not the same", {
  expect_error(
    ypr_ecotypes(pi = c(0.1, 0.2)),
    "`pi` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(Nc = c(0, 1)),
    "`Nc` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(Hm = c(0, 1)),
    "`Hm` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(Llo = c(10, 100)),
    "`Llo` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(Lup = c(10, 100)),
    "`Lup` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(rho = c(0, 1)),
    "`rho` must be the same across all elements."
  )

  expect_error(
    ypr_ecotypes(q = c(0, 1)),
    "`q` must be the same across all elements."
  )
})
