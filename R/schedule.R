#' Life-History Schedule
#'
#' Generates the life-history schedule by age for a population.
#'#'
#' @inheritParams ypr_yield
#' @param population An object of class \code{\link{ypr_population}}.
#' @return A tibble of the life-history schedule by age.
#' @seealso \code{\link{ypr_population}}
#' @export
#' @examples
#' ypr_schedule(ypr_population())
ypr_schedule <- function(population) {
  check_population(population)

  schedule <- with(population, {
    t <- tR:tmax
    n <- length(t)
    L <- Linf * (1 - exp(-k * (t-t0)))
    L[L < 0] <- 0
    W <- Wa * L^Wb
    E <- fa * W^fb
    S <- exp(log(L/Linf) * Sp) / (exp(log(Ls/Linf) * Sp) + exp(log(L/Linf) * Sp)) * es
    N <- ypr_inst2inter(M * L^Mb)
    N[1] <- 1 - (1-N[1]) * (1-A0)
    N <- 1 - ((1-N) * (1 - S * Sm))
    V <- exp(log(L/Linf) * Vp) / (exp(log(Lv/Linf) * Vp) + exp(log(L/Linf) * Vp))
    C <- pi * V
    R <- rep(1 - rho, n)
    R[L < Llo | L > Lup] <- Nc
    U <- C * R + C * (1 - R) * Hm

    TotalMortality <- 1 - (1 - N) * (1 - U)
    Survivorship <- cumprod(1 - N)
    Survivorship <- c(1, Survivorship[-n])
    FishedSurvivorship <- cumprod(1 - TotalMortality)
    FishedSurvivorship <- c(1, FishedSurvivorship[-n])

    data.frame(Age = t, Length = L, Weight = W, Fecundity = E, Spawning = S,
               NaturalMortality = N, Vulnerability = V, Retention = R,
               FishingMortality = U, Survivorship = Survivorship,
               FishedSurvivorship = FishedSurvivorship)
  })

  as_tibble(schedule)
}
