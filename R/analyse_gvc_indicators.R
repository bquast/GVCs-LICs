# analyse_gvc_indicators.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load(file = 'data/new_gvc_indicators.RData')
load(file = 'data/nrca_df.RData')
# load("data/country_vars.RData") # NOT USING THIS ONE, USING COUNTRY_CHARS
load(file = 'data/country_chars.RData')
load(file = 'data/extra_vars.RData')
load(file = 'data/w1995_2011.RData')
# load("data/trca.RData")


# load required libraries
library(dplyr)
library(ggvis)
library(magrittr)


# country_vars <- extra
country_chars$iso3 <- tolower(country_chars$iso3)


# merge wwz and country chars
w1995_2011 %<>% merge(country_chars, by.x = 'Exporting_Country', by.y = 'iso3')


# merge gvc indicators and country vars
gvc_indicators %<>% merge(country_chars, by.x = 'country', by.y = 'iso3', all.x = TRUE)


# save
save(gvc_indicators, file = 'data/gvc_indicators_merged.RData')


# merge gvc indicators and nrca
gvc_indicators %<>% merge(nrca, by.x = c("ctry", "isic", "year"), by.y = c("country", "industry", "year") )
gvc_indicators %<>% merge(trca, by = c("ctry", "isic", "year") )

# # create logical gdp var
# gvc_indicators$lic  <- gvc_indicators$avg_gdppc <=  6000
# gvc_indicators$lmic <- gvc_indicators$avg_gdppc <= 12000
# gvc_indicators$hic  <- gvc_indicators$avg_gdppc >= 12000


## create basic summaries

# e2r
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r = sum(e2r) ) %>%
  ggvis(~year, ~e2r ) %>%
  layer_lines()

# e2r class == L
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rL = sum(e2rL) ) %>%
  ggvis(~year, ~e2rL ) %>%
  layer_lines()

# e2r class == LM
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rLM = sum(e2rLM) ) %>%
  ggvis(~year, ~e2rLM ) %>%
  layer_lines()

# e2r class == UM
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rUM = sum(e2rUM) ) %>%
  ggvis(~year, ~e2rUM ) %>%
  layer_lines()

# e2r class == H
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rH = sum(e2rH) ) %>%
  ggvis(~year, ~e2rH ) %>%
  layer_lines()

## create basic LOG summaries

# e2r log
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rlog = log(sum(e2r)) ) %>%
  ggvis(~year, ~e2rlog ) %>%
  layer_lines()

# e2r log class == L
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rLlog = log(sum(e2rL)) ) %>%
  ggvis(~year, ~e2rLlog ) %>%
  layer_lines()

# e2r log class == LM
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rLMlog = log(sum(e2rLM)) ) %>%
  ggvis(~year, ~e2rLMlog ) %>%
  layer_lines()

# e2r log class == UM
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rUMlog = log(sum(e2rUM)) ) %>%
  ggvis(~year, ~e2rUMlog ) %>%
  layer_lines()

# e2r log class == H
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2rHlog = log(sum(e2rH)) ) %>%
              ggvis(~year, ~e2rHlog ) %>%
              layer_lines()

# i2e
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e = sum(i2e) ) %>%
  ggvis(~year, ~i2e ) %>%
  layer_lines()

# i2e class == L
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eL = sum(i2eL) ) %>%
  ggvis(~year, ~i2eL ) %>%
  layer_lines()

# i2e class == LM
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eLM = sum(i2eLM) ) %>%
  ggvis(~year, ~i2eLM ) %>%
  layer_lines()

# i2e class == UM
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eUM = sum(i2eUM) ) %>%
  ggvis(~year, ~i2eUM ) %>%
  layer_lines()

# i2e class == H
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eH = sum(i2eH) ) %>%
  ggvis(~year, ~i2eH ) %>%
  layer_lines()

# i2e log
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2elog = log(sum(i2e)) ) %>%
  ggvis(~year, ~i2elog ) %>%
  layer_lines()

# i2e log class == L
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eLlog = log(sum(i2eL)) ) %>%
  ggvis(~year, ~i2eLlog ) %>%
  layer_lines()

# i2e log class == LM
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eLMlog = log(sum(i2eLM)) ) %>%
  ggvis(~year, ~i2eLMlog ) %>%
  layer_lines()

# i2e log class == UM
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eUMlog = log(sum(i2eUM)) ) %>%
  ggvis(~year, ~i2eUMlog ) %>%
  layer_lines()

# i2e log class == H
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2eHlog = log(sum(i2eH)) ) %>%
  ggvis(~year, ~i2eHlog ) %>%
  layer_lines()

# add PVC
# add intermediate imports (?)

# plot gvc_length
# RDV
w1995_2011 %>%
  group_by(year) %>%
  summarise( RDV = ( sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2) ) / sum(texp) ) %>%
  ggvis(~year, ~RDV) %>%
  layer_lines()

# PDC
w1995_2011 %>%
  group_by(year) %>%
  summarise( PDC = ( sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) / sum(texp) ) %>%
  ggvis(~year, ~PDC) %>%
  layer_lines()

# both
w1995_2011 %>%
  group_by(year) %>%
  summarise( RDV = ( sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2) ) / sum(texp),
             PDC = ( sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) / sum(texp) ) %>%
  ggvis(~year, ~RDV, stroke="RDV") %>%
  layer_lines() %>%
  layer_lines(~year, ~PDC, stroke="PDC")
