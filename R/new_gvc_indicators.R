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
load(file = 'data/country_chars.RData')

country_chars$iso3 <- tolower(country_chars$iso3)


# merge with country_chars
l1995m <-  merge(l1995, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2000m <-  merge(l2000, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2005m <-  merge(l2005, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2008m <-  merge(l2008, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2009m <-  merge(l2009, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2010m <-  merge(l2010, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)
l2011m <-  merge(l2011, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE)


# fix names post merge
names(l1995m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2000m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2005m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2008m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2009m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2010m)[6:8] <- c('GDPpc', 'class', 'region')
names(l2011m)[6:8] <- c('GDPpc', 'class', 'region')


# add attributes to merged objectes post merge
attributes(l1995m) <- attributes(l1995)
attributes(l2000m) <- attributes(l2000)
attributes(l2005m) <- attributes(l2005)
attributes(l2008m) <- attributes(l2008)
attributes(l2009m) <- attributes(l2009)
attributes(l2010m) <- attributes(l2010)
attributes(l2011m) <- attributes(l2011)


# save merged
save(l1995m, l2000m, l2005m, l2008m, l2009m, l2010m, l2011m, file = 'data/Tiva-Leontief-merged.RData')


# perform e2r
e2r1995 <- e2r(l1995m)
e2r2000 <- e2r(l2000m)
e2r2005 <- e2r(l2005m)
e2r2008 <- e2r(l2008m)
e2r2009 <- e2r(l2009m)
e2r2010 <- e2r(l2010m)
e2r2011 <- e2r(l2011m)


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


# perform e2r with L only
e2rL1995 <- e2r(l1995m, by = 'class', subset = 'L')
e2rL2000 <- e2r(l2000m, by = 'class', subset = 'L')
e2rL2005 <- e2r(l2005m, by = 'class', subset = 'L')
e2rL2008 <- e2r(l2008m, by = 'class', subset = 'L')
e2rL2009 <- e2r(l2009m, by = 'class', subset = 'L')
e2rL2010 <- e2r(l2010m, by = 'class', subset = 'L')
e2rL2011 <- e2r(l2011m, by = 'class', subset = 'L')

## add year
e2rL1995 %<>% cbind(year = '1995')
e2rL2000 %<>% cbind(year = '2000')
e2rL2005 %<>% cbind(year = '2005')
e2rL2008 %<>% cbind(year = '2008')
e2rL2009 %<>% cbind(year = '2009')
e2rL2010 %<>% cbind(year = '2010')
e2rL2011 %<>% cbind(year = '2011')

## bind together across years
e2rL1995_2011 <- rbind(e2rL1995, e2rL2000, e2rL2005, e2rL2008, e2rL2009, e2rL2010, e2rL2011)


# save e2r using class == L
save(e2rL1995_2011, file = 'data/e2rL1995_2011.RData')


# perform e2r with LM only
e2rLM1995 <- e2r(l1995m, by = 'class', subset = 'LM')
e2rLM2000 <- e2r(l2000m, by = 'class', subset = 'LM')
e2rLM2005 <- e2r(l2005m, by = 'class', subset = 'LM')
e2rLM2008 <- e2r(l2008m, by = 'class', subset = 'LM')
e2rLM2009 <- e2r(l2009m, by = 'class', subset = 'LM')
e2rLM2010 <- e2r(l2010m, by = 'class', subset = 'LM')
e2rLM2011 <- e2r(l2011m, by = 'class', subset = 'LM')


## add year
e2rLM1995 %<>% cbind(year = '1995')
e2rLM2000 %<>% cbind(year = '2000')
e2rLM2005 %<>% cbind(year = '2005')
e2rLM2008 %<>% cbind(year = '2008')
e2rLM2009 %<>% cbind(year = '2009')
e2rLM2010 %<>% cbind(year = '2010')
e2rLM2011 %<>% cbind(year = '2011')


## bind together across years
e2rLM1995_2011 <- rbind(e2rLM1995, e2rLM2000, e2rLM2005, e2rLM2008, e2rLM2009, e2rLM2010, e2rLM2011)


# save e2r using class == LM
save(e2rLM1995_2011, file = 'data/e2rLM1995_2011.RData')


# perform e2r with UM only
e2rUM1995 <- e2r(l1995m, by = 'class', subset = 'UM')
e2rUM2000 <- e2r(l2000m, by = 'class', subset = 'UM')
e2rUM2005 <- e2r(l2005m, by = 'class', subset = 'UM')
e2rUM2008 <- e2r(l2008m, by = 'class', subset = 'UM')
e2rUM2009 <- e2r(l2009m, by = 'class', subset = 'UM')
e2rUM2010 <- e2r(l2010m, by = 'class', subset = 'UM')
e2rUM2011 <- e2r(l2011m, by = 'class', subset = 'UM')


## add year
e2rUM1995 %<>% cbind(year = '1995')
e2rUM2000 %<>% cbind(year = '2000')
e2rUM2005 %<>% cbind(year = '2005')
e2rUM2008 %<>% cbind(year = '2008')
e2rUM2009 %<>% cbind(year = '2009')
e2rUM2010 %<>% cbind(year = '2010')
e2rUM2011 %<>% cbind(year = '2011')


## bind together across years
e2rUM1995_2011 <- rbind(e2rUM1995, e2rUM2000, e2rUM2005, e2rUM2008, e2rUM2009, e2rUM2010, e2rUM2011)


# save e2r using class == UM
save(e2rUM1995_2011, file = 'data/e2rUM1995_2011.RData')


# perform e2r with H only
e2rH1995 <- e2r(l1995m, by = 'class', subset = 'H')
e2rH2000 <- e2r(l2000m, by = 'class', subset = 'H')
e2rH2005 <- e2r(l2005m, by = 'class', subset = 'H')
e2rH2008 <- e2r(l2008m, by = 'class', subset = 'H')
e2rH2009 <- e2r(l2009m, by = 'class', subset = 'H')
e2rH2010 <- e2r(l2010m, by = 'class', subset = 'H')
e2rH2011 <- e2r(l2011m, by = 'class', subset = 'H')


## add year
e2rH1995 %<>% cbind(year = '1995')
e2rH2000 %<>% cbind(year = '2000')
e2rH2005 %<>% cbind(year = '2005')
e2rH2008 %<>% cbind(year = '2008')
e2rH2009 %<>% cbind(year = '2009')
e2rH2010 %<>% cbind(year = '2010')
e2rH2011 %<>% cbind(year = '2011')


## bind together across years
e2rH1995_2011 <- rbind(e2rH1995, e2rH2000, e2rH2005, e2rH2008, e2rH2009, e2rH2010, e2rH2011)


# save e2r using class == H
save(e2rH1995_2011, file = 'data/e2rH1995_2011.RData')


# perform i2e
i2e1995 <- i2e(l1995m)
i2e2000 <- i2e(l2000m)
i2e2005 <- i2e(l2005m)
i2e2008 <- i2e(l2008m)
i2e2009 <- i2e(l2009m)
i2e2010 <- i2e(l2010m)
i2e2011 <- i2e(l2011m)


# merge i2e

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


# perform i2e with L only
i2eL1995 <- i2e(l1995m, by = 'class', subset = 'L')
i2eL2000 <- i2e(l2000m, by = 'class', subset = 'L')
i2eL2005 <- i2e(l2005m, by = 'class', subset = 'L')
i2eL2008 <- i2e(l2008m, by = 'class', subset = 'L')
i2eL2009 <- i2e(l2009m, by = 'class', subset = 'L')
i2eL2010 <- i2e(l2010m, by = 'class', subset = 'L')
i2eL2011 <- i2e(l2011m, by = 'class', subset = 'L')

## add year
i2eL1995 %<>% cbind(year = '1995')
i2eL2000 %<>% cbind(year = '2000')
i2eL2005 %<>% cbind(year = '2005')
i2eL2008 %<>% cbind(year = '2008')
i2eL2009 %<>% cbind(year = '2009')
i2eL2010 %<>% cbind(year = '2010')
i2eL2011 %<>% cbind(year = '2011')

## bind together across years
i2eL1995_2011 <- rbind(i2eL1995, i2eL2000, i2eL2005, i2eL2008, i2eL2009, i2eL2010, i2eL2011)


# save i2e using class == L
save(i2eL1995_2011, file = 'data/i2eL1995_2011.RData')


# perform i2e with LM only
i2eLM1995 <- i2e(l1995m, by = 'class', subset = 'LM')
i2eLM2000 <- i2e(l2000m, by = 'class', subset = 'LM')
i2eLM2005 <- i2e(l2005m, by = 'class', subset = 'LM')
i2eLM2008 <- i2e(l2008m, by = 'class', subset = 'LM')
i2eLM2009 <- i2e(l2009m, by = 'class', subset = 'LM')
i2eLM2010 <- i2e(l2010m, by = 'class', subset = 'LM')
i2eLM2011 <- i2e(l2011m, by = 'class', subset = 'LM')


## add year
i2eLM1995 %<>% cbind(year = '1995')
i2eLM2000 %<>% cbind(year = '2000')
i2eLM2005 %<>% cbind(year = '2005')
i2eLM2008 %<>% cbind(year = '2008')
i2eLM2009 %<>% cbind(year = '2009')
i2eLM2010 %<>% cbind(year = '2010')
i2eLM2011 %<>% cbind(year = '2011')


## bind together across years
i2eLM1995_2011 <- rbind(i2eLM1995, i2eLM2000, i2eLM2005, i2eLM2008, i2eLM2009, i2eLM2010, i2eLM2011)


# save i2e using class == LM
save(i2eLM1995_2011, file = 'data/i2eLM1995_2011.RData')


# perform i2e with UM only
i2eUM1995 <- i2e(l1995m, by = 'class', subset = 'UM')
i2eUM2000 <- i2e(l2000m, by = 'class', subset = 'UM')
i2eUM2005 <- i2e(l2005m, by = 'class', subset = 'UM')
i2eUM2008 <- i2e(l2008m, by = 'class', subset = 'UM')
i2eUM2009 <- i2e(l2009m, by = 'class', subset = 'UM')
i2eUM2010 <- i2e(l2010m, by = 'class', subset = 'UM')
i2eUM2011 <- i2e(l2011m, by = 'class', subset = 'UM')


## add year
i2eUM1995 %<>% cbind(year = '1995')
i2eUM2000 %<>% cbind(year = '2000')
i2eUM2005 %<>% cbind(year = '2005')
i2eUM2008 %<>% cbind(year = '2008')
i2eUM2009 %<>% cbind(year = '2009')
i2eUM2010 %<>% cbind(year = '2010')
i2eUM2011 %<>% cbind(year = '2011')


## bind together across years
i2eUM1995_2011 <- rbind(i2eUM1995, i2eUM2000, i2eUM2005, i2eUM2008, i2eUM2009, i2eUM2010, i2eUM2011)


# save i2e using class == UM
save(i2eUM1995_2011, file = 'data/i2eUM1995_2011.RData')


# perform i2e with H only
i2eH1995 <- i2e(l1995m, by = 'class', subset = 'H')
i2eH2000 <- i2e(l2000m, by = 'class', subset = 'H')
i2eH2005 <- i2e(l2005m, by = 'class', subset = 'H')
i2eH2008 <- i2e(l2008m, by = 'class', subset = 'H')
i2eH2009 <- i2e(l2009m, by = 'class', subset = 'H')
i2eH2010 <- i2e(l2010m, by = 'class', subset = 'H')
i2eH2011 <- i2e(l2011m, by = 'class', subset = 'H')


## add year
i2eH1995 %<>% cbind(year = '1995')
i2eH2000 %<>% cbind(year = '2000')
i2eH2005 %<>% cbind(year = '2005')
i2eH2008 %<>% cbind(year = '2008')
i2eH2009 %<>% cbind(year = '2009')
i2eH2010 %<>% cbind(year = '2010')
i2eH2011 %<>% cbind(year = '2011')


## bind together across years
i2eH1995_2011 <- rbind(i2eH1995, i2eH2000, i2eH2005, i2eH2008, i2eH2009, i2eH2010, i2eH2011)


# save i2e using class == H
save(i2eH1995_2011, file = 'data/i2eH1995_2011.RData')



# merge everything
gvc_indicators <- cbind(e2r1995_2011[4],
                        e2r1995_2011[1:2],
                        e2r   = e2r1995_2011$e2r,
                        e2rL  = e2rL1995_2011$e2r,
                        e2rLM = e2rLM1995_2011$e2r,
                        e2rUM = e2rUM1995_2011$e2r,
                        e2rH  = e2rH1995_2011$e2r,
                        i2e   = i2e1995_2011$i2e,
                        i2eL  = i2eL1995_2011$i2e,
                        i2eLM = i2eLM1995_2011$i2e,
                        i2eUM = i2eUM1995_2011$i2e,
                        i2eH  = i2eH1995_2011$i2e)

# save merged
save(gvc_indicators, file = 'data/new_gvc_indicators.RData')
