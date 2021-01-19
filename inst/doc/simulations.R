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
sim_mnl_pref <- readRDS(here::here('inst', 'extdata', 'sim_mnl_pref.Rds'))
sim_mnl_wtp <- readRDS(here::here('inst', 'extdata', 'sim_mnl_wtp.Rds'))
sim_mxl_pref <- readRDS(here::here('inst', 'extdata', 'sim_mxl_pref.Rds'))
sim_mxl_wtp <- readRDS(here::here('inst', 'extdata', 'sim_mxl_wtp.Rds'))

## -----------------------------------------------------------------------------
alts <- subset(yogurt, obsID == 42,
               select = c('feat', 'price', 'hiland', 'weight', 'yoplait'))
row.names(alts) <- c('dannon', 'hiland', 'weight', 'yoplait')
alts

## ---- eval=FALSE--------------------------------------------------------------
#  sim_mnl_pref <- simulateShares(mnl_pref, alts, alpha = 0.025)

## -----------------------------------------------------------------------------
sim_mnl_pref

## ---- eval=FALSE--------------------------------------------------------------
#  sim_mnl_wtp <- simulateShares(mnl_wtp, alts, priceName = 'price')

## -----------------------------------------------------------------------------
sim_mnl_wtp

## ---- eval=FALSE--------------------------------------------------------------
#  sim_mxl_pref <- simulateShares(mxl_pref, alts)

## -----------------------------------------------------------------------------
sim_mxl_pref

## ---- eval=FALSE--------------------------------------------------------------
#  sim_mxl_wtp <- simulateShares(mxl_wtp, alts, priceName = 'price')

## -----------------------------------------------------------------------------
sim_mxl_wtp

## ---- fig.width=6, fig.height=4-----------------------------------------------
library(ggplot2)

sims <- rbind(sim_mnl_pref, sim_mnl_wtp, sim_mxl_pref, sim_mxl_wtp)
sims$model <- c(rep("mnl_pref", 4), rep("mnl_wtp", 4),
                rep("mxl_pref", 4), rep("mxl_wtp", 4))
sims$alt <- rep(row.names(alts), 4)

ggplot(sims, aes(x = alt, y = share_mean, fill = model)) +
    geom_bar(stat = 'identity', width = 0.7, position = "dodge") +
    geom_errorbar(aes(ymin = share_low, ymax = share_high),
                  width = 0.2, position = position_dodge(width = 0.7)) +
    scale_y_continuous(limits = c(0, 1)) +
    labs(x = 'Alternative', y = 'Expected Share') +
    theme_bw()

