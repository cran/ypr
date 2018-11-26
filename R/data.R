#' Adams Lake Bull Trout Population Parameters
#'
#' The population parameters for
#' Bull Trout in Adams Lake from Bison et al (2003)
#' @references Bison, R., O’Brien, D., and Martell, S.J.D. 2003. An Analysis of Sustainable Fishing Options for Adams Lake Bull Trout Using Life History and Telemetry Data. BC Ministry of Water Land and Air Protection, Kamloops, B.C.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' adams_bt_03
#' ypr_plot_yield(adams_bt_03)
"adams_bt_03"

#' Chilliwack Lake Bull Trout Populations Parameters
#'
#' The populations parameters for
#' Bull Trout in Chilliwack Lake from Taylor (2005)
#'
#' @references Taylor, J.L. 2005. Sustainability of the Chilliwack Lake Char Fishery. Ministry of Water, Land and Air Protection, Surrey, B.C.
#' @format An object of class \code{\link{ypr_populations}}.
#' @examples
#' chilliwack_bt_05
#' yield <- ypr_tabulate_yield(chilliwack_bt_05, type = "optimal")
#' yield$pi <- round(yield$pi, 2)
#' yield <- yield[c("Llo", "Hm", "Rk", "pi")]
#' yield <- tidyr::spread(yield, Rk, pi)
#' yield <- yield[order(-yield$Hm),]
#' yield
#'
#' \dontrun{
#' ypr_plot_yield(chilliwack_bt_05, plot_values = FALSE) +
#'   ggplot2::facet_grid(Rk~Hm) +
#'   ggplot2::aes(group = Llo, linetype = Llo)
#'  }
"chilliwack_bt_05"

#' Kootenay Lake Bull Trout Population Parameters (2013)
#'
#' The population parameters for
#' Bull Trout in Kootenay Lake from Andrusak and Thorley (2013)
#'
#' The estimates should not be used for management.
#' @references Andrusak, G.F., and Thorley, J.L. 2013. Kootenay Lake Exploitation Study: Fishing and Natural Mortality of Large Rainbow Trout and Bull Trout: 2013 Annual Report. A Poisson Consulting Ltd. and Redfish Consulting Ltd. Report, Habitat Conservation Trust Foundation, Victoria, BC.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' kootenay_bt_13
#' ypr_plot_yield(kootenay_bt_13)
"kootenay_bt_13"

#' Kootenay Lake Rainbow Trout Population Parameters (2013)
#'
#' The population parameters for
#' Rainbow Trout in Kootenay Lake from Andrusak and Thorley (2013)
#'
#' The estimates should not be used for management.
#' @references Andrusak, G.F., and Thorley, J.L. 2013. Kootenay Lake Exploitation Study: Fishing and Natural Mortality of Large Rainbow Trout and Bull Trout: 2013 Annual Report. A Poisson Consulting Ltd. and Redfish Consulting Ltd. Report, Habitat Conservation Trust Foundation, Victoria, BC.
#' @format An object of class \code{\link{ypr_population}}.
#' @seealso \code{\link{kootenay_rb}}
#' @examples
#' kootenay_rb_13
#' ypr_plot_yield(kootenay_rb_13)
"kootenay_rb_13"

#' Kootenay Lake Rainbow Trout Population Parameters
#'
#' The population parameters for
#' Rainbow Trout in Kootenay Lake.
#'
#' The estimates are liable to change and should not be used for management.
#' @references Thorley, J.L., and Andrusak, G.F. 2017. The fishing and natural mortality of large, piscivorous Bull Trout and Rainbow Trout in Kootenay Lake, British Columbia (2008–2013). PeerJ 5: e2874. doi:10.7717/peerj.2874.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' kootenay_rb
#' ypr_plot_yield(kootenay_rb)
"kootenay_rb"

#' Quesnel Lake Bull Trout Population Parameters
#'
#' The population parameters for
#' Bull Trout in Quesnel Lake, BC.
#'
#' The estimates are liable to change and should not be used for management.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' quesnel_bt
#' ypr_plot_yield(quesnel_bt)
"quesnel_bt"

#' Quesnel Lake Lake Trout Population Parameters
#'
#' The population parameters for
#' Lake Trout in Quesnel Lake, BC.
#'
#' The estimates are liable to change and should not be used for management.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' quesnel_rb
#' ypr_plot_yield(quesnel_rb)
"quesnel_rb"

#' Quesnel Lake Rainbow Trout Population Parameters
#'
#' The population parameters for
#' Rainbow Trout in Quesnel Lake, BC.
#'
#' The estimates are liable to change and should not be used for management.
#' @format An object of class \code{\link{ypr_population}}.
#' @examples
#' quesnel_lt
#' ypr_plot_yield(quesnel_lt)
"quesnel_lt"
