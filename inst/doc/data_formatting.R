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
    'price', 'feat', 'brand_yoplait', 'brand_dannon', 'brand_weight'
  )
)

summary(mnl_pref_dummies)

## -----------------------------------------------------------------------------
validation <- validate_data(
  data = yogurt,
  outcome = "choice",
  obsID = "obsID"
)

validation

## -----------------------------------------------------------------------------
validation <- validate_data(
  data = yogurt,
  outcome = "choice",
  obsID = "obsID",
  pars = c("price", "feat", "brand")
)

validation

## -----------------------------------------------------------------------------
validation <- validate_data(
  data = yogurt,
  outcome = "choice",
  obsID = "obsID",
  pars = c("price", "feat", "brand"),
  panelID = "id"
)

validation

## -----------------------------------------------------------------------------
# Create problematic data with multiple choices in one observation
bad_data <- yogurt
bad_data$choice[1:2] <- 1

validation <- validate_data(
  data = bad_data,
  outcome = "choice",
  obsID = "obsID"
)

validation

