
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ypr <img src="man/figures/logo.png" align="right" />

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/poissonconsulting/ypr/workflows/R-CMD-check/badge.svg)](https://github.com/poissonconsulting/ypr/actions)
[![Codecov test
coverage](https://codecov.io/gh/poissonconsulting/ypr/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/ypr?branch=master)
[![License:
MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![CRAN
status](https://www.r-pkg.org/badges/version/ypr)](https://cran.r-project.org/package=ypr)
![CRAN Downloads](http://cranlogs.r-pkg.org/badges/ypr)
<!-- badges: end -->

## Introduction

[`ypr`](https://github.com/poissonconsulting/ypr) is an R package that
implements equilibrium-based yield per recruit methods. Yield per
recruit methods can used to estimate the optimal yield for a fish
population (Walters and Martell 2004). The yield can be based on the
number of fish caught (or harvested) or biomass for all fish or just
large (trophy) individuals.

The key life history parameters are

-   The growth coefficient (`k`) and mean maximum length (`Linf`) from
    the Von Bertalanffy growth curve
-   The length at which 50% mature (`Ls`)
-   The length at which 50% vulnerable to harvest (`Lv`)
-   The interval annual natural mortality rate (`n`)
-   The lifetime number of spawners per spawner at low density (`Rk`)

The calculations do not account for stochasticity, predator-prey
dynamics, angler responses or density-dependent growth.

A shiny app is available at
<https://poissonconsulting.shinyapps.io/shinyypr/>.

## Demonstration

### Schedule

``` r
library(ypr)
population <- ypr_population(Rk = 5, Ls = 50, Rmax = 100, rho = 0.6)
ypr_plot_schedule(population, x = "Length", y = "Spawning")
```

![](man/figures/README-unnamed-chunk-1-1.png)<!-- -->

``` r
head(ypr_tabulate_schedule(population))
#> # A tibble: 6 x 11
#>     Age Length Weight Fecundity Spawning NaturalMortality Vulnerability
#>   <int>  <dbl>  <dbl>     <dbl>    <dbl>            <dbl>         <dbl>
#> 1     1   13.9   27.0      27.0 3.13e-56              0.2      3.13e-56
#> 2     2   25.9  174.      174.  2.91e-29              0.2      2.91e-29
#> 3     3   36.2  476.      476.  1.04e-14              0.2      1.04e-14
#> 4     4   45.1  918.      918.  3.46e- 5              0.2      3.46e- 5
#> 5     5   52.8 1469.     1469.  9.95e- 1              0.2      9.95e- 1
#> 6     6   59.3 2090.     2090.  1.00e+ 0              0.2      1.00e+ 0
#> # … with 4 more variables: Retention <dbl>, FishingMortality <dbl>,
#> #   Survivorship <dbl>, FishedSurvivorship <dbl>
```

### Fish

``` r
ypr_plot_fish(population, color = "white")
```

![](man/figures/README-unnamed-chunk-2-1.png)<!-- -->

``` r
head(ypr_tabulate_fish(population))
#> # A tibble: 6 x 7
#>     Age Survivors Spawners   Caught Harvested Released HandlingMortalities
#>   <dbl>     <dbl>    <dbl>    <dbl>     <dbl>    <dbl>               <dbl>
#> 1     1      70.1 2.19e-54 4.39e-55  1.76e-55 2.63e-55                   0
#> 2     2      56.1 1.63e-27 3.26e-28  1.30e-28 1.96e-28                   0
#> 3     3      44.9 4.68e-13 9.36e-14  3.74e-14 5.62e-14                   0
#> 4     4      35.9 1.24e- 3 2.48e- 4  9.93e- 5 1.49e- 4                   0
#> 5     5      28.7 2.86e+ 1 5.72e+ 0  2.29e+ 0 3.43e+ 0                   0
#> 6     6      21.1 2.11e+ 1 4.23e+ 0  1.69e+ 0 2.54e+ 0                   0
```

### Stock-Recruitment

``` r
ypr_plot_sr(population)
```

![](man/figures/README-unnamed-chunk-3-1.png)<!-- -->

``` r
ypr_tabulate_sr(population)
#> # A tibble: 3 x 7
#>   Type        pi     u    Eggs Recruits Spawners Fecundity
#>   <chr>    <dbl> <dbl>   <dbl>    <dbl>    <dbl>     <dbl>
#> 1 unfished 0     0     286350.     80      159.      3600.
#> 2 actual   0.2   0.08  167831.     70.1    108.      3112.
#> 3 optimal  0.458 0.183  84129.     54.0     63.7     2641.
```

### Yield

``` r
ypr_tabulate_yield(population)
#> # A tibble: 2 x 8
#>   Type       pi     u Yield   Age Length Weight Effort
#>   <chr>   <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#> 1 actual  0.2   0.08   8.63  7.67   65.8  3112.   2.12
#> 2 optimal 0.458 0.183 11.7   6.87   62.6  2641.   5.82
ypr_plot_yield(population)
```

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->

### Uncertainty

``` r
library(ggplot2)
populations <- ypr_populations(Rk = c(3, 7), Ls = c(40, 60), Rmax = 100)
ypr_plot_yield(populations, plot_values = FALSE) +
  facet_grid(Rk ~ Ls)
```

![](man/figures/README-unnamed-chunk-5-1.png)<!-- -->

## Installation

To install the latest release from [CRAN](https://cran.r-project.org)

``` r
install.packages("ypr")
```

To install the developmental version from
[GitHub](https://github.com/poissonconsulting/ypr)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/ypr")
```

## Information

For more information see the [Get
Started](https://poissonconsulting.github.io/ypr/articles/ypr.html)
vignette.

### Interaction

To interactively explore the effects of altering individual parameters
on the schedule, stock-recruitment and yield see the ypr shiny
[app](https://poissonconsulting.shinyapps.io/shinyypr/).

![A screenshot of the yield from the ypr shiny
app](man/figures/yield.png)

## Creditation

Development of ypr was partially supported by the [Habitat Conservation
Trust Foundation](https://www.poissonconsulting.ca/orgs/hctf.html) and
the [Ministry of Forests, Lands and Natural Resource
Operations](https://www.poissonconsulting.ca/orgs/mflnro.html).

The hex was designed by [The Forest](https://www.theforest.ca).

## Contribution

Please report any
[issues](https://github.com/poissonconsulting/ypr/issues).

[Pull requests](https://github.com/poissonconsulting/ypr/pulls) are
always welcome.

## Code of Conduct

Please note that the ypr project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-walters_fisheries_2004" class="csl-entry">

Walters, Carl J., and Steven J. D. Martell. 2004. *Fisheries Ecology and
Management*. Princeton, N.J: Princeton University Press.

</div>

</div>
