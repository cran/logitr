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
mnl_pref_dannon <- readRDS(
  here::here('inst', 'extdata', 'mnl_pref_dannon.Rds'))
mnl_pref_weight <- readRDS(
  here::here('inst', 'extdata', 'mnl_pref_weight.Rds'))
mnl_pref_dummies <- readRDS(
  here::here('inst', 'extdata', 'mnl_pref_dummies.Rds'))

## -----------------------------------------------------------------------------
head(yogurt)

## ---- eval=FALSE--------------------------------------------------------------
#  brands <- c("weight", "hiland", "yoplait", "dannon")
#  yogurt$brand <- factor(yogurt$brand, levels = brands)

## -----------------------------------------------------------------------------
yogurt <- fastDummies::dummy_cols(yogurt, "brand")

## -----------------------------------------------------------------------------
head(yogurt)

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_pref_dummies <- logitr(
#    data       = yogurt,
#    choiceName = 'choice',
#    obsIDName  = 'obsID',
#    parNames   = c(
#      'price', 'feat', 'brand_yoplait', 'brand_dannon', 'brand_weight')
#  )

## -----------------------------------------------------------------------------
summary(mnl_pref_dummies)

