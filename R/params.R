#' Parameter Descriptions for chk Functions
#' @param tmax The maximum age (yr).
#' @param k The VB growth coefficient (yr-1).
#' @param Linf The VB mean maximum length (cm).
#' @param t0 The (theoretical) age at zero length (yr).
#' @param k2 The VB growth coefficient after length L2 (yr-1).
#' @param Linf2 The VB mean maximum length after length L2 (cm).
#' @param L2 The length (or age if negative) at which growth switches from the first to second phase (cm or yr).
#' @param Wb The weight (as a function of length) scaling exponent.
#' @param Ls The length (or age if negative) at which 50 % mature (cm or yr).
#' @param Sp The maturity (as a function of length) power.
#' @param es The annual probability of a mature fish spawning.
#' @param Sm The spawning mortality probability.
#' @param fb The fecundity (as a function of weight) scaling exponent.
#' @param tR The age from which survival is density-independent (yr).
#' @param BH Recruitment follows a Beverton-Holt (1) or Ricker (0) relationship.
#' @param Rk The lifetime spawners per spawner at low density.
#' @param n The annual interval natural mortality rate from age tR.
#' @param nL The annual interval natural mortality rate from length Ln.
#' @param Ln The length  (or age if negative) at which the natural mortality rate switches from n to nL (cm or yr).
#' @param Lv The length (or age if negative) at which 50 % vulnerable to harvest (cm or yr).
#' @param Vp The vulnerability to harvest (as a function of length) power.
#' @param Llo The lower harvest slot length (cm).
#' @param Lup The upper harvest slot length (cm).
#' @param Nc The slot limits non-compliance probability.
#' @param pi The annual capture probability.
#' @param rho The release probability.
#' @param Hm The hooking mortality probability.
#' @param Rmax The number of recruits at the carrying capacity (ind).
#' @param Wa The (extrapolated) weight of a 1 cm individual (g).
#' @param fa The (theoretical) fecundity of a 1 g female (eggs).
#' @param q The catchability (annual probability of capture) for a unit of effort.
#' @param all A flag specifying whether to include all parameter values.
#' @param u A flag specifying whether to plot the exploitation rate as opposed to the capture rate.
#' @param percent A flag specifying whether to plot the number of fish as a percent or frequency (the default).
#' @param color A string of the color around each bar (or NULL).
#' @param population An object of class [ypr_population()].
#' @param populations An object of class [ypr_populations()].
#' @param plot_values A flag specifying whether to plot the actual and optimal values.
#' @param Ly The minimum length (trophy) fish to consider when calculating the yield (cm).
#' @param harvest A flag specifying whether to calculate the yield for harvested fish or captures.
#' @param biomass A flag specifying whether to calculate the yield in terms of the biomass versus number of individuals.
#' @param title A string of the report title.
#' @param date A date of the report date.
#' @param file A string of the path to the file (without the extension).
#' @param binwidth A positive integer of the width of the bins for grouping.
#' @param type A string indicating whether to include 'both' or just the 'actual' or 'optimal' yield.
#' @param object The populations or populations.
#' @param ... Unused parameters.
#' @param expand A flag specifying whether to expand parameter combinations.
#' @param view A flag specifying whether to view the report (after rendering it to html).
#' @param ask A flag specifying whether to ask before overwriting or creating a file.
#' @param description A string describing the population.
#' @param age A numeric vector of the age (yr).
#' @param length A numeric vector of the length (cm).
#' @keywords internal
#' @name params
NULL
