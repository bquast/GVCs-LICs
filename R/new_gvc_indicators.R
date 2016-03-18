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



# merge with country_chars and Using_Country

## merge
l1995U <-  merge(l1995, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2000U <-  merge(l2000, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2005U <-  merge(l2005, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2008U <-  merge(l2008, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2009U <-  merge(l2009, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2010U <-  merge(l2010, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2011U <-  merge(l2011, country_chars, by.x = 'Using_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)

## sort
l1995U <-l1995S[order(l1995U$Source_Country, l1995U$Source_Industry, l1995U$Using_Country, l1995U$Using_Industry),]
l2000U <-l2000S[order(l2000U$Source_Country, l2000U$Source_Industry, l2000U$Using_Country, l2000U$Using_Industry),]
l2005U <-l2005S[order(l2005U$Source_Country, l2005U$Source_Industry, l2005U$Using_Country, l2005U$Using_Industry),]
l2008U <-l2008S[order(l2008U$Source_Country, l2008U$Source_Industry, l2008U$Using_Country, l2008U$Using_Industry),]
l2009U <-l2009S[order(l2009U$Source_Country, l2009U$Source_Industry, l2009U$Using_Country, l2009U$Using_Industry),]
l2010U <-l2010S[order(l2010U$Source_Country, l2010U$Source_Industry, l2010U$Using_Country, l2010U$Using_Industry),]
l2011U <-l2011S[order(l2011U$Source_Country, l2011U$Source_Industry, l2011U$Using_Country, l2011U$Using_Industry),]

## fix names post merge
names(l1995U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2000U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2005U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2008U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2009U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2010U)[6:8] <- c('GDPpc', 'class', 'region')
names(l2011U)[6:8] <- c('GDPpc', 'class', 'region')

## add attributes to merged objectes post merge
attributes(l1995U) <- attributes(l1995)
attributes(l2000U) <- attributes(l2000)
attributes(l2005U) <- attributes(l2005)
attributes(l2008U) <- attributes(l2008)
attributes(l2009U) <- attributes(l2009)
attributes(l2010U) <- attributes(l2010)
attributes(l2011U) <- attributes(l2011)

## save
save(l1995U, l2000U, l2005U, l2008U, l2009U, l2010U, l2011U, file = 'data/Tiva-Leontief-merged-Using.RData')


# merge with country_chars and Source_Country

## merge
l1995S <-  merge(l1995, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2000S <-  merge(l2000, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2005S <-  merge(l2005, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2008S <-  merge(l2008, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2009S <-  merge(l2009, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2010S <-  merge(l2010, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)
l2011S <-  merge(l2011, country_chars, by.x = 'Source_Country', by.y = 'iso3', all.x = TRUE, sort=FALSE)

## sort
l1995S <- l1995S[order(l1995S$Source_Country, l1995S$Source_Industry, l1995S$Using_Country, l1995S$Using_Industry),]
l2000S <- l2000S[order(l2000S$Source_Country, l2000S$Source_Industry, l2000S$Using_Country, l2000S$Using_Industry),]
l2005S <- l2005S[order(l2005S$Source_Country, l2005S$Source_Industry, l2005S$Using_Country, l2005S$Using_Industry),]
l2008S <- l2008S[order(l2008S$Source_Country, l2008S$Source_Industry, l2008S$Using_Country, l2008S$Using_Industry),]
l2009S <- l2009S[order(l2009S$Source_Country, l2009S$Source_Industry, l2009S$Using_Country, l2009S$Using_Industry),]
l2010S <- l2010S[order(l2010S$Source_Country, l2010S$Source_Industry, l2010S$Using_Country, l2010S$Using_Industry),]
l2011S <- l2011S[order(l2011S$Source_Country, l2011S$Source_Industry, l2011S$Using_Country, l2011S$Using_Industry),]

## fix names post merge
names(l1995S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2000S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2005S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2008S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2009S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2010S)[6:8] <- c('GDPpc', 'class', 'region')
names(l2011S)[6:8] <- c('GDPpc', 'class', 'region')

## add attributes to merged objectes post merge
attributes(l1995S) <- attributes(l1995)
attributes(l2000S) <- attributes(l2000)
attributes(l2005S) <- attributes(l2005)
attributes(l2008S) <- attributes(l2008)
attributes(l2009S) <- attributes(l2009)
attributes(l2010S) <- attributes(l2010)
attributes(l2011S) <- attributes(l2011)


# save merged
save(l1995S, l2000S, l2005S, l2008S, l2009S, l2010S, l2011S, file = 'data/Tiva-Leontief-merged-Source.RData')


# perform e2r
e2r1995 <- e2r(l1995U)
e2r2000 <- e2r(l2000U)
e2r2005 <- e2r(l2005U)
e2r2008 <- e2r(l2008U)
e2r2009 <- e2r(l2009U)
e2r2010 <- e2r(l2010U)
e2r2011 <- e2r(l2011U)

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

## save e2r
save(e2r1995_2011, file = 'data/e2r1995_2011.RData')


# perform e2r with L only
e2rL1995 <- e2r(l1995U, by = 'class', subset = 'L')
e2rL2000 <- e2r(l2000U, by = 'class', subset = 'L')
e2rL2005 <- e2r(l2005U, by = 'class', subset = 'L')
e2rL2008 <- e2r(l2008U, by = 'class', subset = 'L')
e2rL2009 <- e2r(l2009U, by = 'class', subset = 'L')
e2rL2010 <- e2r(l2010U, by = 'class', subset = 'L')
e2rL2011 <- e2r(l2011U, by = 'class', subset = 'L')

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

## save e2r using class == L
save(e2rL1995_2011, file = 'data/e2rL1995_2011.RData')


# perform e2r with LM only
e2rLM1995 <- e2r(l1995U, by = 'class', subset = 'LM')
e2rLM2000 <- e2r(l2000U, by = 'class', subset = 'LM')
e2rLM2005 <- e2r(l2005U, by = 'class', subset = 'LM')
e2rLM2008 <- e2r(l2008U, by = 'class', subset = 'LM')
e2rLM2009 <- e2r(l2009U, by = 'class', subset = 'LM')
e2rLM2010 <- e2r(l2010U, by = 'class', subset = 'LM')
e2rLM2011 <- e2r(l2011U, by = 'class', subset = 'LM')

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

## save e2r using class == LM
save(e2rLM1995_2011, file = 'data/e2rLM1995_2011.RData')


# perform e2r with UM only
e2rUM1995 <- e2r(l1995U, by = 'class', subset = 'UM')
e2rUM2000 <- e2r(l2000U, by = 'class', subset = 'UM')
e2rUM2005 <- e2r(l2005U, by = 'class', subset = 'UM')
e2rUM2008 <- e2r(l2008U, by = 'class', subset = 'UM')
e2rUM2009 <- e2r(l2009U, by = 'class', subset = 'UM')
e2rUM2010 <- e2r(l2010U, by = 'class', subset = 'UM')
e2rUM2011 <- e2r(l2011U, by = 'class', subset = 'UM')

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

## save e2r using class == UM
save(e2rUM1995_2011, file = 'data/e2rUM1995_2011.RData')


# perform e2r with H only
e2rH1995 <- e2r(l1995U, by = 'class', subset = 'H')
e2rH2000 <- e2r(l2000U, by = 'class', subset = 'H')
e2rH2005 <- e2r(l2005U, by = 'class', subset = 'H')
e2rH2008 <- e2r(l2008U, by = 'class', subset = 'H')
e2rH2009 <- e2r(l2009U, by = 'class', subset = 'H')
e2rH2010 <- e2r(l2010U, by = 'class', subset = 'H')
e2rH2011 <- e2r(l2011U, by = 'class', subset = 'H')

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

## save e2r using class == H
save(e2rH1995_2011, file = 'data/e2rH1995_2011.RData')


# perform i2e
i2e1995 <- i2e(l1995S)
i2e2000 <- i2e(l2000S)
i2e2005 <- i2e(l2005S)
i2e2008 <- i2e(l2008S)
i2e2009 <- i2e(l2009S)
i2e2010 <- i2e(l2010S)
i2e2011 <- i2e(l2011S)


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
i2eL1995 <- i2e(l1995S, by = 'class', subset = 'L')
i2eL2000 <- i2e(l2000S, by = 'class', subset = 'L')
i2eL2005 <- i2e(l2005S, by = 'class', subset = 'L')
i2eL2008 <- i2e(l2008S, by = 'class', subset = 'L')
i2eL2009 <- i2e(l2009S, by = 'class', subset = 'L')
i2eL2010 <- i2e(l2010S, by = 'class', subset = 'L')
i2eL2011 <- i2e(l2011S, by = 'class', subset = 'L')

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


## save i2e using class == L
save(i2eL1995_2011, file = 'data/i2eL1995_2011.RData')


# perform i2e with LM only
i2eLM1995 <- i2e(l1995S, by = 'class', subset = 'LM')
i2eLM2000 <- i2e(l2000S, by = 'class', subset = 'LM')
i2eLM2005 <- i2e(l2005S, by = 'class', subset = 'LM')
i2eLM2008 <- i2e(l2008S, by = 'class', subset = 'LM')
i2eLM2009 <- i2e(l2009S, by = 'class', subset = 'LM')
i2eLM2010 <- i2e(l2010S, by = 'class', subset = 'LM')
i2eLM2011 <- i2e(l2011S, by = 'class', subset = 'LM')

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

## save i2e using class == LM
save(i2eLM1995_2011, file = 'data/i2eLM1995_2011.RData')


# perform i2e with UM only
i2eUM1995 <- i2e(l1995S, by = 'class', subset = 'UM')
i2eUM2000 <- i2e(l2000S, by = 'class', subset = 'UM')
i2eUM2005 <- i2e(l2005S, by = 'class', subset = 'UM')
i2eUM2008 <- i2e(l2008S, by = 'class', subset = 'UM')
i2eUM2009 <- i2e(l2009S, by = 'class', subset = 'UM')
i2eUM2010 <- i2e(l2010S, by = 'class', subset = 'UM')
i2eUM2011 <- i2e(l2011S, by = 'class', subset = 'UM')

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

## save i2e using class == UM
save(i2eUM1995_2011, file = 'data/i2eUM1995_2011.RData')


# perform i2e with H only
i2eH1995 <- i2e(l1995S, by = 'class', subset = 'H')
i2eH2000 <- i2e(l2000S, by = 'class', subset = 'H')
i2eH2005 <- i2e(l2005S, by = 'class', subset = 'H')
i2eH2008 <- i2e(l2008S, by = 'class', subset = 'H')
i2eH2009 <- i2e(l2009S, by = 'class', subset = 'H')
i2eH2010 <- i2e(l2010S, by = 'class', subset = 'H')
i2eH2011 <- i2e(l2011S, by = 'class', subset = 'H')

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

## save i2e using class == H
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
