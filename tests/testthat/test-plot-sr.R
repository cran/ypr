test_that("ypr_plot_sr default", {
  gp <- ypr_plot_sr(ypr_population())
  expect_snapshot_plot(gp, "ypr_plot_sr")
})

test_that("ypr_plot_sr popn productive", {
  gp <- ypr_plot_sr(ypr_population(Rmax = 20))
  expect_snapshot_plot(gp, "popprod")
})

test_that("ypr_plot_sr ecotype1", {
  gp <- ypr_plot_sr(ypr_ecotypes())
  expect_snapshot_plot(gp, "eco1")
})

test_that("ypr_plot_sr ecotype2", {
  gp <- ypr_plot_sr(ypr_ecotypes(Linf = c(100, 50)))
  expect_snapshot_plot(gp, "eco2")
})
