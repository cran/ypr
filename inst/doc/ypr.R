## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 4
)

## ---- echo=FALSE--------------------------------------------------------------
library(ypr)
nparameters <- length(ypr_population())
caption <- paste("Table 1. The", nparameters, "parameters with their default values and descriptions.")
table <- ypr_tabulate_parameters(ypr_population())
table$Description <- sub("\n", " ", table$Description)

knitr::kable(table, caption = caption)

## -----------------------------------------------------------------------------
population <- ypr_population()
ypr_plot_schedule(population, "Age", "Length")

## -----------------------------------------------------------------------------
ypr_plot_schedule(ypr_population_update(population, L2 = 75, Linf2 = 200), "Age", "Length")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, Wa = 0.01, Wb = 3)
ypr_plot_schedule(population, "Length", "Weight")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, fa = 1, fb = 1)
ypr_plot_schedule(population, "Weight", "Fecundity")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, Ls = 50, Sp = 10, es = 0.8)
ypr_plot_schedule(population, "Length", "Spawning")

## -----------------------------------------------------------------------------
ypr_plot_schedule(population, "Length", "NaturalMortality")

## -----------------------------------------------------------------------------
ypr_plot_schedule(ypr_population_update(population, nL = 0.15, Ln = 60), "Length", "NaturalMortality")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, Sm = 0.5)
ypr_plot_schedule(population, "Length", "NaturalMortality")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, Lv = 50, Vp = 50)
ypr_plot_schedule(population, "Length", "Vulnerability")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, rho = 0.5, Llo = 40, Lup = 70, Nc = 0.1)
ypr_plot_schedule(population, "Length", "Retention")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, pi = 0.3, Hm = 0.2)
ypr_plot_schedule(population, "Length", "FishingMortality")

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, Rk = 3)
ypr_plot_sr(population, plot_values = FALSE)

## -----------------------------------------------------------------------------
population <- ypr_population_update(population, BH = 0L)
ypr_plot_sr(population, plot_values = FALSE)

## -----------------------------------------------------------------------------
ypr_plot_schedule(population, "Age", "Survivorship")

## -----------------------------------------------------------------------------
ypr_plot_yield(population, harvest = TRUE, biomass = TRUE, Ly = 60)
ypr_tabulate_yield(population, harvest = TRUE, biomass = TRUE, Ly = 60)

## -----------------------------------------------------------------------------
ypr_plot_yield(population, y = "Effort", harvest = TRUE, biomass = TRUE, Ly = 60)

## -----------------------------------------------------------------------------
ypr_plot_yield(population, y = "YPUE", harvest = TRUE, biomass = TRUE, Ly = 60)

