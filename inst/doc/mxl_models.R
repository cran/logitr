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
wtp_mxl_pref <- readRDS(here::here('inst', 'extdata', 'wtp_mxl_pref.Rds'))
wtp_mxl_comparison <- readRDS(
    here::here('inst', 'extdata', 'wtp_mxl_comparison.Rds'))

## ----eval=FALSE---------------------------------------------------------------
#  library(logitr)

## ----eval=FALSE---------------------------------------------------------------
#  mxl_pref <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand'),
#    randPars   = c(feat = 'n', brand = 'n'),
#    # You should run a multistart for MXL models since they are non-convex,
#    # but it can take a long time. Here I just use 5 starts for brevity:
#    options    = list(numMultiStarts = 5)
#  )

## -----------------------------------------------------------------------------
summary(mxl_pref)

## ---- eval=FALSE--------------------------------------------------------------
#  wtp_mxl_pref <- wtp(mxl_pref, priceName = "price")

## -----------------------------------------------------------------------------
wtp_mxl_pref

## ----eval=FALSE---------------------------------------------------------------
#  library(logitr)

## ----eval=FALSE---------------------------------------------------------------
#  mxl_wtp <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('feat', 'brand'),
#    priceName  = 'price',
#    randPars   = c(feat = 'n', brand = 'n'),
#    modelSpace = 'wtp',
#    options    = list(
#      # You should run a multistart for MXL models since they are non-convex,
#      # but it can take a long time. Here I just use 5 starts for brevity:
#      numMultiStarts = 5,
#      # Use the computed WTP from the preference space model as the starting
#      # values for the first run:
#      startVals = wtp_mxl_pref$Estimate)
#  )

## -----------------------------------------------------------------------------
summary(mxl_wtp)

## ---- eval=FALSE--------------------------------------------------------------
#  wtp_mxl_comparison <- wtpCompare(mxl_pref, mxl_wtp, priceName = 'price')

## -----------------------------------------------------------------------------
wtp_mxl_comparison

