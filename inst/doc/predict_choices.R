## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.path   = "figs/",
  fig.retina = 3,
  comment = "#>"
)
library(logitr)
# Read in results from already estimated models  so that the
# examples aren't actually run when building this page, otherwise it'll
# take much longer to build
choices_mnl_pref <- readRDS(
  here::here('inst', 'extdata', 'choices_mnl_pref.Rds'))
choices_mnl_wtp <- readRDS(
  here::here('inst', 'extdata', 'choices_mnl_wtp.Rds'))
choices_mxl_pref <- readRDS(
  here::here('inst', 'extdata', 'choices_mxl_pref.Rds'))
choices_mxl_wtp <- readRDS(
  here::here('inst', 'extdata', 'choices_mxl_wtp.Rds'))

## -----------------------------------------------------------------------------
head(yogurt)

## ---- eval=FALSE--------------------------------------------------------------
#  # Estimate the model
#  mnl_pref <- logitr(
#    data   = yogurt,
#    choice = 'choice',
#    obsID  = 'obsID',
#    pars   = c('price', 'feat', 'brand')
#  )
#  
#  # Predict choices
#  choices_mnl_pref <- predictChoices(
#    model = mnl_pref,
#    alts  = yogurt,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
# Preview actual and predicted choices
head(choices_mnl_pref[c('obsID', 'choice', 'choice_predict')])

## -----------------------------------------------------------------------------
chosen <- subset(choices_mnl_pref, choice == 1)
chosen$correct <- chosen$choice == chosen$choice_predict
sum(chosen$correct) / nrow(chosen)

## ---- eval=FALSE--------------------------------------------------------------
#  # Estimate the model
#  mnl_wtp <- logitr(
#    data       = yogurt,
#    choice     = 'choice',
#    obsID      = 'obsID',
#    pars       = c('feat', 'brand'),
#    price      = 'price',
#    modelSpace = 'wtp',
#    numMultiStarts = 10
#  )
#  
#  # Make predictions
#  choices_mnl_wtp <- predictChoices(
#    model = mnl_wtp,
#    alts  = yogurt,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
# Preview actual and predicted choices
head(choices_mnl_wtp[c('obsID', 'choice', 'choice_predict')])

## ---- eval=FALSE--------------------------------------------------------------
#  # Estimate the model
#  mxl_pref <- logitr(
#    data     = yogurt,
#    choice   = 'choice',
#    obsID    = 'obsID',
#    pars     = c('price', 'feat', 'brand'),
#    randPars = c(feat = 'n', brand = 'n'),
#    numMultiStarts = 5
#  )
#  
#  # Make predictions
#  choices_mxl_pref <- predictChoices(
#    model = mxl_pref,
#    alts  = yogurt,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
# Preview actual and predicted choices
head(choices_mxl_pref[c('obsID', 'choice', 'choice_predict')])

## ---- eval=FALSE--------------------------------------------------------------
#  # Estimate the model
#  mxl_wtp <- logitr(
#    data       = yogurt,
#    choice     = 'choice',
#    obsID      = 'obsID',
#    pars       = c('feat', 'brand'),
#    price      = 'price',
#    randPars   = c(feat = 'n', brand = 'n'),
#    modelSpace = 'wtp',
#    numMultiStarts = 5
#  )
#  
#  # Make predictions
#  choices_mxl_wtp <- predictChoices(
#    model = mxl_wtp,
#    alts  = yogurt,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
# Preview actual and predicted choices
head(choices_mxl_wtp[c('obsID', 'choice', 'choice_predict')])

## -----------------------------------------------------------------------------
library(dplyr)

# Combine models into one data frame
choices <- rbind(
  choices_mnl_pref, choices_mnl_wtp, choices_mxl_pref, choices_mxl_wtp)
choices$model <- c(
  rep("mnl_pref", nrow(choices_mnl_pref)),
  rep("mnl_wtp",  nrow(choices_mnl_wtp)),
  rep("mxl_pref", nrow(choices_mxl_pref)),
  rep("mxl_wtp",  nrow(choices_mxl_wtp)))

# Compute prediction accuracy by model
choices %>%
  filter(choice == 1) %>%
  mutate(predict_correct = (choice_predict == choice)) %>%
  group_by(model) %>%
  summarise(p_correct = sum(predict_correct) / n())

