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
#  model <- logitr(
#    data,
#    choiceName,
#    obsIDName,
#    parNames,
#    priceName = NULL,
#    randPars = NULL,
#    randPrice = NULL,
#    modelSpace = "pref",
#    weightsName = NULL,
#    options = list()
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_pref <- logitr(
#      data       = yogurt,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = c("price", "brand"))
#  )

## -----------------------------------------------------------------------------
summary(mnl_pref)

## ---- eval=FALSE--------------------------------------------------------------
#  mnl_wtp <- logitr(
#      data       = yogurt,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = "brand",
#      priceName  = "price",
#      modelSpace = "wtp",
#      options    = list(numMultiStarts = 10)
#  )

## ---- eval=FALSE--------------------------------------------------------------
#  mxl_pref <- logitr(
#      data       = yogurt,
#      choiceName = "choice",
#      obsIDName  = "obsID",
#      parNames   = c("price", "brand"),
#      randPars   = c(brand = "n"),
#      options    = list(numMultiStarts = 10)
#  )

## -----------------------------------------------------------------------------
wtp(mnl_pref, priceName = "price")

## -----------------------------------------------------------------------------
wtpCompare(mnl_pref, mnl_wtp, priceName = "price")

## -----------------------------------------------------------------------------
alts <- subset(
  yogurt, obsID %in% c(42, 13),
  select = c('obsID', 'choice', 'price', 'feat', 'brand')
)

alts

## -----------------------------------------------------------------------------
probs <- predictProbs(
  model     = mnl_pref,
  alts      = alts,
  obsIDName = "obsID"
)

probs

## -----------------------------------------------------------------------------
probs <- predictProbs(
  model     = mnl_wtp,
  alts      = alts,
  obsIDName = "obsID"
)

probs

## -----------------------------------------------------------------------------
choices <- predictChoices(
  model     = mnl_pref,
  alts      = yogurt,
  obsIDName = "obsID"
)

# Preview actual and predicted choices
head(choices[c('obsID', 'choice', 'choice_predict')])

## -----------------------------------------------------------------------------
chosen <- subset(choices, choice == 1)
chosen$correct <- chosen$choice == chosen$choice_predict
sum(chosen$correct) / nrow(chosen)

