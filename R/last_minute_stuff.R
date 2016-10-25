# last_minute_stuff.R
# Bastiaan Quast
# bquast@gmail.com

library(readxl)
library(ggvis)
library(dplyr)

# load data
country_desc <- read_excel(path = 'data/country_stats.xlsx')
sector_desc  <- read_excel(path = 'data/sector_desc.xlsx')
wwz          <- read_excel(path = 'data/graphs.xlsx')
pdc          <- read_excel(path = 'data/graphs2.xlsx')

# i2e plot top 6
sector_desc %>%
  group_by(sector) %>%
  summarise(i2e=fvax_s/exp) %>%
  arrange(i2e) %>%
  filter(i2e > 0.30) %>%
  ggvis(x=~sector, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# i2e plot bottom 6
sector_desc %>%
  group_by(sector) %>%
  summarise(i2e=fvax_s/exp) %>%
  arrange(i2e) %>%
  filter(i2e < 0.13) %>%
  ggvis(x=~sector, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# i2e plot top 6 and bottom 6
sector_desc %>%
  group_by(sector) %>%
  summarise(i2e=fvax_s/exp) %>%
  arrange(i2e) %>%
  filter(i2e > 0.30 | i2e < 0.13) %>%
  ggvis(x=~sector, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot top 6
sector_desc %>%
  group_by(sector) %>%
  summarise(e2r=dvar_s/exp) %>%
  arrange(e2r) %>%
  filter(e2r > 0.3) %>%
  ggvis(x=~sector, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot bottom 6
sector_desc %>%
  group_by(sector) %>%
  summarise(e2r=dvar_s/exp) %>%
  arrange(e2r) %>%
  filter(e2r < 0.108) %>%
  ggvis(x=~sector, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot top 6 and bottom 6
sector_desc %>%
  group_by(sector) %>%
  summarise(e2r=dvar_s/exp) %>%
  arrange(e2r) %>%
  filter(e2r > 0.30 | e2r < 0.108) %>%
  ggvis(x=~sector, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)


# i2e plot top 6
country_desc %>%
  group_by(country) %>%
  summarise(i2e=fva_sha) %>%
  arrange(i2e) %>%
  filter(i2e > 0.419) %>%
  filter(country != 'irl') %>%
  ggvis(x=~country, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# i2e plot bottom 6
country_desc %>%
  group_by(country) %>%
  summarise(i2e=fva_sha) %>%
  arrange(i2e) %>%
  filter(i2e < 0.128) %>%
  ggvis(x=~country, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# i2e plot top 6 and bottom 6
country_desc %>%
  group_by(country) %>%
  summarise(i2e=fva_sha) %>%
  arrange(i2e) %>%
  filter(i2e > 0.419 | i2e < 0.128) %>%
  filter(country != 'irl') %>%
  ggvis(x=~country, y=~i2e) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot top 6
country_desc %>%
  group_by(country) %>%
  summarise(e2r=dva_sha) %>%
  arrange(e2r) %>%
  filter(e2r > 0.265) %>%
  ggvis(x=~country, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot bottom 6
country_desc %>%
  group_by(country) %>%
  summarise(e2r=dva_sha) %>%
  arrange(e2r) %>%
  filter(e2r < 0.14404) %>%
  ggvis(x=~country, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

# e2r plot top 6 and bottom 6
country_desc %>%
  group_by(country) %>%
  summarise(e2r=dva_sha) %>%
  arrange(e2r) %>%
  filter(e2r > 0.265 | e2r < 0.14404) %>%
  ggvis(x=~country, y=~e2r) %>%
  layer_bars() %>%
  scale_numeric("y", domain = c(0, 0.5), nice = FALSE)

wwz1 <- wwz[2:8,1:3]
names(wwz1) <- c('year', 'e2rL-LM', 'i2eL-LM')
wwz1$year <- as.numeric(wwz1$year)
wwz1$`e2rL-LM` <- as.numeric(wwz1$`e2rL-LM`)
wwz1$`i2eL-LM` <- as.numeric(wwz1$`i2eL-LM`)

wwz2 <- wwz[11:17,]
names(wwz2) <- wwz[10,]
names(wwz2)[1] <- 'year'
wwz2$year      <- as.numeric(wwz2$year)
wwz2$fva_fin   <- as.numeric(wwz2$fva_fin)
wwz2$fva_inter <- as.numeric(wwz2$fva_inter)
wwz2$dva_fin   <- as.numeric(wwz2$dva_fin)
wwz2$dva_inter <- as.numeric(wwz2$dva_inter)
wwz2$rdv       <- as.numeric(wwz2$rdv)

### in paper!! redo in ggplot2
wwz1 %>%
  ggvis(x=~year, y=~`e2rL-LM`, stroke='e2r') %>%
  layer_lines() %>%
  layer_lines(x=~year, y=~`i2eL-LM`, stroke='i2e') %>%
  add_axis('y', title = 'e2r / i2e')

library(ggplot2)
wwz1 %>%
  ggplot(aes(year)) %+%
  geom_line(aes(y = `e2rL-LM`, colour='e2r') ) %+%
  geom_line(aes(y = `i2eL-LM`, colour='i2e')) %+%
  labs(y = 'e2r / i2e') %+%
  scale_colour_brewer(palette='Set1')


### in paper! redo in ggplot2
wwz2 %>%
  ggvis(x=~year, y=~fva_fin, stroke='fva_fin') %>%
  layer_lines() %>%
  layer_lines(x=~year, y=~fva_inter, stroke='fva_inter') %>%
  layer_lines(x=~year, y=~dva_fin,   stroke='dva_fin')   %>%
  layer_lines(x=~year, y=~dva_inter, stroke='dva_inter') %>%
  add_axis('y', orient='left', title = 'WWZ decomposition indicators')  %>%
  add_axis('y', 'ydiv', orient = 'right',
           title= 'rdv', grid=F, title_offset = 50,
           properties = axis_props(labels = list(fill = 'purple')) ) %>%
  layer_lines( prop('y', ~rdv, scale='ydiv'), stroke='rdv' )


## replacement ggplot2 version using facet
wwz3 <- melt(wwz2[,-6], id.vars = 'year', variable.name = 'indicator')
wwz3$panel <- 'WWZ'
wwz4 <- data.frame(year = wwz2$year, indicator='rdv', value = wwz2$rdv, panel = 'RDV')
wwz5 <- rbind(wwz3, wwz4)
wwz5 %>%
  ggplot(mapping = aes(x = year, y = value)) %+%
  scale_colour_brewer(palette='Set1')  %+%
  facet_grid(panel ~ ., scale='free') %+%
  geom_line(data = wwz3, aes(colour=indicator)) %+%
  geom_line(data = wwz4, aes(colour=indicator))

### in paper!!! redo in ggplot2
pdc %>%
  ggvis(x=~year) %>%
  layer_lines(y=~pdc_t) %>%
  add_axis('y', orient = 'left', title = 'pdc_t') %>%
  add_axis('y', 'ydiv', orient = 'right',
           title= 'pdc_exp', grid=F, title_offset = 50,
           properties = axis_props(labels = list(fill = 'red')) ) %>%
  layer_lines( prop('y', ~pdc_exp, scale='ydiv'), stroke:='red' )


## pdc in ggplot2
pdc2 <- melt(pdc, id.vars = 'year', variable.name = 'PDC')
pdc2 %>%
  ggplot(aes(x=year, y=value)) %+%
  scale_fill_brewer(palette='Set1')  %+%
  facet_grid(PDC ~ ., scale='free') %+%
  geom_area(aes(fill=PDC))

# save everything
save.image(file = 'data/last_minute.RData')
