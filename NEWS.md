# ypr 0.4.0

## Major Features

## Population Parameters

- Replaced parameters 
    - `M` (annual instantaneous natural mortality rate)
    - `Mb` (annual instantaneous natural mortality rate (as a function of length) scaling exponent)
    - `A0` (initial post age tR density independent mortality probability)
  with
    - `n` (annual natural mortality rate from age tR to length Ln)
    - `nL` (annual natural mortality rate from length Ln)
    - `Ln` (length at which the natural mortality rate switches from n to nA)
- Added parameters `k2`, `Linf2` and `L2` to allow for biphasic growth.
- Set `Lp` value to be 1000 as opposed to Linf.
- Set `Ls` and `Lv` arguments to be 50 as opposed to `Linf/2`.
- Allow `L2`, `Ln`, `Ls` and `Lv` to also take ages (as negative values).

## Population(s)

- Added `expand = TRUE` argument to `ypr_populations()` to allow control over all combinations.
- Added `ypr_populations_expand()` to create all combinations of parameters.
- Added `ypr_populations_update()` (as well as `update.ypr_population()` and `update.ypr_populations()`).
- `ypr_populations` no longer requires names.
- Added `ypr_population_names()` to allow user to generate names.
- Added `as_ypr_populations.data.frame()`.
- Added `data.frame.ypr_population()` and `data.frame.ypr_populations()`.
- Added `ypr_age_at_length()` to get ages at specific lengths for a given population.
- Added `ypr_length_at_age()` to get lengths at specific ages for a given population.

## Population Reports

- Added `description = ""` argument to `ypr_report()` to allow user to describe report.
- `ypr_report()` now starts with table of parameter values with parameter descriptions.
- Added `view = FALSE` argument to `ypr_report()` to allow user to view report in browser.
- Added `ask = TRUE` argument to `ypr_report()` to ask before overwriting or creating a file.
- Deprecated requirement to provide file extension in `ypr_report()`.
- Soft deprecated `ypr_schedule()` for `ypr_tabulate_schedule()`.

## Plots

- Added plot of biomass and eggs to report.
- Added `percent = FALSE` argument to `ypr_plot_fish()`

## Tables

- Added `ypr_tabulate_biomass()` to easily calculate total biomass and eggs.
- Renamed column `HandlingMortality` to `HandlingMortalities` in `ypr_tabulate_fish()` and `ypr_plot_fish()`.
- Renamed column `Spawning` to `Spawners` in `ypr_tabulate_fish()` and `ypr_plot_fish()`.

## Bug Fixes

- Improved handling of unsustainable populations (no longer negative fish numbers).

# ypr 0.3.1

- `ypr_populations()` now generates names
- Fixed Quesnel Lake Trout and Rainbow Trout mix up

# ypr 0.3.0

- Now uses `q` instead of `Ea` and `Eb` for effort
- Parameter `Rk` now has to be greater than >= 1

# ypr 0.2.0

- Added `ypr_exploitation()` to convert capture probabilities to exploitation probabilities.
- Added `ypr_report()` to generate Rmd file for population.
- Can now pass Rk as egg to recruit survival (at low density).
- Set default value of `Wa` to be 0.01.
- Added `ypr_populations()` to generate all combinations of parameters.
- Made `ypr_tabulate_sr()`, `ypr_tabulate_yield()`, `ypr_tabulate_yields()`, `ypr_plot_yield()` generic with definitions for `ypr_population` and `ypr_populations` objects.
- Added scaling parameter `A0` for initial interval mortality of recruits.
- Added scaling parameters `Ea` and `Eb` to allow plots of yield per effort.
- Added `Age`, `Length`, `Weight` and `Effort` to `ypr_tabulate_yield()` and added `ypr_tabulate_yields()`
- Added `y` arg to `ypr_plot_yield()` to allow plotting of mean age, length, weight, effort or yield per effort by exploitation or capture probability.
- Added `ypr_plot_histogram()` to plot frequency distributions of catch, spawners and in lake by age, length or weight bins.
- Added `ypr_tabulate_parameters()` to get table of parameters, values and descriptions and `ypr_detabulate_parameters()` to convert back to a population object.
- Added `ypr_tabulate_sr()` to get table of eggs and recruits at unfished, actual and optimal rates.
- Added `print.ypr_population()`.

# ypr 0.1.0

- Added `Mb` to scale mortality by length and `BH` to distinguish between Beverton-Holt and Ricker curves and `es` for probability of a mature fish spawning and `Sm` for spawning mortality probability and `Sp` for spawning power and vulnerability power `Vp` and  slot limit non-complicance parameter `Nc` and scaling parameter `R0`.
- Added `ypr_population_update()` to update population parameters.
- Added `ypr_yield_tabulate()` to tabulate actual and optimal yields.
- Added `ypr_sr()` to get stock recruitment parameters and `ypr_plot_sr()` to plot.
- Added `ypr_inst2inter()` and `ypr_inter2instant()` to convert mortality rates.
- Switched `nu` for `M` and `R0` for `Rmax`.
- Switched yield parameters `harvest` and `biomass` to `FALSE` by default.
- Renamed `a` to `Wa` and `b` to `Wb` and `eta` to `Hm` and `mu` to `pi` and `Rt` to `tR`.
- Removed `Capture` (as covered by single value) and `TotalMortality` from schedule and added `Spawning`.

# ypr 0.0.1

- Initial Release
