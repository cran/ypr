test_that("names population", {
  expect_identical(ypr_names(ypr_population()), "Pop_1")
})

test_that("names population Linf", {
  expect_identical(ypr_names(ypr_population(Linf = 200)), "Pop_1")
})

test_that("names populations", {
  expect_identical(ypr_names(ypr_populations()), "Pop_1")
})

test_that("names populations", {
  expect_identical(ypr_names(ypr_populations(Linf = 200)), "Pop_1")
})

test_that("names populations two", {
  expect_identical(ypr_names(ypr_populations(Linf = c(200, 300))), c("Linf_200", "Linf_300"))
})

test_that("names populations two", {
  expect_identical(ypr_names(ypr_populations(Rk = c(3,4), Linf = c(200, 300), expand = FALSE)), c("Linf_200_Rk_3", "Linf_300_Rk_4"))
})

test_that("names ecotypes", {
  expect_identical(ypr_names(ypr_ecotypes()), "Eco_1")
})

test_that("names populations", {
  expect_identical(ypr_names(ypr_ecotypes(Linf = 200)), "Eco_1")
})

test_that("names populations two", {
  expect_identical(ypr_names(ypr_ecotypes(Linf = c(200, 300))), c("Linf_200", "Linf_300"))
})

test_that("names populations two", {
  expect_identical(ypr_names(ypr_ecotypes(fa = c(3,4), Linf = c(200, 300))), c("Linf_200_fa_3", "Linf_300_fa_4"))
})
