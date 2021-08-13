## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.retina = 3,
  comment = "#>"
)
library(logitr)
# Read in results from already estimated models  so that the
# examples aren't actually run when building this page, otherwise it'll
# take much longer to build
mnl_wtp_unweighted <- readRDS(
  here::here('inst', 'extdata', 'mnl_wtp_unweighted.Rds'))
mnl_wtp_weighted <- readRDS(
  here::here('inst', 'extdata', 'mnl_wtp_weighted.Rds'))

## ----eval=FALSE---------------------------------------------------------------
#  library(logitr)

## ----eval=FALSE---------------------------------------------------------------
#  mnl_wtp_unweighted <- logitr(
#    data   = cars_us,
#    choice = 'choice',
#    obsID  = 'obsnum',
#    pars   = c(
#      'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100', 'bev150',
#      'american', 'japanese', 'chinese', 'skorean', 'phevFastcharge',
#      'bevFastcharge','opCost', 'accelTime'),
#    price = 'price',
#    modelSpace = 'wtp',
#    robust = TRUE,
#    # Since WTP space models are non-convex, run a multistart
#    numMultiStarts = 10
#  )

## -----------------------------------------------------------------------------
summary(mnl_wtp_unweighted)

## -----------------------------------------------------------------------------
summary(cars_us$weights)

## ----eval=FALSE---------------------------------------------------------------
#  mnl_wtp_weighted <- logitr(
#    data   = cars_us,
#    choice = 'choice',
#    obsID  = 'obsnum',
#    pars   = c(
#      'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100', 'bev150',
#      'american', 'japanese', 'chinese', 'skorean', 'phevFastcharge',
#      'bevFastcharge','opCost', 'accelTime'),
#    price = 'price',
#    modelSpace = 'wtp',
#    weights = 'weights', # This is the key argument for enabling weights
#    robust = TRUE,
#    numMultiStarts = 10
#  )

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

