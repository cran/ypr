sr <- function(schedule, object) {
  schedule <- as.list(schedule)

  schedule$BH <- ypr_get_par(object, "BH")
  schedule$Rk <- ypr_get_par(object, "Rk")
  schedule$Rmax <- ypr_get_par(object, "Rmax")

  R0 <- 1

  sr <- with(schedule, {
    phi <- sum(Fecundity * Spawning / 2 * Survivorship)

    phiF <- sum(Fecundity * Spawning / 2 * FishedSurvivorship)

    if(Rk <= 1) {
      Rk <- Rk * phi
    }
    alpha <- Rk / phi
    if (BH) {
      beta <- (alpha * phi - 1) / (R0 * phi)
      kappa <- alpha / beta
      R0F <- (alpha * phiF - 1) / (beta * phiF)
    } else {
      beta <- log(alpha * phi) / (R0 * phi)
      kappa <- alpha / (beta * exp(1))
      R0F <- log(alpha * phiF) / (beta * phiF)
    }
    beta <- beta * kappa / Rmax
    R0 <- R0 / kappa * Rmax
    R0F <- R0F / kappa * Rmax
    S0 <- sum(Spawning * Survivorship * R0)
    S0F <- sum(Spawning * FishedSurvivorship * R0F)
    sr <- data.frame(
      alpha = alpha, beta = beta,
      Rk = Rk,
      phi = phi, phiF = phiF,
      R0 = R0, R0F = R0F,
      S0 = S0, S0F = S0F
    )
  })
  as_tibble(sr)
}

#' Stock-Recruitment Parameters
#'
#' Returns a single rowed data frame of the SR parameters:
#' \describe{
#'   \item{alpha}{Survival from egg to age tR at low density}
#'   \item{beta}{Density-dependence}
#'   \item{Rk}{Lifetime spawners per spawner at low density}
#'   \item{phi}{Lifetime eggs deposited per recruit at unfished equilibrium}
#'   \item{phiF}{Lifetime eggs deposited per recruit at the fished equilibrium}
#'   \item{R0}{Age tR recruits at the unfished equilibrium}
#'   \item{R0F}{Age tR recruits at the fished equilibrium}
#'   \item{S0}{Spawners at the unfished equilibrium}
#'   \item{S0F}{Spawners at the fished equilibrium}
#' }
#'
#' @inheritParams params
#' @return A data frame of the SR parameters.
#' @family sr
#' @export
#' @examples
#' ypr_sr(ypr_population()) # Beverton-Holt
#' ypr_sr(ypr_population(BH = 0L)) # Ricker
ypr_sr <- function(object) {
  if(!inherits(object, "ypr"))
    schedule <- ypr_tabulate_schedule(object)

  sr <- sr(schedule, object)
  sr$R0F <- max(sr$R0F, 0)
  sr$S0F <- max(sr$S0F, 0)
  sr
}
