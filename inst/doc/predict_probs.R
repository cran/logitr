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
probs_mnl_pref <- readRDS(here::here('inst', 'extdata', 'probs_mnl_pref.Rds'))
probs_mnl_wtp <-  readRDS(here::here('inst', 'extdata', 'probs_mnl_wtp.Rds'))
probs_mxl_pref <- readRDS(here::here('inst', 'extdata', 'probs_mxl_pref.Rds'))
probs_mxl_wtp <-  readRDS(here::here('inst', 'extdata', 'probs_mxl_wtp.Rds'))

## -----------------------------------------------------------------------------
alts <- subset(
  yogurt, obsID %in% c(42, 13),
  select = c('obsID', 'alt', 'price', 'feat', 'brand'))

alts

## ---- eval=FALSE--------------------------------------------------------------
#  # Estimate the model
#  mnl_pref <- logitr(
#    data   = yogurt,
#    choice = 'choice',
#    obsID  = 'obsID',
#    pars   = c('price', 'feat', 'brand')
#  )
#  
#  # Predict choice probabilities
#  probs_mnl_pref <- predictProbs(
#    model = mnl_pref,
#    alts  = alts,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
probs_mnl_pref

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
#  # Predict choice probabilities
#  probs_mnl_wtp <- predictProbs(
#    model = mnl_wtp,
#    alts  = alts,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
probs_mnl_wtp

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
#  # Predict choice probabilities
#  probs_mxl_pref <- predictProbs(
#    model = mxl_pref,
#    alts  = alts,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
probs_mxl_pref

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
#  # Predict choice probabilities
#  probs_mxl_wtp <- predictProbs(
#    model = mxl_wtp,
#    alts  = alts,
#    altID = "alt",
#    obsID = "obsID"
#  )

## -----------------------------------------------------------------------------
probs_mxl_wtp

## ---- eval=FALSE--------------------------------------------------------------
#  library(ggplot2)
#  library(dplyr)
#  
#  probs <- rbind(
#    probs_mnl_pref, probs_mnl_wtp, probs_mxl_pref, probs_mxl_wtp) %>%
#    mutate(
#      model = c(rep("mnl_pref", 8), rep("mnl_wtp", 8),
#                rep("mxl_pref", 8), rep("mxl_wtp", 8)),
#      alt = rep(c("dannon", "hiland", "weight", "yoplait"), 8),
#      obs = paste0("Observation ID: ", obsID)
#    )
#  
#  ggplot(probs, aes(x = alt, y = prob_mean, fill = model)) +
#      geom_bar(stat = 'identity', width = 0.7, position = "dodge") +
#      geom_errorbar(aes(ymin = prob_low, ymax = prob_high),
#                    width = 0.2, position = position_dodge(width = 0.7)) +
#      facet_wrap(vars(obs)) +
#      scale_y_continuous(limits = c(0, 1)) +
#      labs(x = 'Alternative', y = 'Expected Choice Probabilities') +
#      theme_bw()

## ----probabilities, echo=FALSE------------------------------------------------
knitr::include_graphics('probs.png')

