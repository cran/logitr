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
model_price_feat <- readRDS(
  here::here('inst', 'extdata', 'int_model_price_feat.Rds'))
model_price_brand <- readRDS(
  here::here('inst', 'extdata', 'int_model_price_brand.Rds'))
model_price_feat_mxl <- readRDS(
  here::here('inst', 'extdata', 'model_price_feat_mxl.Rds'))

## ---- eval=FALSE--------------------------------------------------------------
#  model <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand')
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  model_price_feat <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand', 'price*feat')
#  )

## -----------------------------------------------------------------------------
summary(model_price_feat)

## ---- eval=FALSE--------------------------------------------------------------
#  model_price_brand <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand', 'price*brand')
#  )

## -----------------------------------------------------------------------------
summary(model_price_brand)

## ---- eval=FALSE--------------------------------------------------------------
#  model_price_feat_mxl <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c('price', 'feat', 'brand', 'price*feat'),
#    randPars   = c(feat = "n")
#  )

## -----------------------------------------------------------------------------
summary(model_price_feat_mxl)

