## ----setup, include=FALSE, message=FALSE, warning=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.retina = 3,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(logitr)

model <- logitr(
  data    = yogurt,
  outcome = "choice",
  obsID   = "obsID",
  pars    = c("price", "feat", "brand")
)

summary(model)

## -----------------------------------------------------------------------------
coefs <- coef(summary(model))
coefs

## -----------------------------------------------------------------------------
library(broom)

coefs <- tidy(model)
coefs

## -----------------------------------------------------------------------------
coefs <- tidy(model, conf.int = TRUE, conf.level = 0.95)
coefs

## -----------------------------------------------------------------------------
coef(model)

## -----------------------------------------------------------------------------
se(model)

## -----------------------------------------------------------------------------
logLik(model)

## -----------------------------------------------------------------------------
vcov(model)

## -----------------------------------------------------------------------------
glance(model)

## -----------------------------------------------------------------------------
library(gtsummary)

model |> 
  tbl_regression()

## -----------------------------------------------------------------------------
model |> 
  tbl_regression(
    label = list(
        feat = "Newspaper ad shown?",
        brand = "Yogurt's brand"
    )
  )

## ---- eval=FALSE--------------------------------------------------------------
#  x <- model |>
#    tbl_regression()

## -----------------------------------------------------------------------------
model1 <- model

model2 <- logitr(
  data    = yogurt,
  outcome = "choice",
  obsID   = "obsID",
  pars    = c("price*feat", "brand")
)

# Make individual tables
t1 <- tbl_regression(model1)
t2 <- tbl_regression(model2)

# Merge tables
tbl_merge(
  tbls = list(t1, t2),
  tab_spanner = c("**Baseline**", "**Interaction**")
)

## -----------------------------------------------------------------------------
library(texreg)

screenreg(model, stars = c(0.01, 0.05, 0.1))

## -----------------------------------------------------------------------------
library(texreg)

texreg(model, stars = c(0.01, 0.05, 0.1))

## -----------------------------------------------------------------------------
model1 <- model

model2 <- logitr(
  data    = yogurt,
  outcome = "choice",
  obsID   = "obsID",
  pars    = c("price*feat", "brand")
)

screenreg(
  list(
    model1,
    model2
  ),
  stars = c(0.01, 0.05, 0.1),
  custom.model.names = c("Baseline", "Interaction")
)

