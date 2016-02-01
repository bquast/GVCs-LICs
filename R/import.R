# import.R
# ---------------------------
# import data from csv files
#
# Bastiaan Quast
# bquast@gmail.com


# unzip
unzip(zipfile = 'data/tiva.zip', exdir = 'data')


# load data
countries  <- read.csv(file = 'data/countries1995.csv',  header = FALSE, sep = '', stringsAsFactors = FALSE)
industries <- read.csv(file = 'data/industries1995.csv', header = FALSE, sep = '', stringsAsFactors = FALSE)
inter1995  <- read.csv(file = 'data/inter1995.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2000  <- read.csv(file = 'data/inter2000.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2005  <- read.csv(file = 'data/inter2005.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2008  <- read.csv(file = 'data/inter2008.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2009  <- read.csv(file = 'data/inter2009.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2010  <- read.csv(file = 'data/inter2010.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
inter2011  <- read.csv(file = 'data/inter2011.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final1995  <- read.csv(file = 'data/final1995.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2000  <- read.csv(file = 'data/final2000.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2005  <- read.csv(file = 'data/final2005.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2008  <- read.csv(file = 'data/final2008.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2009  <- read.csv(file = 'data/final2009.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2010  <- read.csv(file = 'data/final2010.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
final2011  <- read.csv(file = 'data/final2011.csv',      header = FALSE, sep = '', stringsAsFactors = FALSE)
output1995 <- read.csv(file = 'data/output1995.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2000 <- read.csv(file = 'data/output2000.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2005 <- read.csv(file = 'data/output2005.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2008 <- read.csv(file = 'data/output2008.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2009 <- read.csv(file = 'data/output2009.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2010 <- read.csv(file = 'data/output2010.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)
output2011 <- read.csv(file = 'data/output2011.csv',     header = FALSE, sep = '', stringsAsFactors = FALSE)


# convert to matrices and vectors

## countries and industries
countries  <- as.vector(countries[,1])
industries <- as.vector(industries[,1])

## intermediate demand
inter1995 <- as.matrix(inter1995)
inter2000 <- as.matrix(inter2000)
inter2005 <- as.matrix(inter2005)
inter2008 <- as.matrix(inter2008)
inter2009 <- as.matrix(inter2009)
inter2010 <- as.matrix(inter2010)
inter2011 <- as.matrix(inter2011)

## final demand
final1995 <- as.matrix(final1995)
final2000 <- as.matrix(final2000)
final2005 <- as.matrix(final2005)
final2008 <- as.matrix(final2008)
final2009 <- as.matrix(final2009)
final2010 <- as.matrix(final2010)
final2011 <- as.matrix(final2011)

## output
output1995 <- as.vector(output1995[,1])
output2000 <- as.vector(output2000[,1])
output2005 <- as.vector(output2005[,1])
output2008 <- as.vector(output2008[,1])
output2009 <- as.vector(output2009[,1])
output2010 <- as.vector(output2010[,1])
output2011 <- as.vector(output2011[,1])


# save imported data
save.image(file = 'data/imported.RData')


# extra variables
extra <- read.csv(file = 'data/Extra_vars.csv')

## save extra variables
save(extra, file = 'data/extra_vars.RData')


#
# # load the readxl library
# # for excell files (.xls / .xlsx )
# library(readxl)
#
# # read the final demand sheets
# wfd1995 <- read_excel("data/WFD1.xlsx", sheet = 1, col_names = FALSE, skip = 2)
# wfd2000 <- read_excel("data/WFD1.xlsx", sheet = 2, col_names = FALSE, skip = 2)
# wfd2005 <- read_excel("data/WFD1.xlsx", sheet = 3, col_names = FALSE, skip = 2)
# wfd2008 <- read_excel("data/WFD1.xlsx", sheet = 4, col_names = FALSE, skip = 2)
#
# # separate out country and sector names
# countries <- wfd1995[ , 1]
# sectors   <- wfd1995[ , 2]
#
# # filter out doubles
# countries <- unique(countries)
# sectors   <- unique(sectors)
#
# # verify created objects
# print(countries)
# print(sectors)
#
# # remove invalid parts by subsetting only valid parts
# countries <- countries[1:58]
# sectors   <- sectors[1:34]
#
# # verify again
# print(countries)
# print(sectors)
#
# # create objects for number of countries and number of sectors
# # and multiple of the two
# G  <- length(countries)
# N  <- length(sectors)
# GN <- G * N
#
# # remove all data excel final demand statistics
# wfd1995 <- wfd1995[ 1:GN, -c(1:2) ]
# wfd2000 <- wfd2000[ 1:GN, -c(1:2) ]
# wfd2005 <- wfd2005[ 1:GN, -c(1:2) ]
# wfd2008 <- wfd2008[ 1:GN, -c(1:2) ]
#
# # save output separately
# output1995 <- wfd1995[ , length(wfd1995) ]
# output2000 <- wfd2000[ , length(wfd2000) ]
# output2005 <- wfd2005[ , length(wfd2005) ]
# output2008 <- wfd2008[ , length(wfd2008) ]
#
# # remove last column
# wfd1995 <- wfd1995[ , -length(wfd1995) ]
# wfd2000 <- wfd2000[ , -length(wfd2000) ]
# wfd2005 <- wfd2005[ , -length(wfd2005) ]
# wfd2008 <- wfd2008[ , -length(wfd2008) ]
#
# # read the ICIOs
# wid1995 <- read.table("data/Wicio34_1995_test.csv",
#                       sep=";",
#                       quote="\"",
#                       stringsAsFactors=FALSE,
#                       skip = 2 )
# wid2000 <- read.table("data/Wicio34_2000_test.csv",
#                       sep=";",
#                       quote="\"",
#                       stringsAsFactors=FALSE,
#                       skip = 2 )
# wid2005 <- read.table("data/Wicio34_2005_test.csv",
#                       sep=";",
#                       quote="\"",
#                       stringsAsFactors=FALSE,
#                       skip = 2 )
# wid2008 <- read.table("data/Wicio34_2008_test.csv",
#                       sep=";",
#                       quote="\"",
#                       stringsAsFactors=FALSE,
#                       skip = 2 )
#
# # find output MLT C23
# mltc23 <- wid1995[1982,1879]
#
# # remove first two rows with countries and sectors
# # and extra information at the bottom
# wid1995 <- wid1995[ 1:GN , -c(1:2) ]
# wid2000 <- wid2000[ 1:GN , -c(1:2) ]
# wid2005 <- wid2005[ 1:GN , -c(1:2) ]
# wid2008 <- wid2008[ 1:GN , -c(1:2) ]
#
# # impute missing value
# output1995[1877] <- mltc23
# rm(mltc23)
#
# # as.matrices
# wid1995 <- as.matrix(wid1995)
# wid2000 <- as.matrix(wid2000)
# wid2005 <- as.matrix(wid2005)
# wid2008 <- as.matrix(wid2008)
# wfd1995 <- as.matrix(wfd1995)
# wfd2000 <- as.matrix(wfd2000)
# wfd2005 <- as.matrix(wfd2005)
# wfd2008 <- as.matrix(wfd2008)
#
# # remove excess objects
# rm(G)
# rm(N)
# rm(GN)
#
# # save the workspace
# save.image(file = "data/TiVa.RData" )
#
# # import the trca
# trca <- read.csv("data/trca.csv")
#
# # save the trca
# save(trca, file = "data/trca.RData")
#
# # import the gvc indicators
# gvc_indicators <- read.csv("data/gvc_indicators.csv")
#
# # save the gvc indicators
# save(gvc_indicators, file = "data/gvc_indicators.RData")
