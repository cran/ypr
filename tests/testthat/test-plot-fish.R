test_that("ypr_plot_fish population default", {
  gp <- ypr_plot_fish(ypr_population(Rmax = 1000))
  expect_snapshot_plot(gp, "pop")
})

test_that("ypr_plot_fish caught", {
  gp <- ypr_plot_fish(ypr_population(Rmax = 1000), y = "Caught", binwidth = 1L)
  expect_snapshot_plot(gp, "ypr_plot_fish")
})

test_that("ypr_plot_fish ecotypes default", {
  gp <- ypr_plot_fish(ypr_ecotypes())
  expect_snapshot_plot(gp, "eco1")
})

test_that("ypr_plot_fish ecotypes2", {
  gp <- ypr_plot_fish(ypr_ecotypes(n = c(0.9, 0.3), RPR = c(1, 1)))
  expect_snapshot_plot(gp, "eco2")
})
