test_that("as_ypr_population data.frame", {
  expect_identical(
    as_ypr_population(as.data.frame(ypr_population(Linf = 150))),
    ypr_population(Linf = 150)
  )
})

test_that("as_ypr_population population", {
  expect_identical(
    as_ypr_population(ypr_population(Linf = 150)),
    ypr_population(Linf = 150)
  )
})

test_that("as_ypr_population populations 1 population", {
  expect_identical(
    as_ypr_population(ypr_populations(Linf = 150)),
    ypr_population(Linf = 150)
  )
})

test_that("as_ypr_population ecotypes 1 ecotype", {
  expect_identical(
    as_ypr_population(ypr_ecotypes(Linf = 150)),
    ypr_population(Linf = 150)
  )
})

test_that("as_ypr_population populations errors 2 population", {
  expect_error(as_ypr_population(ypr_populations(Linf = c(150, 200))))
})

test_that("as_ypr_population ecotypes 1 ecotype", {
  expect_error(as_ypr_population(ypr_ecotypes(Linf = c(150, 200))))
})
