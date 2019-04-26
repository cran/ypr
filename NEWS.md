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
- Added scaling parameter `A0` for inital interval mortality of recruits.
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
