#' addpoints
#'
#' @description Negates %in%
#'
#' @return negated %in%
#' @export
#'
#' @examples
#' people %!in% distress

`%!in%` <- Negate(`%in%`)
