#' Population Parameters
#'
#' Generates an object of class `ypr_population`.
#'
#' @inheritParams params
#' @param pi The annual capture probability.
#' @return An object of class `ypr_population`.
#' @export
#' @examples
#' ypr_population(k = 0.1, Linf = 90)
ypr_population <- function(tmax = 20L, k = 0.15, Linf = 100, t0 = 0,
                           k2 = 0.15, Linf2 = 100, L2 = 1000,
                           Wb = 3, Ls = 50, Sp = 100, es = 1, Sm = 0,
                           fb = 1,
                           tR = 1L, BH = 1L, Rk = 3, n = 0.2, nL = 0.2,
                           Ln = 1000,
                           Lv = 50, Vp = 100,
                           Llo = 0, Lup = 1000, Nc = 0,
                           pi = 0.2, rho = 0, Hm = 0,
                           Rmax = 1, Wa = 0.01, fa = 1,
                           q = 0.1,
                           RPR = 1) {
  population <- as.list(environment())
  class(population) <- c("ypr_population")
  check_population(population)
  population
}
