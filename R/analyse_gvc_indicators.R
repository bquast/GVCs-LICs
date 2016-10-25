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


# merge NRCA and country chars
nrca %<>% merge(country_chars, by.x = 'country', by.y = 'iso3')

# merge wwz and country chars
w1995_2011 %<>% merge(country_chars, by.x = 'Exporting_Country', by.y = 'iso3')


# merge gvc indicators and country chars
gvc_indicators %<>% merge(country_chars, by.x = 'country', by.y = 'iso3', all.x = TRUE)


# order gvc_indicators
gvc_indicators <- gvc_indicators[order(gvc_indicators$country, gvc_indicators$sector, gvc_indicators$year),]


# year as numeric
gvc_indicators$year <- as.numeric(as.character(gvc_indicators$year))


# # remove values close to zero
# gvc_indicators[which(gvc_indicators$e2r   <= 0.01),]$e2r   <- NA
# gvc_indicators[which(gvc_indicators$e2rL  <= 0.01),]$e2rL  <- NA
# gvc_indicators[which(gvc_indicators$e2rLM <= 0.01),]$e2rLM <- NA
# gvc_indicators[which(gvc_indicators$e2rUM <= 0.01),]$e2rUM <- NA
# gvc_indicators[which(gvc_indicators$e2rH  <= 0.01),]$e2rH  <- NA

# below does NOT work
# create fd
# gvc_indicators %<>%
#   group_by(sector) %>%
#   mutate(fdloge2r   = log(e2r)   - lag(log(e2r)),
#          fdloge2rL  = log(e2rL)  - lag(log(e2rL)),
#          fdloge2rLM = log(e2rLM) - lag(log(e2rLM)),
#          fdloge2rUM = log(e2rUM) - lag(log(e2rUM)),
#          fdloge2rH  = log(e2rH)  - lag(log(e2rH)),
#          fdlogi2e   = log(i2e)   - lag(log(i2e)),
#          fdlogi2eL  = log(i2eL)  - lag(log(i2eL)),
#          fdlogi2eLM = log(i2eLM) - lag(log(i2eLM)),
#          fdlogi2eUM = log(i2eUM) - lag(log(i2eUM)),
#          fdlogi2eH  = log(i2eH)  - lag(log(i2eH))     )


# save
save(gvc_indicators, file = 'data/gvc_indicators_merged.RData')

# plot some NRCA

## Low income
nrca %>%
  group_by(country, year) %>%
  filter(class == 'L') %>%
  summarise(nrca = sum(nrca, na.rm=TRUE)) %>%
  ggvis(~year, ~nrca, stroke=~factor(country)) %>%
  layer_lines()

## Lower middle income
nrca %>%
  group_by(country, year) %>%
  filter(class == 'LM') %>%
  summarise(nrca = sum(nrca, na.rm=TRUE)) %>%
  ggvis(~year, ~nrca, stroke=~factor(country)) %>%
  layer_lines()



# merge gvc indicators and nrca
gvc_indicators %<>% merge(nrca, by.x = c("ctry", "isic", "year"), by.y = c("country", "industry", "year") )
gvc_indicators %<>% merge(trca, by = c("ctry", "isic", "year") )

# # create logical gdp var
# gvc_indicators$lic  <- gvc_indicators$avg_gdppc <=  6000
# gvc_indicators$lmic <- gvc_indicators$avg_gdppc <= 12000
# gvc_indicators$hic  <- gvc_indicators$avg_gdppc >= 12000
gvc_indicators %>%
  group_by(year) %>% ###### REMOVE CLASS HERE THEN RUN AGAIN AND PLOT
  summarise(fdloge2r   = log(sum(e2r,   na.rm=TRUE)),
            fdloge2rL  = log(sum(e2rL,  na.rm=TRUE)),
            fdloge2rLM = log(sum(e2rLM, na.rm=TRUE)),
            fdloge2rUM = log(sum(e2rUM, na.rm=TRUE)),
            fdloge2rH  = log(sum(e2rH,  na.rm=TRUE)),
            fdlogi2e   = log(sum(i2e,   na.rm=TRUE)),
            fdlogi2eL  = log(sum(i2eL,  na.rm=TRUE)),
            fdlogi2eLM = log(sum(i2eLM, na.rm=TRUE)),
            fdlogi2eUM = log(sum(i2eUM, na.rm=TRUE)),
            fdlogi2eH  = log(sum(i2eH,  na.rm=TRUE)) ) -> logged

logged$fdloge2r   <- logged$fdloge2r   - lag(logged$fdloge2r)
logged$fdloge2rL  <- logged$fdloge2rL  - lag(logged$fdloge2rL)
logged$fdloge2rLM <- logged$fdloge2rLM - lag(logged$fdloge2rLM)
logged$fdloge2rUM <- logged$fdloge2rUM - lag(logged$fdloge2rUM)
logged$fdloge2rH  <- logged$fdloge2rH  - lag(logged$fdloge2rH)
logged$fdlogi2e   <- logged$fdlogi2e   - lag(logged$fdlogi2e)
logged$fdlogi2eL  <- logged$fdlogi2eL  - lag(logged$fdlogi2eL)
logged$fdlogi2eLM <- logged$fdlogi2eLM - lag(logged$fdlogi2eLM)
logged$fdlogi2eUM <- logged$fdlogi2eUM - lag(logged$fdlogi2eUM)
logged$fdlogi2eH  <- logged$fdlogi2eH  - lag(logged$fdlogi2eH)


logged <- subset(logged, year!=1995)

# e2r plot
logged %>%
  ggvis(~year, ~fdloge2r, stroke='e2r') %>%
  layer_lines() %>%
  layer_lines(~year, ~fdloge2rL,  stroke='e2r (L)') %>%
  layer_lines(~year, ~fdloge2rLM, stroke='e2r (LM)') %>%
  layer_lines(~year, ~fdloge2rUM, stroke='e2r (UM)') %>%
  layer_lines(~year, ~fdloge2rH,  stroke='e2r (H)')

# i2e plot
logged %>%
  ggvis(~year, ~fdlogi2e, stroke='i2e') %>%
  layer_lines() %>%
  layer_lines(~year, ~fdlogi2eL,  stroke='i2e (L)') %>%
  layer_lines(~year, ~fdlogi2eLM, stroke='i2e (LM)') %>%
  layer_lines(~year, ~fdlogi2eUM, stroke='i2e (UM)') %>%
  layer_lines(~year, ~fdlogi2eH,  stroke='i2e (H)')


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

#### in paper
# i2e with divided
gvc_indicators %>%
  group_by(year) %>%
  summarise(i2e = sum(i2e) ) %>%
  mutate(divided = c(17.3, 20.5, 22.1, 23.2, 21.0, 22.4, 23.2)) %>%
  ggvis(x=~year) %>%
  layer_lines(y=~i2e) %>%
  add_axis('y', orient = 'left', title = 'i2e') %>%
  add_axis('y', 'ydiv' , orient = 'right',
           title= 'i2e as Percentage of exports (red)', grid=F, title_offset = 50,
           properties = axis_props(labels = list(fill = 'red')) ) %>%
  layer_lines( prop('y', ~divided, scale='ydiv'), stroke:='red' )

gvc_indicators %>%
  group_by(year) %>%
  summarise(total = sum(i2e) ) %>%
  mutate(share = c(17.3, 20.5, 22.1, 23.2, 21.0, 22.4, 23.2)) %>%
  melt(id.vars = 'year') %>%
  ggplot(aes(x=year, y=value)) %+%
  facet_grid(variable ~ ., scale='free') %+%
  geom_area(aes(fill=variable)) %+%
  scale_fill_brewer(palette='Set1')

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


# fdloge2r
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdloge2r = sum(fdloge2r, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdloge2r ) %>%
  layer_lines()

# fdloge2r class == L
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdloge2rL = sum(fdloge2rL, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdloge2rL ) %>%
  layer_lines()

# fdloge2r class == LM
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdloge2rLM = sum(fdloge2rLM, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdloge2rLM ) %>%
  layer_lines()

# fdloge2r class == UM
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdloge2rUM = sum(fdloge2rUM, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdloge2rUM ) %>%
  layer_lines()

# fdloge2r class == H
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdloge2rH = sum(fdloge2rH, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdloge2rH ) %>%
  layer_lines()

# fdlogi2e
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdlogi2e = sum(fdlogi2e, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdlogi2e ) %>%
  layer_lines()

# fdlogi2e class == L
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdlogi2eL = sum(fdlogi2eL, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdlogi2eL ) %>%
  layer_lines()

# fdlogi2e class == LM
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdlogi2eLM = sum(fdlogi2eLM, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdlogi2eLM ) %>%
  layer_lines()

# fdlogi2e class == UM
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdlogi2eUM = sum(fdlogi2eUM, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdlogi2eUM ) %>%
  layer_lines()

# fdlogi2e class == H
gvc_indicators %>%
  filter(year > 1995) %>%
  group_by(year) %>%
  summarise(fdlogi2eH = sum(fdlogi2eH, na.rm=TRUE) ) %>%
  ggvis(~year, ~fdlogi2eH ) %>%
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
