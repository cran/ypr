test_that("as_ypr_populations converts data.frame", {
  expect_identical(
    as_ypr_populations(as.data.frame(ypr_populations(Linf = c(150, 250)))),
    ypr_populations(Linf = c(150, 250))
  )
})

test_that("as_ypr_populations converts population", {
  expect_identical(
    as_ypr_populations(ypr_population(Linf = 150)),
    ypr_populations(Linf = 150)
  )
})

test_that("as_ypr_populations converts populations", {
  expect_identical(
    as_ypr_populations(ypr_populations(Linf = c(150, 250))),
    ypr_populations(Linf = c(150, 250))
  )
})

test_that("as_ypr_populations converts ecotypes", {
  expect_identical(
    as_ypr_populations(ypr_ecotypes(Linf = c(150, 250))),
    ypr_populations(Linf = c(150, 250))
  )
})

test_that("as_ypr_populations default names are used", {
  ecotypes <- ypr_populations(Linf = c(100, 1000))
  expect_named(ecotypes, c("Linf_100", "Linf_1000"))
})

test_that("as_ypr_populations preserves names", {
  ecotypes <- ypr_populations(Linf = c(100, 1000), names = c("thing1", "thing2"))
  expect_named(as_ypr_populations(ecotypes), c("thing1", "thing2"))
})
