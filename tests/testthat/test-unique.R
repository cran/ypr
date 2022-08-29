test_that("unique", {
  pops <- ypr_populations(Rk = c(3, 3), expand = FALSE)
  expect_identical(names(pops), c("Pop_1", "Pop_2"))
  expect_identical(unique(pops), structure(list(Pop_1 = structure(list(
    tmax = 20L, k = 0.15,
    Linf = 100, t0 = 0, k2 = 0.15, Linf2 = 100, L2 = 1000, Wb = 3,
    Ls = 50, Sp = 100, es = 1, Sm = 0, fb = 1, tR = 1L, BH = 1L,
    Rk = 3, n = 0.2, nL = 0.2, Ln = 1000, Lv = 50, Vp = 100, Llo = 0,
    Lup = 1000, Nc = 0, pi = 0.2, rho = 0, Hm = 0, Rmax = 1,
    Wa = 0.01, fa = 1, q = 0.1, RPR = 1
  ), class = "ypr_population")), class = "ypr_populations"))

  pops <- ypr_populations(Rk = c(4, 3), expand = FALSE)
  expect_identical(names(pops), c("Rk_4", "Rk_3"))
  expect_identical(unique(pops), pops)
})
