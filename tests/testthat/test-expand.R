test_that("ypr_populations_expand", {
  pops <- ypr_populations(Rk = c(2.5, 4, 2.5), Hm = c(0.1, 0.2, 0.1), expand = FALSE)
  expect_identical(names(pops), c("Rk_2_5_Hm_0_1_Pop_1", "Rk_4_Hm_0_2", "Rk_2_5_Hm_0_1_Pop_2"))
  pops <- ypr_populations_expand(pops)
  expect_identical(names(pops), c("Rk_2_5_Hm_0_1", "Rk_4_Hm_0_1", "Rk_2_5_Hm_0_2", "Rk_4_Hm_0_2"))
  expect_identical(pops, ypr_populations(Rk = c(2.5, 4, 2.5), Hm = c(0.1, 0.2, 0.1)))
})
