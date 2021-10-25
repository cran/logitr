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
mxl_pref <- readRDS(here::here('inst', 'extdata', 'mxl_pref.Rds'))
mxl_wtp  <- readRDS(here::here('inst', 'extdata', 'mxl_wtp.Rds'))

## ----eval=FALSE---------------------------------------------------------------
#  library("logitr")
#  
#  mxl_pref <- logitr(
#    data     = yogurt,
#    choice   = 'choice',
#    obsID    = 'obsID',
#    pars     = c('price', 'feat', 'brand'),
#    randPars = c(feat = 'n', brand = 'n'),
#    # You should run a multistart for MXL models since they are non-convex
#    numMultiStarts = 10
#  )

## -----------------------------------------------------------------------------
summary(mxl_pref)

## -----------------------------------------------------------------------------
wtp_mxl_pref <- wtp(mxl_pref, price =  "price")
wtp_mxl_pref

## ----eval=FALSE---------------------------------------------------------------
#  mxl_wtp <- logitr(
#    data       = yogurt,
#    choice     = 'choice',
#    obsID      = 'obsID',
#    pars       = c('feat', 'brand'),
#    price      = 'price',
#    randPars   = c(feat = 'n', brand = 'n'),
#    modelSpace = 'wtp',
#    # You should run a multistart for MXL models since they are non-convex
#    numMultiStarts = 10,
#    # Use the computed WTP from the preference space model as the starting
#    # values for the first run:
#    startVals = wtp_mxl_pref$Estimate
#  )

## -----------------------------------------------------------------------------
summary(mxl_wtp)

## -----------------------------------------------------------------------------
wtpCompare(mxl_pref, mxl_wtp, price = 'price')

