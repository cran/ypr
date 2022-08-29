test_that("plot population", {
  pdf(tempfile())
  withr::defer(dev.off())
  expect_silent(plot(ypr_population()))
})

test_that("ypr_plot_biomass", {
  gp <- ypr_plot_biomass(ypr_population())
  expect_snapshot_plot(gp, "ypr_plot_biomass")
})
