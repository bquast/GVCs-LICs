# analyse_gvc_indicators.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load("data/gvc_indicators.RData")
load("data/nrca_df.RData")
load("data/country_vars.RData")
load("data/w1995_2008.RData")
load("data/trca.RData")

# load required libraries
library(dplyr)
library(ggvis)
library(magrittr)

# contruct avg_pop and gdp
country_vars %<>%
  group_by(ctry) %>%
  summarise(avg_pop = mean(pop)) %>%
  merge(country_vars, . , by = "ctry")

country_vars$avg_gdp <- with(country_vars, avg_pop * avg_gdppc)

# create factor gdp var
country_vars$ic      <- with(country_vars, ifelse(avg_gdppc <= 6000, "lic",
                                                  ifelse(avg_gdppc > 12000, "hic", "mic") ) )

# merge wwz and country vars
w1995_2008 %<>% merge(country_vars,
                      by.x = c("year", "Exporting_Country"),
                      by.y = c("year", "ctry")              )

# merge gvc indicators and country vars
gvc_indicators %<>% merge(country_vars, by = c("ctry", "year") )

# merge gvc indicators and nrca
gvc_indicators %<>% merge(nrca, by.x = c("ctry", "isic", "year"), by.y = c("country", "industry", "year") )
gvc_indicators %<>% merge(trca, by = c("ctry", "isic", "year") )

# # create logical gdp var
# gvc_indicators$lic  <- gvc_indicators$avg_gdppc <=  6000
# gvc_indicators$lmic <- gvc_indicators$avg_gdppc <= 12000
# gvc_indicators$hic  <- gvc_indicators$avg_gdppc >= 12000


## create basic summaries

# i2e
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~i2e ) %>%
  layer_lines()

# e2r
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r ) %>%
  layer_lines()

# GVC growth
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik),
            i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r ) %>%
  layer_lines(stroke="e2r") %>%
  layer_lines(~year, ~i2e, stroke="i2e")

# i2e against GDP
gvc_indicators %>%
  group_by(ctry) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik), avg_gdp = mean(avg_gdp) ) %>%
  ggvis(~avg_gdp, ~i2e ) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm")

# i2e against natural resources
gvc_indicators %>%
  group_by(ctry) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik), nat_res_exp_sha_t_3 = mean(nat_res_exp_sha_t_3) ) %>%
  ggvis(~nat_res_exp_sha_t_3, ~i2e ) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm")

# e2r against natural resources
gvc_indicators %>%
  group_by(ctry) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik), nat_res_exp_sha_t_3 = mean(nat_res_exp_sha_t_3) ) %>%
  ggvis(~nat_res_exp_sha_t_3, ~e2r ) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm")

# i2e by country
gvc_indicators %>%
  group_by(ctry) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  top_n(10, i2e) %>%
  ggvis(~factor(ctry), ~i2e ) %>%
  layer_bars()

# i2e by industry
gvc_indicators %>%
  group_by(ind_name) %>%
  summarise(i2e = sum(fvax_ams_ik) * 100 / sum(exports_ik) ) %>%
  top_n(10) %>%
  ggvis(~factor(ind_name), ~i2e) %>%
  layer_bars() %>%
  add_axis("x", title = "industry name")


## TRCA NRCA

# TRCA vs NRCA for China, ELQ
gvc_indicators %>%
  filter(ctry == "chn") %>%
  filter(ind_name == "elq") %>%
  group_by(year) %>%
  summarise( trca = sum(rca), nrca = sum(nrca) ) %>%
  ggvis(~year, ~trca, stroke = "trca") %>%
  layer_lines() %>%
  layer_lines(~year, ~nrca, stroke="nrca")

# TRCA vs NRCA for China: CEQ
gvc_indicators %>%
  filter(ctry == "chn") %>%
  filter(ind_name == "ceq") %>%
  group_by(year) %>%
  summarise( trca = sum(rca), nrca = sum(nrca) ) %>%
  ggvis(~year, ~trca, stroke = "trca") %>%
  layer_lines() %>%
  layer_lines(~year, ~nrca, stroke="nrca")

# TRCA vs NRCA for China: CEQ
gvc_indicators %>%
  filter(ctry == "chn") %>%
  filter(ind_name == "ceq") %>%
  group_by(year) %>%
  summarise( trca = sum(rca.x), nrca = sum(nrca) ) %>%
  ggvis(~year, ~trca, stroke = "trca") %>%
  layer_lines() %>%
  layer_lines(~year, ~nrca, stroke="nrca")

# aggregate NRCA of LICs
gvc_indicators %>%
  filter(ic == "lic") %>%
  group_by(ctry, year) %>%
  summarise( nrca = sum(nrca) ) %>%
  ggvis(~year, ~nrca, stroke=~factor(ctry) ) %>%
  layer_lines()

# NRCA china by industry
gvc_indicators %>%
  filter(ctry == "chn") %>%
  group_by(year, ind_name) %>%
  summarise( nrca = sum(nrca) ) %>%
  ggvis(~year, ~nrca, stroke=~ind_name ) %>%
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


## by *IC (LIC/MIC/HIC)

# i2e by year, ic
gvc_indicators %>%
  group_by(year, ic) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~i2e, stroke = ~ic ) %>%
  layer_lines()

# i2e by country, ic
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  ggvis(~factor(ctry), ~i2e, fill = ~ic ) %>%
  layer_bars() %>%
  add_axis("x", properties = axis_props(label=list(angle=45, align="left")) )

# i2e by industry, ic
gvc_indicators %>%
  group_by(ind_name, ic) %>%
  summarise(i2e = sum(fvax_ams_ik) * 100 / sum(exports_ik) ) %>%
  ggvis(~ind_name, ~i2e, fill = ~ic ) %>%
  layer_bars() %>%
  add_axis("x", properties = axis_props(label=list(angle=45, align="left")) )

# i2e against GDP
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik), avg_gdp = mean(avg_gdp) ) %>%
  ggvis(~avg_gdp, ~i2e ) %>%
  layer_points(fill = ~ic) %>%
  layer_model_predictions(model = "lm")

# i2e against natural resources
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik), nat_res_exp_sha_t_3 = mean(nat_res_exp_sha_t_3) ) %>%
  ggvis(~nat_res_exp_sha_t_3, ~i2e) %>%
  layer_points(fill = ~ic)

# e2r by year, ic
gvc_indicators %>%
  group_by(year, ic) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r, stroke = ~ic ) %>%
  layer_lines()

# e2r by country, ic
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik) ) %>%
  ggvis(~factor(ctry), ~e2r, fill = ~ic ) %>%
  layer_bars() %>%
  add_axis("x", properties = axis_props(label=list(angle=45, align="left")) )

# e2r by country, ic
gvc_indicators %>%
  group_by(ind_name, ic) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik) ) %>%
  ggvis(~ind_name, ~e2r, fill = ~ic ) %>%
  layer_bars() %>%
  add_axis("x", properties = axis_props(label=list(angle=45, align="left")) )

# e2r by country, ic
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik), avg_gdp = mean(avg_gdp)  ) %>%
  ggvis(~avg_gdp, ~e2r, fill = ~ic ) %>%
  layer_bars() %>%
  add_axis("x", properties = axis_props(label=list(angle=45, align="left")) )

# e2r by country, ic
gvc_indicators %>%
  group_by(ctry, ic) %>%
  summarise(e2r = sum(dvar_ik) / sum(exports_ik), nat_res_exp_sha_t_3 = mean(nat_res_exp_sha_t_3) ) %>%
  ggvis(~nat_res_exp_sha_t_3, ~e2r, fill = ~ic ) %>%
  layer_points()


## WWZ by IC

# RDV
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( RDV = ( sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2) ) / sum(texp) ) %>%
  ggvis(~year, ~RDV, stroke = ~ic) %>%
  layer_lines()

# PDC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( PDC = ( sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) / sum(texp) ) %>%
  ggvis(~year, ~PDC, stroke = ~ic) %>%
  layer_lines()


## FVA FIN INT by *IC

# FVA FIN by year, IC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( FVA_FIN = ( sum(OVA_FIN) + sum(MVA_FIN) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_FIN, stroke = ~ic) %>%
  layer_lines()

# FVA INT by year, IC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( FVA_INT = ( sum(OVA_INT) + sum(MVA_INT) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_INT, stroke = ~ic) %>%
  layer_lines()


## FVA FIN INT by exporting country

# FVA FIN by year, Exporting Country, for LIC
w1995_2008 %>%
  filter(ic == "lic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_FIN = ( sum(OVA_FIN) + sum(MVA_FIN) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_FIN, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# FVA INT by year, Exporting Country, for LIC
w1995_2008 %>%
  filter(ic == "lic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_INT = ( sum(OVA_INT) + sum(MVA_INT) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_INT, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# FVA FIN by year, Exporting Country, for MIC
w1995_2008 %>%
  filter(ic == "mic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_FIN = ( sum(OVA_FIN) + sum(MVA_FIN) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_FIN, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# FVA INT by year, Exporting Country, for MIC
w1995_2008 %>%
  filter(ic == "mic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_INT = ( sum(OVA_INT) + sum(MVA_INT) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_INT, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# FVA FIN by year, Exporting Country, for HIC
w1995_2008 %>%
  filter(ic == "hic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_FIN = ( sum(OVA_FIN) + sum(MVA_FIN) ) /sum(texp) ) %>%
  ggvis(~year, ~FVA_FIN, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# FVA INT by year, Exporting Country, for HIC
w1995_2008 %>%
  filter(ic == "hic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( FVA_INT = ( sum(OVA_INT) + sum(MVA_INT) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_INT, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()


## DViX by Exporting Country

# DVix by year, Exporting Country, for LICs
w1995_2008 %>%
  filter(ic == "lic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( DViX_Fsr = sum(DViX_Fsr) / sum(texp) ) %>%
  ggvis(~year, ~DViX_Fsr, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

w1995_2008 %>%
  filter(Exporting_Country == "chn") %>%
  group_by(Exporting_Industry, year) %>%
  summarise( DViX_Fsr = sum(DViX_Fsr) / sum(texp) ) %>%
  ggvis(~year, ~DViX_Fsr, stroke = ~Exporting_Industry ) %>%
  layer_lines()

# DYNAMIC!!!
# FVA INT by year, Exporting Country
w1995_2008 %>%
  group_by(year, ic, Exporting_Country) %>%
  summarise( FVA_INT = ( sum(OVA_INT) + sum(MVA_INT) ) / sum(texp) ) %>%
  ggvis(~year, ~FVA_INT, stroke = ~Exporting_Country ) %>%
  filter(ic == eval(input_radiobuttons(choices = c("lic", "mic", "hic"), selected = "lic") ) ) %>%
  layer_lines()
