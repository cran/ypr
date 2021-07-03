test_that("as.data.frame", {
  expect_identical(
    as.data.frame(ypr_population()),
    structure(list(
      tmax = 20L, k = 0.15, Linf = 100, t0 = 0, k2 = 0.15,
      Linf2 = 100, L2 = 1000, Wb = 3, Ls = 50, Sp = 100, es = 1,
      Sm = 0, fb = 1, tR = 1L, BH = 1L, Rk = 3, n = 0.2, nL = 0.2,
      Ln = 1000, Lv = 50, Vp = 100, Llo = 0, Lup = 1000, Nc = 0,
      pi = 0.2, rho = 0, Hm = 0, Rmax = 1, Wa = 0.01, fa = 1, q = 0.1
    ), class = c(
      "tbl_df",
      "tbl", "data.frame"
    ), row.names = c(NA, -1L))
  )

  expect_identical(
    as.data.frame(ypr_populations(Rk = c(3, 4))),
    structure(list(
      tmax = c(20L, 20L), k = c(0.15, 0.15), Linf = c(
        100,
        100
      ), t0 = c(0, 0), k2 = c(0.15, 0.15), Linf2 = c(100, 100),
      L2 = c(1000, 1000), Wb = c(3, 3), Ls = c(50, 50), Sp = c(
        100,
        100
      ), es = c(1, 1), Sm = c(0, 0), fb = c(1, 1), tR = c(
        1L,
        1L
      ), BH = c(1L, 1L), Rk = c(3, 4), n = c(0.2, 0.2), nL = c(
        0.2,
        0.2
      ), Ln = c(1000, 1000), Lv = c(50, 50), Vp = c(100, 100), Llo = c(
        0,
        0
      ), Lup = c(1000, 1000), Nc = c(0, 0), pi = c(0.2, 0.2),
      rho = c(0, 0), Hm = c(0, 0), Rmax = c(1, 1), Wa = c(
        0.01,
        0.01
      ), fa = c(1, 1), q = c(0.1, 0.1)
    ), row.names = c(
      "Rk_3",
      "Rk_4"
    ), class = c("tbl_df", "tbl", "data.frame"))
  )
})


test_that("print", {
  expect_identical(
    capture_output(print(ypr_population())),
    "tmax:  20\nk:     0.15\nLinf:  100\nt0:    0\nk2:    0.15\nLinf2: 100\nL2:    1000\nWb:    3\nLs:    50\nSp:    100\nes:    1\nSm:    0\nfb:    1\ntR:    1\nBH:    1\nRk:    3\nn:     0.2\nnL:    0.2\nLn:    1000\nLv:    50\nVp:    100\nLlo:   0\nLup:   1000\nNc:    0\npi:    0.2\nrho:   0\nHm:    0\nRmax:  1\nWa:    0.01\nfa:    1\nq:     0.1"
  )

  expect_identical(
    capture_output(print(ypr_populations(Rk = c(2.5, 4.6), Hm = c(0.2, 0.05)))),
    "tmax:  20\nk:     0.15\nLinf:  100\nt0:    0\nk2:    0.15\nLinf2: 100\nL2:    1000\nWb:    3\nLs:    50\nSp:    100\nes:    1\nSm:    0\nfb:    1\ntR:    1\nBH:    1\nRk:    2.5, 4.6, 2.5, 4.6\nn:     0.2\nnL:    0.2\nLn:    1000\nLv:    50\nVp:    100\nLlo:   0\nLup:   1000\nNc:    0\npi:    0.2\nrho:   0\nHm:    0.05, 0.05, 0.2, 0.2\nRmax:  1\nWa:    0.01\nfa:    1\nq:     0.1"
  )
})

test_that("unique", {
  pops <- ypr_populations(Rk = c(3, 3), expand = FALSE)
  expect_identical(names(pops), c("Popn_1", "Popn_2"))
  expect_identical(unique(pops), structure(list(Popn_1 = structure(list(
    tmax = 20L, k = 0.15,
    Linf = 100, t0 = 0, k2 = 0.15, Linf2 = 100, L2 = 1000, Wb = 3,
    Ls = 50, Sp = 100, es = 1, Sm = 0, fb = 1, tR = 1L, BH = 1L,
    Rk = 3, n = 0.2, nL = 0.2, Ln = 1000, Lv = 50, Vp = 100, Llo = 0,
    Lup = 1000, Nc = 0, pi = 0.2, rho = 0, Hm = 0, Rmax = 1,
    Wa = 0.01, fa = 1, q = 0.1
  ), class = "ypr_population")), class = "ypr_populations"))

  pops <- ypr_populations(Rk = c(4, 3), expand = FALSE)
  expect_identical(names(pops), c("Rk_4", "Rk_3"))
  expect_identical(unique(pops), pops)
})

test_that("update", {
  expect_identical(
    update(ypr_population(), Rk = 5),
    ypr_population(Rk = 5)
  )
})
