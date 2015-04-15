# merge-wwz.R
# Bastiaan Quast
# bquast@gmail.com

# load the data
load("data/w1995.RData")
load("data/w2000.RData")
load("data/w2005.RData")
load("data/w2008.RData")

# add year variable to each data set
w1995 <- cbind(year = 1995, w1995)
w2000 <- cbind(year = 2000, w2000)
w2005 <- cbind(year = 2005, w2005)
w2008 <- cbind(year = 2008, w2008)

# stack the data sets
w1995_2008 <- rbind(w1995, w2000, w2005, w2008)

# # to lower case
levels(w1995_2008$Exporting_Country) <- tolower(levels(w1995_2008$Exporting_Country))
levels(w1995_2008$Exporting_Industry) <- tolower(levels(w1995_2008$Exporting_Industry))
levels(w1995_2008$Importing_Country) <- tolower(levels(w1995_2008$Importing_Country))

# remove ROW (Rest of World)
w1995_2008 <- subset(w1995_2008, Exporting_Country != "row")

# save
saveRDS(w1995_2008, file = "data/w1995_2008.rds", compress = "xz")

# merge
coun_var <- read.csv("data/Country_variables.csv")
