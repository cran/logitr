## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.retina = 3,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library("logitr")

mnl_wtp_unweighted <- logitr(
  data    = cars_us,
  outcome = 'choice',
  obsID   = 'obsnum',
  pars    = c(
    'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100', 'bev150',
    'american', 'japanese', 'chinese', 'skorean', 'phevFastcharge',
    'bevFastcharge','opCost', 'accelTime'),
  scalePar   = 'price',
  robust     = TRUE,
  # Since WTP space models are non-convex, run a multistart
  numMultiStarts = 10
)

## -----------------------------------------------------------------------------
summary(mnl_wtp_unweighted)

## -----------------------------------------------------------------------------
summary(cars_us$weights)

mnl_wtp_weighted <- logitr(
  data    = cars_us,
  outcome = 'choice',
  obsID   = 'obsnum',
  pars    = c(
    'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100', 'bev150',
    'american', 'japanese', 'chinese', 'skorean', 'phevFastcharge',
    'bevFastcharge','opCost', 'accelTime'),
  scalePar = 'price',
  weights  = 'weights', # This enables the weights
  robust   = TRUE,
  numMultiStarts = 10
)

## -----------------------------------------------------------------------------
summary(mnl_wtp_weighted)

## -----------------------------------------------------------------------------
data.frame(
  Unweighted = coef(mnl_wtp_unweighted),
  Weighted   = coef(mnl_wtp_weighted)
)

## -----------------------------------------------------------------------------
c(
  "Unweighted" = mnl_wtp_unweighted$logLik,
  "Weighted" = mnl_wtp_weighted$logLik
)

