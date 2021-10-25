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

mnl_pref <- logitr(
    data    = yogurt,
    outcome = "choice",
    obsID   = "obsID",
    pars    = c("price", "feat", "brand")
)

## -----------------------------------------------------------------------------
mnl_wtp <- logitr(
    data    = yogurt,
    outcome = "choice",
    obsID   = "obsID",
    pars    = c("feat", "brand"),
    price   = "price",
    modelSpace = "wtp"
)

## -----------------------------------------------------------------------------
mnl_wtp <- logitr(
    data    = yogurt,
    outcome = "choice",
    obsID   = "obsID",
    pars    = c("feat", "brand"),
    price   = "price",
    modelSpace = "wtp",
    numMultiStarts = 10
)

## -----------------------------------------------------------------------------
summary(mnl_pref)

## -----------------------------------------------------------------------------
coef(mnl_pref)

## -----------------------------------------------------------------------------
se(mnl_pref)

## -----------------------------------------------------------------------------
logLik(mnl_pref)

## -----------------------------------------------------------------------------
vcov(mnl_pref)

## -----------------------------------------------------------------------------
wtp(mnl_pref, price = "price")

## -----------------------------------------------------------------------------
wtpCompare(mnl_pref, mnl_wtp, price = "price")

## ---- eval=FALSE--------------------------------------------------------------
#  mxl_pref <- logitr(
#      data     = yogurt,
#      outcome  = 'choice',
#      obsID    = 'obsID',
#      pars     = c('price', 'feat', 'brand'),
#      randPars = c(feat = 'n', brand = 'n'),
#      numMultiStarts = 10
#  )

## -----------------------------------------------------------------------------
data <- subset(
  yogurt, obsID %in% c(42, 13),
  select = c('obsID', 'alt', 'choice', 'price', 'feat', 'brand')
)

data

## -----------------------------------------------------------------------------
probs <- predict(
  mnl_pref,
  newdata = data,
  obsID = "obsID", 
  ci = 0.95
)

probs

## -----------------------------------------------------------------------------
probs <- predict(
  mnl_wtp,
  newdata = data,
  obsID = "obsID",
  price = "price"
)

probs

## -----------------------------------------------------------------------------
outcomes <- predict(
  mnl_pref,
  type = "outcome",
  returnData = TRUE
)

head(outcomes[c('obsID', 'choice', 'predicted_outcome')])

## -----------------------------------------------------------------------------
chosen <- subset(outcomes, choice == 1)
chosen$correct <- chosen$choice == chosen$predicted_outcome
sum(chosen$correct) / nrow(chosen)

