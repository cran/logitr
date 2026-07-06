## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  fig.width = 7.252,
  fig.height = 4,
  comment = "#>",
  fig.retina = 3
)

## ----echo = FALSE-------------------------------------------------------------
library(logitr)
library(dplyr)

# runtimes <- readr::read_csv(file.path('data-raw', 'runtimes.csv'))
runtimes %>%
    mutate(pkg = sub(" .*", "", package)) %>%
    distinct(pkg, version) %>%
    kableExtra::kbl(col.names = c("package", "version"))

## -----------------------------------------------------------------------------
library(logitr)
library(dplyr)
library(tidyr)
library(kableExtra) # For tables

times <- runtimes %>% select(-version)
logitr_time <- times %>%
    filter(package == "logitr (1 cores)") %>%
    rename(time_logitr = time_sec)
time_compare <- times %>%
    left_join(select(logitr_time, -package), by = "numDraws") %>%
    mutate(mult = round(time_sec / time_logitr, 1)) 
# Compare raw times (seconds)
time_compare %>%
    select(package, numDraws, time_sec) %>%
    mutate(time_sec = round(time_sec, 1)) %>%
    pivot_wider(names_from = numDraws, values_from = time_sec) %>%
    kbl()

## -----------------------------------------------------------------------------
time_compare %>%
    select(package, numDraws, mult) %>%
    pivot_wider(names_from = numDraws, values_from = mult) %>%
    kbl()

## ----benchmark-figure, echo=FALSE, out.width="100%"---------------------------
knitr::include_graphics('benchmark.png')

## -----------------------------------------------------------------------------
runtimes_draws %>%
    mutate(time_sec = round(time_sec, 1)) %>%
    pivot_wider(names_from = numDraws, values_from = time_sec) %>%
    kbl()

## ----benchmark-draws-figure, echo=FALSE, out.width="100%"---------------------
knitr::include_graphics('benchmark_draws.png')

## -----------------------------------------------------------------------------
loglik_summary <- loglik_draws %>%
    group_by(numDraws) %>%
    summarise(
        min = min(logLik),
        max = max(logLik),
        range = max(logLik) - min(logLik),
        sd = sd(logLik),
        median_time_sec = median(time_sec)
    ) %>%
    mutate(across(min:median_time_sec, \(x) round(x, 1)))

kbl(loglik_summary)

## ----benchmark-loglik-figure, echo=FALSE, out.width="100%"--------------------
knitr::include_graphics('benchmark_loglik.png')

