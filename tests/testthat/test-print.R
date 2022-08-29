test_that("print population", {
  expect_snapshot_output(print(ypr_population()))
})

test_that("print populations", {
  expect_snapshot_output(print(ypr_populations(Rk = c(2.5, 4.6), Hm = c(0.2, 0.05))))
})

test_that("print ecotypes", {
  expect_snapshot_output(print(ypr_ecotypes(Ls = c(10, 15, 20), names = c("river", "deep", "shallow"))))
})

test_that("print ecotypes no name", {
  expect_snapshot_output(print(as_ypr_ecotypes(ypr_populations(Ls = c(10, 15, 20)))))
})

test_that("print ecotype 1", {
  expect_snapshot_output(print(as_ypr_ecotypes(ypr_populations())))
})
