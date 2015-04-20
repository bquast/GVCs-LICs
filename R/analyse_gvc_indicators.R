# analyse_gvc_indicators.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load("data/gvc_indicators.RData")
load("data/nrca_df.RData")
load("data/country_vars.RData")
w1995_2008 <- readRDS("data/w1995_2008.rds")

# load required libraries
library(dplyr)
library(ggvis)

# contruct avg_pop and gdp
country_vars %<>%
  group_by(ctry) %>%
  summarise(avg_pop = mean(pop)) %>%
  merge(country_vars, . , by = "ctry")
country_vars$avg_gdp <- with(country_vars, avg_pop * avg_gdppc)

# create factor gdp var
country_vars$ic   <- ifelse(country_vars$avg_gdppc <= 6000, "lic", ifelse(country_vars$avg_gdppc > 12000, "hic", "mic")  )

# merge wwz and country vars
w1995_2008 <- merge(w1995_2008,
                    country_vars,
                    by.x = c("year", "Exporting_Country"),
                    by.y = c("year", "ctry")              )

# merge gvc indicators and country vars
gvc_indicators <- merge(gvc_indicators, country_vars, by = c("ctry", "year") )

# create logical gdp var
gvc_indicators$lic  <- gvc_indicators$avg_gdppc <=  6000
gvc_indicators$lmic <- gvc_indicators$avg_gdppc <= 12000
gvc_indicators$hic  <- gvc_indicators$avg_gdppc >= 12000


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

# by country
gvc_indicators %>%
  group_by(ctry) %>%
  summarise(i2e = sum(fvax_ams_ik) / sum(exports_ik) ) %>%
  top_n(10, i2e) %>%
  ggvis(~factor(ctry), ~i2e ) %>%
  layer_bars()

# by industry
gvc_indicators %>%
  group_by(ind_name) %>%
  summarise(i2e = sum(fvax_ams_ik) * 100 / sum(exports_ik) ) %>%
  top_n(10) %>%
  ggvis(~factor(ind_name), ~i2e) %>%
  layer_bars() %>%
  add_axis("x", title = "industry name")

# plot nrca
nrca %>%
  group_by(country) %>%
  ggvis(~year, ~nrca) %>%
  layer_lines(stroke=~country)

nrca %>%
  filter(ic != "hic")
  group_by(country) %>%
  ggvis(~year, ~nrca) %>%
  layer_lines(stroke=~country)

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


### LMICs
# LMIC definition I

# i2e hi lo
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e_lomid = sum(fvax_lomidinc_ams_ik) / sum(exports_ik),
            i2e_hi    = sum(fvax_hiinc_ams_ik)    / sum(exports_ik) ) %>%
  ggvis(~year, ~i2e_lomid ) %>%
  layer_lines(stroke="i2e_lomid") %>%
  layer_lines(~year, ~i2e_hi, stroke="i2e_hi")

# e2r hi lo
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r_lomid = sum(dvar_lomidinc_ik) / sum(exports_ik),
            e2r_hi    = sum(dvar_hiinc_ik)    / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r_lomid ) %>%
  layer_lines(stroke="e2r_lomid") %>%
  layer_lines(~year, ~e2r_hi, stroke="e2r_hi")


# LMIC definition II

# i2e hi lo
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e_lomid = sum(fvax_lomidinc1_ams_ik) / sum(exports_ik),
            i2e_hi    = sum(fvax_hiinc1_ams_ik)    / sum(exports_ik) ) %>%
  ggvis(~year, ~i2e_lomid ) %>%
  layer_lines(stroke="i2e_lomid") %>%
  layer_lines(~year, ~i2e_hi, stroke="i2e_hi")

# e2r hi lo
gvc_indicators %>%
  group_by(year) %>%
  summarise(e2r_lomid = sum(dvar_lomidinc1_ik) / sum(exports_ik),
            e2r_hi    = sum(dvar_hiinc1_ik)    / sum(exports_ik) ) %>%
  ggvis(~year, ~e2r_lomid ) %>%
  layer_lines(stroke="e2r_lomid") %>%
  layer_lines(~year, ~e2r_hi, stroke="e2r_hi")

# LMIC defition III
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


# WWZ by IC

# use mean in stead of sum?
# RDV
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( RDV = sum(RDV_INT) + sum(RDV_FIN) + sum(RDV_FIN2) ) %>%
  ggvis(~year, ~RDV, stroke = ~ic) %>%
  layer_lines()

# PDC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( PDC = sum(DDC_FIN) + sum(DDC_INT) + sum(ODC) + sum(MDC) ) %>%
  ggvis(~year, ~PDC, stroke = ~ic) %>%
  layer_lines()

# using mean here
# DVA FIN by IC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( DVA_FIN = mean(DVA_FIN) ) %>%
  ggvis(~year, ~DVA_FIN, stroke = ~ic) %>%
  layer_lines()

# DVA FIN for LIC
w1995_2008 %>%
  filter(ic == "lic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( DVA_FIN = mean(DVA_FIN) ) %>%
  ggvis(~year, ~DVA_FIN, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()

# DVA INT by LIC
w1995_2008 %>%
  group_by(year, ic) %>%
  summarise( DVA_INT = mean(DVA_INT) ) %>%
  ggvis(~year, ~DVA_INT, stroke = ~ic) %>%
  layer_lines()

# DVA INT for LIC
w1995_2008 %>%
  filter(ic == "lic") %>%
  group_by(year, Exporting_Country) %>%
  summarise( DVA_INT = mean(DVA_INT) ) %>%
  ggvis(~year, ~DVA_INT, stroke = ~factor(Exporting_Country) ) %>%
  layer_lines()
