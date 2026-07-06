## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)
library(logitr)

## ----eval=FALSE---------------------------------------------------------------
# model <- logitr(
#   data     = yogurt,
#   outcome  = "choice",
#   obsID    = "obsID",
#   panelID  = "id",
#   pars     = c("price", "feat", "brand"),
#   randPars = c(feat = "n")
# )

## ----eval=FALSE---------------------------------------------------------------
# model <- logitr(
#   data       = yogurt,
#   outcome    = "choice",
#   obsID      = "obsID",
#   panelID    = "id",
#   pars       = c("price", "feat", "brand"),
#   randPars   = c(feat = "n"),
#   numDraws   = 500,
#   numThreads = 4
# )

## ----eval=FALSE---------------------------------------------------------------
# model <- logitr(
#   data          = yogurt,
#   outcome       = "choice",
#   obsID         = "obsID",
#   panelID       = "id",
#   pars          = c("price", "feat", "brand"),
#   randPars      = c(feat = "n"),
#   numDraws      = 10000,
#   numDrawsBatch = 500,
#   backend       = "cpu"
# )

