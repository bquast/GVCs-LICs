# analyse_gvc_indicators.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load("data/gvc_indicators.RData")

# load required libraries
library(dplyr)
library(ggvis)

# basic exploratory analysis
summary(gvc_indicators)

## create basic summaries

# i2e
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e = sum(fvax_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~i2e ) %>%
  layer_lines()

# e2r
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r ) %>%
  layer_lines()

# add PVC
# add intermediate imports (?)
