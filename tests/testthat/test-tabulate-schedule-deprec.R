test_that("ypr_schedule", {
  expect_warning(expect_identical(
    ypr_schedule(ypr_population()),
    ypr_tabulate_schedule(ypr_population())
  ))
})
