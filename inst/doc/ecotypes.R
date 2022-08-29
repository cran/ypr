## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 4
)

## -----------------------------------------------------------------------------
library(ypr)
library(ggplot2) # for plotting

ecotypes <- ypr_ecotypes(
  Linf2 = 200,
  L2 = c(100, 50),
  Ls = c(50, 75), 
  pi = 0.05,
  names = c("small", "large"),
  RPR = c(0.8, 0.2))

ypr_plot_schedule(ecotypes) + scale_color_manual(values = c("black", "blue"))
ypr_plot_schedule(ecotypes, x = "Age", y  = "Spawning") + scale_color_manual(values = c("black", "blue"))

## ---- fig.width=6, fig.height=4-----------------------------------------------
ypr_plot_fish(ecotypes, color = "white") + scale_fill_manual(values = c("black", "blue"))
ypr_plot_fish(ecotypes, x = "Length", y = "Caught", color = "white", binwidth = 15) + scale_fill_manual(values = c("black", "blue"))

## ---- fig.width=6, fig.height=4-----------------------------------------------
ypr_plot_sr(ecotypes, biomass = TRUE)
ypr_tabulate_sr(ecotypes, biomass = TRUE)

## ---- fig.width=6, fig.height=4-----------------------------------------------
ypr_tabulate_yield(ecotypes, biomass = TRUE)
ypr_plot_yield(ecotypes, biomass = TRUE)

