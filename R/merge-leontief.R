# merge.R
# Bastiaan Quast
# bquast@gmail.com

# load the data sets
load("data/nrca.RData")
load("data/trca.RData")
load("data/gvc_indicators.RData")

# extract names
names_nrca1995 <- names(nrca1995)
names_nrca2000 <- names(nrca2000)
names_nrca2005 <- names(nrca2005)
names_nrca2008 <- names(nrca2008)

# change to lower case
names_nrca1995 <- tolower(names_nrca1995)
names_nrca2000 <- tolower(names_nrca2000)
names_nrca2005 <- tolower(names_nrca2005)
names_nrca2008 <- tolower(names_nrca2008)

# substitute the problematic c30.32
names_nrca1995 <- gsub("c30.32.33", "c303233" , names_nrca1995)
names_nrca2000 <- gsub("c30.32.33", "c303233" , names_nrca2000)
names_nrca2005 <- gsub("c30.32.33", "c303233" , names_nrca2005)
names_nrca2008 <- gsub("c30.32.33", "c303233" , names_nrca2008)

# split by period
countries_industries1995 <- read.table(text = names_nrca1995, sep = ".", colClasses = "character")
countries_industries2000 <- read.table(text = names_nrca2000, sep = ".", colClasses = "character")
countries_industries2005 <- read.table(text = names_nrca2005, sep = ".", colClasses = "character")
countries_industries2008 <- read.table(text = names_nrca2008, sep = ".", colClasses = "character")

# extract the last three characters from V2
countries_industries1995[,3] <- regmatches(countries_industries1995[,2],regexpr("...$", countries_industries1995[,2]))
temp <- unlist(regmatches(countries_industries1995[,2],regexpr("...$", countries_industries1995[,2]), invert = TRUE))
countries_industries1995[,2] <- temp[temp != ""]
countries_industries2000[,3] <- regmatches(countries_industries2000[,2],regexpr("...$", countries_industries2000[,2]))
temp <- unlist(regmatches(countries_industries2000[,2],regexpr("...$", countries_industries2000[,2]), invert = TRUE))
countries_industries2000[,2] <- temp[temp != ""]
countries_industries2005[,3] <- regmatches(countries_industries2005[,2],regexpr("...$", countries_industries2005[,2]))
temp <- unlist(regmatches(countries_industries2005[,2],regexpr("...$", countries_industries2005[,2]), invert = TRUE))
countries_industries2005[,2] <- temp[temp != ""]
countries_industries2008[,3] <- regmatches(countries_industries2008[,2],regexpr("...$", countries_industries2008[,2]))
temp <- unlist(regmatches(countries_industries2008[,2],regexpr("...$", countries_industries2008[,2]), invert = TRUE))
countries_industries2008[,2] <- temp[temp != ""]

# bind data and identifiers together
nrca1995 <- cbind(countries_industries1995, 1995, nrca1995)
nrca2000 <- cbind(countries_industries2000, 2000, nrca2000)
nrca2005 <- cbind(countries_industries2005, 2005, nrca2005)
nrca2008 <- cbind(countries_industries2008, 2008, nrca2008)

names(nrca1995) <- c("country", "industry", "industry_description", "year", "nrca")
names(nrca2000) <- c("country", "industry", "industry_description", "year", "nrca")
names(nrca2005) <- c("country", "industry", "industry_description", "year", "nrca")
names(nrca2008) <- c("country", "industry", "industry_description", "year", "nrca")

# combining the data.frames
nrca <- rbind(nrca1995, nrca2000, nrca2005, nrca2008)

# save again
save(nrca, file = "data/nrca_df.RData")

# remove redundancies
rm(names_nrca1995)
rm(names_nrca2000)
rm(names_nrca2005)
rm(names_nrca2008)
rm(countries_industries1995)
rm(countries_industries2000)
rm(countries_industries2005)
rm(countries_industries2008)
rm(temp)


# rename trca variables
names(trca) <- c("country", "industry", "year", "trca")

rca <- merge(nrca, trca, by = c("country", "industry", "year") )

save(rca, file = "data/rca.RData")
