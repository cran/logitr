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
mnl_pref <- readRDS(here::here('inst', 'extdata', 'mnl_pref.Rds'))
mnl_wtp  <- readRDS(here::here('inst', 'extdata', 'mnl_wtp.Rds'))

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_pref <- logitr(
#      data   = yogurt,
#      choice = "choice",
#      obsID  = "obsID",
#      pars   = c("price", "feat", "brand")
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_wtp <- logitr(
#      data   = yogurt,
#      choice = "choice",
#      obsID  = "obsID",
#      pars   = c("feat", "brand"),
#      price  = "price",
#      modelSpace = "wtp"
#  )

## -----------------------------------------------------------------------------
mnl_wtp <- logitr(
    data   = yogurt,
    choice = "choice",
    obsID  = "obsID",
    pars   = c("feat", "brand"),
    price  = "price",
    modelSpace = "wtp",
    numMultiStarts = 10
)

## -----------------------------------------------------------------------------
summary(mnl_pref)

## -----------------------------------------------------------------------------
coef(mnl_pref)

## -----------------------------------------------------------------------------
logLik(mnl_pref)

## -----------------------------------------------------------------------------
vcov(mnl_pref)

## -----------------------------------------------------------------------------
sqrt(diag(vcov(mnl_pref)))

## -----------------------------------------------------------------------------
wtp(mnl_pref, price = "price")

## -----------------------------------------------------------------------------
wtpCompare(mnl_pref, mnl_wtp, price = "price")

## ---- eval=FALSE--------------------------------------------------------------
#  mxl_pref <- logitr(
#      data     = yogurt,
#      choice   = 'choice',
#      obsID    = 'obsID',
#      pars     = c('price', 'feat', 'brand'),
#      randPars = c(feat = 'n', brand = 'n'),
#      numMultiStarts = 10
#  )

## -----------------------------------------------------------------------------
alts <- subset(
  yogurt, obsID %in% c(42, 13),
  select = c('obsID', 'alt', 'choice', 'price', 'feat', 'brand')
)

alts

## -----------------------------------------------------------------------------
probs <- predictProbs(
  model = mnl_pref,
  alts  = alts,
  altID = "alt",
  obsID = "obsID"
)

probs

## -----------------------------------------------------------------------------
probs <- predictProbs(
  model = mnl_wtp,
  alts  = alts,
  altID = "alt",
  obsID = "obsID"
)

probs

## -----------------------------------------------------------------------------
choices <- predictChoices(
  model = mnl_pref,
  alts  = yogurt,
  altID = "alt",
  obsID = "obsID"
)

# Preview actual and predicted choices
head(choices[c('obsID', 'choice', 'choice_predict')])

## -----------------------------------------------------------------------------
chosen <- subset(choices, choice == 1)
chosen$correct <- chosen$choice == chosen$choice_predict
sum(chosen$correct) / nrow(chosen)

