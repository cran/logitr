## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.path   = "figs/",
  fig.retina = 3,
  comment = "#>"
)

set.seed(5678)

## -----------------------------------------------------------------------------
library("logitr")

mnl_pref <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('price', 'feat', 'brand')
)

probs <- predict(mnl_pref)
head(probs)

## -----------------------------------------------------------------------------
probs <- predict(mnl_pref, returnData = TRUE)
head(probs)

## -----------------------------------------------------------------------------
data <- subset(
  yogurt, obsID %in% c(42, 13),
  select = c('obsID', 'alt', 'price', 'feat', 'brand'))

probs_mnl_pref <- predict(
  mnl_pref,
  newdata = data,
  obsID = "obsID",
)

probs_mnl_pref

## -----------------------------------------------------------------------------
probs_mnl_pref <- predict(
  mnl_pref,
  newdata = data,
  obsID = "obsID",
  ci = 0.95
)

probs_mnl_pref

## -----------------------------------------------------------------------------
mnl_wtp <- logitr(
  data    = yogurt,
  outcome = 'choice',
  obsID   = 'obsID',
  pars    = c('feat', 'brand'),
  price   = 'price',
  modelSpace = 'wtp',
  numMultiStarts = 10
)

probs_mnl_wtp <- predict(
  mnl_wtp,
  newdata = data,
  obsID = "obsID",
  price = "price",
  ci = 0.95
)

probs_mnl_wtp

## ---- eval=FALSE--------------------------------------------------------------
#  library("ggplot2")
#  
#  probs <- rbind(probs_mnl_pref, probs_mnl_wtp)
#  probs$model <- c(rep("mnl_pref", 8), rep("mnl_wtp", 8))
#  probs$alt <- rep(c("dannon", "hiland", "weight", "yoplait"), 4)
#  probs$obs <- paste0("Observation ID: ", probs$obsID)
#  ggplot(probs, aes(x = alt, y = predicted_prob, fill = model)) +
#      geom_bar(stat = 'identity', width = 0.7, position = "dodge") +
#      geom_errorbar(aes(ymin = predicted_prob_lower, ymax = predicted_prob_upper),
#                    width = 0.2, position = position_dodge(width = 0.7)) +
#      facet_wrap(vars(obs)) +
#      scale_y_continuous(limits = c(0, 1)) +
#      labs(x = 'Alternative', y = 'Expected Choice Probabilities') +
#      theme_bw()

## ----probabilities, echo=FALSE------------------------------------------------
knitr::include_graphics('probs.png')

## -----------------------------------------------------------------------------
outcomes_pref <- predict(mnl_pref, type = "outcome", returnData = TRUE)
head(outcomes_pref)

outcomes_wtp <- predict(mnl_wtp, type = "outcome", returnData = TRUE)
head(outcomes_wtp)

## -----------------------------------------------------------------------------
chosen_pref <- subset(outcomes_pref, choice == 1)
chosen_pref$correct <- chosen_pref$choice == chosen_pref$predicted_outcome
accuracy_pref <- sum(chosen_pref$correct) / nrow(chosen_pref)
accuracy_pref

chosen_wtp <- subset(outcomes_wtp, choice == 1)
chosen_wtp$correct <- chosen_wtp$choice == chosen_wtp$predicted_outcome
accuracy_wtp <- sum(chosen_wtp$correct) / nrow(chosen_wtp)
accuracy_wtp

