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
#    parNames   = c('price', 'feat', 'hiland', 'yoplait', 'dannon'),
#    randPars   = c(feat = 'n', hiland = 'n', yoplait = 'n', dannon = 'n'),
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
#  # Extract the WTP computed from the preference space model
#  # to use as the initial starting values
#  startingValues <- wtp_mxl_pref$Estimate
#  
#  mxl_wtp <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('feat', 'hiland', 'yoplait', 'dannon'),
#    priceName  = 'price',
#    randPars   = c(feat = 'n', hiland = 'n', yoplait = 'n', dannon = 'n'),
#    modelSpace = 'wtp',
#    options    = list(
#      # You should run a multistart for MXL models since they are non-convex,
#      # but it can take a long time. Here I just use 5 starts for brevity:
#      numMultiStarts = 5,
#      # Use the computed WTP from the preference space model as the starting
#      # values for the first run:
#      startVals = startingValues,
#      # Because the computed WTP from the preference space model has values
#      # as large as 8, I increase the boundaries of the random starting values:
#      startParBounds = c(-10, 10)))

## -----------------------------------------------------------------------------
summary(mxl_wtp)

## ---- eval=FALSE--------------------------------------------------------------
#  wtp_mxl_comparison <- wtpCompare(mxl_pref, mxl_wtp, priceName = 'price')

## -----------------------------------------------------------------------------
wtp_mxl_comparison

