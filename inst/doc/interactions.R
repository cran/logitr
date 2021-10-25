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

model <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand')
)

## -----------------------------------------------------------------------------
model_price_feat <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand', 'price*feat')
)

## -----------------------------------------------------------------------------
summary(model_price_feat)

## -----------------------------------------------------------------------------
model_price_brand <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand', 'price*brand')
)

## -----------------------------------------------------------------------------
summary(model_price_brand)

## -----------------------------------------------------------------------------
# Create group A dummies
yogurt$groupA <- ifelse(yogurt$obsID %% 2 == 0, 1, 0)

## -----------------------------------------------------------------------------
# Create dummy coefficients for group interaction with price
yogurt$price_groupA <- yogurt$price*yogurt$groupA

model_price_group <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand', 'price_groupA')
)

## -----------------------------------------------------------------------------
summary(model_price_group)

## -----------------------------------------------------------------------------
model_price_feat_mxl <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand', 'price*feat'),
  randPars = c(feat = "n")
)

## -----------------------------------------------------------------------------
summary(model_price_feat_mxl)

