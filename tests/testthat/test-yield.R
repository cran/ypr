test_that("yield", {
  expect_equal(
    ypr_yield(ypr_population(n = ypr:::inst2inter(0.2))),
    0.03493376,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(n = ypr:::inst2inter(0.2)), harvest = FALSE),
    0.03493376,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(rho = 0.4, n = ypr:::inst2inter(0.2))),
    ypr_yield(ypr_population(pi = 0.2 * 0.6, n = ypr:::inst2inter(0.2))),
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(rho = 0.4, n = ypr:::inst2inter(0.2)), harvest = FALSE),
    0.1215271,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(rho = 0.4, Hm = 0.3, n = ypr:::inst2inter(0.2))),
    0.05576617,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(rho = 0.4, Hm = 0.3, n = ypr:::inst2inter(0.2)), harvest = FALSE),
    0.09294362,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Rmax = 1000, n = ypr:::inst2inter(0.2))),
    34.93376,
    tolerance = 1e-03,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(BH = 0L, n = ypr:::inst2inter(0.2))),
    0.08827256,
    tolerance = 1e-03,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Rmax = 1000, BH = 0L, n = ypr:::inst2inter(0.2))),
    88.27256,
    tolerance = 1e-03,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(n = ypr:::inst2inter(0.2)), biomass = TRUE),
    0.09256122,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(n = ypr:::inst2inter(0.2)), biomass = TRUE, Ly = 70),
    0.0325123,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(n = ypr:::inst2inter(0.2), L2 = 50), biomass = TRUE, Ly = 70),
    0.0325123,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(L2 = 50, Linf = 100), biomass = TRUE, Ly = 70),
    0.03549328,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Linf = 140), biomass = TRUE, Ly = 70),
    0,
    tolerance = 1e-06,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Ls = -4.8), biomass = TRUE, Ly = 70),
    0.0344496332448326,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Ls = -4.8, Lv = -4.8), biomass = TRUE, Ly = 70),
    0.0366468217646047,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Ls = -4.8, Lv = -4.8, Ln = -4.8, L2 = -4.8), biomass = TRUE, Ly = 70),
    0.0366468217646047,
    ignore_attr = TRUE
  )

  expect_equal(
    ypr_yield(ypr_population(Linf = 300, L2 = 150), biomass = TRUE, Ly = 70),
    2.06998434234758,
    ignore_attr = TRUE
  )
})

test_that("ypr_yield same for two copies of population with same weighting", {
  popn <- ypr_population(Linf = 100)
  yield <- ypr_yield(popn)
  ecotypes <- ypr_ecotypes(Linf = c(100, 100.00000001), RPR = c(0.5, 0.5))
  expect_equal(ypr_yield(ecotypes), yield)
})

test_that("ypr_yield same for two copies with unequal weighting", {
  popn <- ypr_population(Linf = 100)
  yield <- ypr_yield(popn)
  ecotypes <- ypr_ecotypes(Linf = c(100, 100.000000001), RPR = c(0.75, 0.25))
  expect_equal(ypr_yield(ecotypes), yield)
})

test_that("ypr_yield ecotypes 1", {
  expect_identical(ypr_yield(ypr_ecotypes()),
                   ypr_yield(ypr_population()))
})

test_that("ypr_yield ecotypes 2", {
  yield <- ypr_yield(ypr_ecotypes(Ls = c(40, 60)))
  expect_equal(yield, structure(0.0326319712181924, Age = 6.76869977432548, Length = 62.1306770584528, Weight = 2580.2719304368, Effort = 2.11790488990108))
})
