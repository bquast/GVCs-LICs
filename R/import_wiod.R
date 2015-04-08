# import_wiod.R
# Bastiaan Quast
# bquast@gmail.com

# readxl library
library(readxl)

# read the data
wiod95 <- read_excel("data/wiot95_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod95 <- read_excel("data/wiot96_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)

# cut off the first columns
wiod95 <- wiod95[,-c(1:2)]
wiod96 <- wiod96[,-c(1:2)]

# separate out country and sector names
countries <- wiod95[ , 1]
sectors   <- wiod95[ , 2]

# filter out doubles
countries <- unique(countries)
sectors   <- unique(sectors)

# verify created objects
print(countries)
print(sectors)

# remove invalid parts by subsetting only valid parts
countries <- countries[1:41]
sectors   <- sectors[1:35]

# verify again
print(countries)
print(sectors)

# length of objects
G <- length(countries)
N <- length(sectors)
GN <- G * N

# take out extras at bottom
wiod95 <- wiod95[1:GN, ]

# take out intermediate demand
wid95 <- as.matrix(wiod95[ , 3:(GN+2) ])

# take out final demand
wfd95 <- as.matrix( wiod95[ , (GN+3):(length(wiod95)-1)] )

# take out output
out95 <- wiod95[ , length(wiod95) ]

# leontief decompose
l95 <- decomp(wid95,wfd95,countries,sectors,out95)
