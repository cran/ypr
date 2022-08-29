set_par <- function(object, par, value) {
  if(is.ypr_population(object)) {
    object[[par]] <- value
  } else {
    for(i in seq_len(length(object))) {
      object[[i]] <- set_par(object[[i]], par, value = value)
    }
  }
  object
}

get_par <- function(object, par) {
  return(object[[par]])
}

get_pars <- function(object, par) {
  unname(purrr::map_dbl(object, get_par, par))
}


#' Get Parameter Value
#'
#' @param object A ypr object.
#' @param par A string of the parameter.
#'
#' @return A numeric or integer scalar or vector of the parameter value.
#' @export
#'
#' @examples
#' ypr_get_par(ypr_population())
ypr_get_par <- function(object, par = "pi") {
  chk_string(par)
  chk_subset(par, parameters())

  if(is.ypr_population(object)) {
    return(get_par(object, par))
  }
  pars <- get_pars(object, par)
  if(is.ypr_populations(object)) {
    return(pars)
  }
  if(!par %in% ecoall_parameters()) {
    return(pars)
  }
  only(pars)
}
