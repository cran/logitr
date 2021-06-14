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
mnl_pref <- readRDS(here::here('inst', 'extdata', 'mnl_pref.Rds'))
mnl_wtp  <- readRDS(here::here('inst', 'extdata', 'mnl_wtp.Rds'))
wtp_mnl_pref <- readRDS(here::here('inst', 'extdata', 'wtp_mnl_pref.Rds'))
wtp_mnl_comparison <- readRDS(here::here('inst', 'extdata',
    'wtp_mnl_comparison.Rds'))

## ---- eval=FALSE--------------------------------------------------------------
#  library(logitr)

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_pref <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand')
#  )

## -----------------------------------------------------------------------------
summary(mnl_pref)

## -----------------------------------------------------------------------------
coef(mnl_pref)

## ---- eval=FALSE--------------------------------------------------------------
#  wtp_mnl_pref <- wtp(mnl_pref, priceName =  "price")

## -----------------------------------------------------------------------------
wtp_mnl_pref

## ----eval=FALSE---------------------------------------------------------------
#  mnl_wtp <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('feat', 'brand'),
#    priceName  = 'price',
#    modelSpace = 'wtp',
#    options = list(
#      # Since WTP space models are non-convex, run a multistart:
#      numMultiStarts = 10,
#      # If you want to view the results from each multistart run,
#      # set keepAllRuns=TRUE:
#      keepAllRuns = TRUE,
#      # Use the computed WTP from the preference space model as the starting
#      # values for the first run:
#      startVals = wtp_mnl_pref$Estimate)
#  )

## -----------------------------------------------------------------------------
summary(mnl_wtp)

## -----------------------------------------------------------------------------
coef(mnl_wtp)

## ---- eval=FALSE--------------------------------------------------------------
#  wtp_mnl_comparison <- wtpCompare(mnl_pref, mnl_wtp, priceName = 'price')

## -----------------------------------------------------------------------------
wtp_mnl_comparison

