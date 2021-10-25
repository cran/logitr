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

head(yogurt)

## -----------------------------------------------------------------------------
yogurt2 <- yogurt

brands <- c("weight", "hiland", "yoplait", "dannon")
yogurt2$brand <- factor(yogurt2$brand, levels = brands)

## -----------------------------------------------------------------------------
yogurt2 <- fastDummies::dummy_cols(yogurt2, "brand")

## -----------------------------------------------------------------------------
head(yogurt2)

## -----------------------------------------------------------------------------
mnl_pref_dummies <- logitr(
  data    = yogurt2,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c(
    'price', 'feat', 'brand_yoplait', 'brand_dannon', 'brand_weight')
)

summary(mnl_pref_dummies)

