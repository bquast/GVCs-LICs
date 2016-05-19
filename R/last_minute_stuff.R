# last_minute_stuff.R
# Bastiaan Quast
# bquast@gmail.com

library(readxl)
library(ggvis)
library(dplyr)

# load data
sector_desc <- read_excel(path = 'data/sector_desc.xlsx')
wwz         <- read_excel(path = 'data/graphs.xlsx')
pdc         <- read_excel(path = 'data/graphs2.xlsx')

# plot top 6
sector_desc %>%
  group_by(sector) %>%
  summarise(fvax=fvax_s/exp) %>%
  arrange(fvax) %>%
  filter(fvax > 0.30) %>%
  ggvis(x=~sector, y=~fvax) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# plot bottom 6
sector_desc %>%
  group_by(sector) %>%
  summarise(fvax=fvax_s/exp) %>%
  arrange(fvax) %>%
  filter(fvax < 0.13) %>%
  ggvis(x=~sector, y=~fvax) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

wwz1 <- wwz[2:8,1:3]
names(wwz1) <- c('year', 'e2rL-LM', 'i2eL-LM')
wwz1$year <- as.numeric(wwz1$year)
wwz1$`e2rL-LM` <- as.numeric(wwz1$`e2rL-LM`)
wwz1$`i2eL-LM` <- as.numeric(wwz1$`i2eL-LM`)
wwz1$`e2rL-LM` <- round(wwz1$`e2rL-LM`)

wwz2 <- wwz[11:17,]
names(wwz2) <- wwz[10,]
names(wwz2)[1] <- 'year'
wwz2$year      <- as.numeric(wwz2$year)
wwz2$fva_fin   <- as.numeric(wwz2$fva_fin)
wwz2$fva_inter <- as.numeric(wwz2$fva_inter)
wwz2$dva_fin   <- as.numeric(wwz2$dva_fin)
wwz2$dva_inter <- as.numeric(wwz2$dva_inter)
wwz2$rdv       <- as.numeric(wwz2$rdv)

wwz1 %>%
  ggvis(x=~year, y=~`e2rL-LM`, stroke='e2r') %>%
  layer_lines() %>%
  layer_lines(x=~year, y=~`i2eL-LM`, stroke='i2e')

wwz2 %>%
  ggvis(x=~year, y=~fva_fin, stroke='fva_fin') %>%
  layer_lines() %>%
  layer_lines(x=~year, y=~fva_inter, stroke='fva_inter') %>%
  layer_lines(x=~year, y=~dva_fin,   stroke='dva_fin')   %>%
  layer_lines(x=~year, y=~dva_inter, stroke='dva_inter')

pdc %>%
  ggvis(x=~year) %>%
  layer_lines(y=~pdc_t) %>%
  add_axis('y', orient = 'left', title = 'pdc_t') %>%
  add_axis('y', 'ydiv' , orient = 'right',
           title= 'i2e as Percentage of exports (red)', grid=F, title_offset = 50,
           properties = axis_props(labels = list(fill = 'red')) ) %>%
  layer_lines( prop('y', ~pdc_exp, scale='ydiv'), stroke:='red' )
