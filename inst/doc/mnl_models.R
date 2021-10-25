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

mnl_pref <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand')
)

## -----------------------------------------------------------------------------
summary(mnl_pref)

## -----------------------------------------------------------------------------
coef(mnl_pref)

## -----------------------------------------------------------------------------
wtp_mnl_pref <- wtp(mnl_pref, price =  "price")
wtp_mnl_pref

## -----------------------------------------------------------------------------
mnl_wtp <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('feat', 'brand'),
  price   = 'price',
  modelSpace = 'wtp',
  # Since WTP space models are non-convex, run a multistart
  numMultiStarts = 10,
  # Use the computed WTP from the preference space model as the starting
  # values for the first run:
  startVals = wtp_mnl_pref$Estimate
)

## -----------------------------------------------------------------------------
summary(mnl_wtp)

## -----------------------------------------------------------------------------
coef(mnl_wtp)

## -----------------------------------------------------------------------------
wtpCompare(mnl_pref, mnl_wtp, price = 'price')

