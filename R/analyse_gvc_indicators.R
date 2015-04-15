# analyse_gvc_indicators.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load("data/gvc_indicators.RData")
load("data/nrca_df.RData")
load("data/w1995_2008.RData")

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

# both
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik),
            i2e = sum(fvax_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r ) %>%
  layer_lines(stroke="e2r") %>%
  layer_lines(~year, ~i2e, stroke="i2e")

# plot nrca
nrca %>%
  group_by() %>%
  ggvis(~year, ~nrca) %>%
  layer_lines()

# add PVC
# add intermediate imports (?)

# plot gvc_length
# RDV
w1995_2008 %>%
  group_by(year) %>%
  summarise( RDV = sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2) ) %>%
  ggvis(~year, ~RDV) %>%
  layer_lines()

# PDC
w1995_2008 %>%
  group_by(year) %>%
  summarise( PDC = sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) %>%
  ggvis(~year, ~PDC) %>%
  layer_lines()

# both
w1995_2008 %>%
  group_by(year) %>%
  summarise( RDV = sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2),
             PDC = sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) %>%
  ggvis(~year, ~RDV, stroke="RDV") %>%
  layer_lines() %>%
  layer_lines(~year, ~PDC, stroke="PDC")

#
w1995_2008 %>%
  # group_by(year, Exporting_Industry) %>%
  ggvis(~year, ~DVA_FIN) %>%
  layer_lines()
