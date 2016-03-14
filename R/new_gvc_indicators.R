# new_gvc_indicators.R
#
# redo using the i2e en e2r functions
#
# Bastiaan Quast
# bquast@gmail.com


# load libraries
library(gvc)
library(magrittr)


# load data
load(file = 'data/TiVa-Leontief.RData')


# perform e2r
e2r1995 <- e2r(l1995)
e2r2000 <- e2r(l2000)
e2r2005 <- e2r(l2005)
e2r2008 <- e2r(l2008)
e2r2009 <- e2r(l2009)
e2r2010 <- e2r(l2010)
e2r2011 <- e2r(l2011)


# merge e2r

## add year
e2r1995 %<>% cbind(year = '1995')
e2r2000 %<>% cbind(year = '2000')
e2r2005 %<>% cbind(year = '2005')
e2r2008 %<>% cbind(year = '2008')
e2r2009 %<>% cbind(year = '2009')
e2r2010 %<>% cbind(year = '2010')
e2r2011 %<>% cbind(year = '2011')

## bind together across years
e2r1995_2011 <- rbind(e2r1995, e2r2000, e2r2005, e2r2008, e2r2009, e2r2010, e2r2011)


# save e2r
save(e2r1995_2011, file = 'data/e2r1995_2011.RData')


# perform i2e
i2e1995 <- i2e(l1995)
i2e2000 <- i2e(l2000)
i2e2005 <- i2e(l2005)
i2e2008 <- i2e(l2008)
i2e2009 <- i2e(l2009)
i2e2010 <- i2e(l2010)
i2e2011 <- i2e(l2011)


# merge

## add year
i2e1995 %<>% cbind(year = '1995')
i2e2000 %<>% cbind(year = '2000')
i2e2005 %<>% cbind(year = '2005')
i2e2008 %<>% cbind(year = '2008')
i2e2009 %<>% cbind(year = '2009')
i2e2010 %<>% cbind(year = '2010')
i2e2011 %<>% cbind(year = '2011')

## bind together across years
i2e1995_2011 <- rbind(i2e1995, i2e2000, i2e2005, i2e2008, i2e2009, i2e2010, i2e2011)


# save i2e
save(i2e1995_2011, file = 'data/i2e1995_2011.RData')


# merge everything
gvc_indicators <- cbind(e2r1995_2011, i2e = i2e1995_2011$i2e)


# save merged
save(gvc_indicators, file = 'data/new_gvc_indicators.RData')
