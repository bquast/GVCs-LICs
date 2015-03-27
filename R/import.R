# import.R
# Bastiaan Quast
# bquast@gmail.com

# load the readxl library
# for excell files (.xls / .xlsx ) 
library(readxl)

# read the final demand sheets
wfd1995 <- read_excel("data/WFD1.xlsx", sheet = 1, col_names = FALSE, skip = 2)
wfd2000 <- read_excel("data/WFD1.xlsx", sheet = 2, col_names = FALSE, skip = 2)
wfd2005 <- read_excel("data/WFD1.xlsx", sheet = 3, col_names = FALSE, skip = 2)
wfd2008 <- read_excel("data/WFD1.xlsx", sheet = 4, col_names = FALSE, skip = 2)

# separate out country and sector names
countries <- wfd1995[ , 1]
sectors   <- wfd1995[ , 2]

# filter out doubles
countries <- unique(countries)
sectors   <- unique(sectors)

# verify created objects
print(countries)
print(sectors)

# remove invalid parts by subsetting only valid parts
countries <- countries[1:58]
sectors   <- sectors[1:34]

# verify again
print(countries)
print(sectors)

# create objects for number of countries and number of sectors
# and multiple of the two
G  <- length(countries)
N  <- length(sectors)
GN <- G * N

# remove all data excel final demand statistics
wfd1995 <- wfd1995[ 1:GN, -c(1:2) ]
wfd2000 <- wfd2000[ 1:GN, -c(1:2) ]
wfd2005 <- wfd2005[ 1:GN, -c(1:2) ]
wfd2008 <- wfd2008[ 1:GN, -c(1:2) ]

# save output separately
output1995 <- wfd1995[ , length(wfd1995) ]
output2000 <- wfd2000[ , length(wfd2000) ]
output2005 <- wfd2005[ , length(wfd2005) ]
output2008 <- wfd2008[ , length(wfd2008) ]

# remove last column
wfd1995 <- wfd1995[ , -length(wfd1995) ]
wfd2000 <- wfd2000[ , -length(wfd2000) ]
wfd2005 <- wfd2005[ , -length(wfd2005) ]
wfd2008 <- wfd2008[ , -length(wfd2008) ]

# read the ICIOs
wid1995 <- read.table("~/OECD-ICIO-Export-Decomposition/data/Wicio34_1995_test.csv",
                      sep=";",
                      quote="\"",
                      stringsAsFactors=FALSE,
                      skip = 2 )
wid2000 <- read.table("~/OECD-ICIO-Export-Decomposition/data/Wicio34_2000_test.csv",
                      sep=";",
                      quote="\"",
                      stringsAsFactors=FALSE,
                      skip = 2 )
wid2005 <- read.table("~/OECD-ICIO-Export-Decomposition/data/Wicio34_2005_test.csv",
                      sep=";",
                      quote="\"",
                      stringsAsFactors=FALSE,
                      skip = 2 )
wid2008 <- read.table("~/OECD-ICIO-Export-Decomposition/data/Wicio34_2008_test.csv",
                      sep=";",
                      quote="\"",
                      stringsAsFactors=FALSE,
                      skip = 2 )

# remove first two rows with countries and sectors
# and extra information at the bottom
wid1995 <- wid1995[ 1:GN , -c(1:2) ]
wid2000 <- wid2000[ 1:GN , -c(1:2) ]
wid2005 <- wid2005[ 1:GN , -c(1:2) ]
wid2008 <- wid2008[ 1:GN , -c(1:2) ]

# save the workspace
save.image(file = "data/TiVa.RData" )
