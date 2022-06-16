## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  fig.width = 7.252,
  fig.height = 4,
  comment = "#>",
  fig.retina = 3
)

## -----------------------------------------------------------------------------
library(logitr)
library(dplyr)
library(tidyr)
library(kableExtra) # For tables

numDraws <- unique(runtimes$numDraws)
logitr_time <- runtimes %>%
    filter(package == "logitr") %>%
    rename(time_logitr = time_sec)
time_compare <- runtimes %>%
    left_join(select(logitr_time, -package), by = "numDraws") %>%
    mutate(mult = round(time_sec/ time_logitr, 1)) %>%
    select(-time_logitr)
# Compare raw times
time_compare %>%
    select(-mult) %>%
    pivot_wider(names_from = numDraws, values_from = time_sec) %>% 
    kbl()
# Compare how many times slower compared to logitr
time_compare %>%
    select(-time_sec) %>%
    pivot_wider(names_from = numDraws, values_from = mult) %>% 
    kbl()

## ---- eval=FALSE--------------------------------------------------------------
#  library(ggplot2)
#  library(ggrepel)
#  
#  plotColors <- c("black", RColorBrewer::brewer.pal(n = 5, name = "Set1"), "gold")
#  benchmark <- runtimes %>%
#      ggplot(aes(x = numDraws, y = time_sec, color = package)) +
#      geom_line() +
#      geom_point() +
#      geom_text_repel(
#          data = . %>% filter(numDraws == max(numDraws)),
#          aes(label = package),
#          hjust = 0, nudge_x = 40, direction = "y",
#          size = 4.5, segment.size = 0
#      ) +
#      scale_x_continuous(
#          limits = c(0, 1200),
#          breaks = numDraws,
#          labels = scales::comma) +
#      scale_y_continuous(limits = c(0, 300), breaks = seq(0, 300, 100)) +
#      scale_color_manual(values = plotColors) +
#      guides(
#          point = guide_legend(override.aes = list(label = "")),
#          color = guide_legend(override.aes = list(label = ""))) +
#      theme_bw(base_size = 18) +
#      theme(
#          panel.grid.minor = element_blank(),
#          panel.grid.major.x = element_blank(),
#          legend.position = "none",
#          axis.line.x = element_blank(),
#          axis.ticks.x = element_blank()
#      ) +
#      labs(
#          x = "Number of random draws",
#          y = "Computation time (seconds)"
#      )
#  
#  benchmark

## ---- eval=FALSE, echo=FALSE--------------------------------------------------
#  ggsave('benchmark.png', benchmark, width = 8.5, height = 6)

## ----probabilities, echo=FALSE------------------------------------------------
knitr::include_graphics('benchmark.png')

