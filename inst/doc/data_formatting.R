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
model_default <- readRDS(
  here::here('inst', 'extdata', 'encoding_model_default.Rds'))
model_character_price <- readRDS(
  here::here('inst', 'extdata', 'encoding_model_character_price.Rds'))
model_dummy_price <- readRDS(
  here::here('inst', 'extdata', 'encoding_model_dummy_price.Rds'))

## ---- eval=FALSE--------------------------------------------------------------
#  model_default <- logitr(
#    data       = cars_us,
#    choiceName = 'choice',
#    obsIDName  = 'obsnum',
#    parNames   = c(
#      'price', 'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100',
#      'bev150', 'american', 'japanese', 'chinese', 'skorean',
#      'phevFastcharge', 'bevFastcharge','opCost', 'accelTime')
#  )

## -----------------------------------------------------------------------------
typeof(cars_us$price)
summary(model_default)

## -----------------------------------------------------------------------------
cars_us$price <- as.character(cars_us$price)
typeof(cars_us$price)

## ---- eval=FALSE--------------------------------------------------------------
#  model_character_price <- logitr(
#    data       = cars_us,
#    choiceName = 'choice',
#    obsIDName  = 'obsnum',
#    parNames   = c(
#      'price', 'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100',
#      'bev150', 'american', 'japanese', 'chinese', 'skorean',
#      'phevFastcharge', 'bevFastcharge','opCost', 'accelTime')
#  )

## -----------------------------------------------------------------------------
typeof(cars_us$price)
summary(model_character_price)

## -----------------------------------------------------------------------------
cars_us_dummy <- dummyCode(df = cars_us, vars = "price")
names(cars_us_dummy)

## ---- eval=FALSE--------------------------------------------------------------
#  model_dummy_price <- logitr(
#    data       = cars_us_dummy,
#    choiceName = 'choice',
#    obsIDName  = 'obsnum',
#    parNames   = c(
#      "price_15", "price_18", "price_23", "price_32",
#      'hev', 'phev10', 'phev20', 'phev40', 'bev75', 'bev100',
#      'bev150', 'american', 'japanese', 'chinese', 'skorean',
#      'phevFastcharge', 'bevFastcharge','opCost', 'accelTime')
#  )

## -----------------------------------------------------------------------------
summary(model_dummy_price)

