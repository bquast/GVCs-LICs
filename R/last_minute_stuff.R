# last_minute_stuff.R
# Bastiaan Quast
# bquast@gmail.com

library(readxl)
library(ggvis)
library(dplyr)

# load data
sector_desc <- read_excel(path = 'data/sector_desc.xlsx')

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
