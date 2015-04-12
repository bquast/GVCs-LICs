# import_wiod.R
# Bastiaan Quast
# bquast@gmail.com

# readxl library
library(readxl)

# read the data
wiod95 <- read_excel("data/wiot95_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod96 <- read_excel("data/wiot96_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod97 <- read_excel("data/wiot97_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod98 <- read_excel("data/wiot98_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod99 <- read_excel("data/wiot99_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod00 <- read_excel("data/wiot00_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod01 <- read_excel("data/wiot01_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod02 <- read_excel("data/wiot02_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod03 <- read_excel("data/wiot03_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod04 <- read_excel("data/wiot04_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod05 <- read_excel("data/wiot05_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod06 <- read_excel("data/wiot06_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod07 <- read_excel("data/wiot07_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod08 <- read_excel("data/wiot08_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod09 <- read_excel("data/wiot09_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod10 <- read_excel("data/wiot10_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)
wiod11 <- read_excel("data/wiot11_row_apr12.xlsx", sheet = 1, col_names = FALSE, skip = 6)

# cut off the first columns
wiod95 <- wiod95[,-c(1:2)]
wiod96 <- wiod96[,-c(1:2)]
wiod97 <- wiod97[,-c(1:2)]
wiod98 <- wiod98[,-c(1:2)]
wiod99 <- wiod99[,-c(1:2)]
wiod00 <- wiod00[,-c(1:2)]
wiod01 <- wiod01[,-c(1:2)]
wiod02 <- wiod02[,-c(1:2)]
wiod03 <- wiod03[,-c(1:2)]
wiod04 <- wiod04[,-c(1:2)]
wiod05 <- wiod05[,-c(1:2)]
wiod06 <- wiod06[,-c(1:2)]
wiod07 <- wiod07[,-c(1:2)]
wiod08 <- wiod08[,-c(1:2)]
wiod09 <- wiod09[,-c(1:2)]
wiod10 <- wiod10[,-c(1:2)]
wiod11 <- wiod11[,-c(1:2)]

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
wiod96 <- wiod96[1:GN, ]
wiod97 <- wiod97[1:GN, ]
wiod98 <- wiod98[1:GN, ]
wiod99 <- wiod99[1:GN, ]
wiod00 <- wiod00[1:GN, ]
wiod01 <- wiod01[1:GN, ]
wiod02 <- wiod02[1:GN, ]
wiod03 <- wiod03[1:GN, ]
wiod04 <- wiod04[1:GN, ]
wiod05 <- wiod05[1:GN, ]
wiod06 <- wiod06[1:GN, ]
wiod07 <- wiod07[1:GN, ]
wiod08 <- wiod08[1:GN, ]
wiod09 <- wiod09[1:GN, ]
wiod10 <- wiod10[1:GN, ]
wiod11 <- wiod11[1:GN, ]

# take out intermediate demand
wid95 <- as.matrix(wiod95[ , 3:(GN+2) ])
wid96 <- as.matrix(wiod96[ , 3:(GN+2) ])
wid97 <- as.matrix(wiod97[ , 3:(GN+2) ])
wid98 <- as.matrix(wiod98[ , 3:(GN+2) ])
wid99 <- as.matrix(wiod99[ , 3:(GN+2) ])
wid00 <- as.matrix(wiod00[ , 3:(GN+2) ])
wid01 <- as.matrix(wiod01[ , 3:(GN+2) ])
wid02 <- as.matrix(wiod02[ , 3:(GN+2) ])
wid03 <- as.matrix(wiod03[ , 3:(GN+2) ])
wid04 <- as.matrix(wiod04[ , 3:(GN+2) ])
wid05 <- as.matrix(wiod05[ , 3:(GN+2) ])
wid06 <- as.matrix(wiod06[ , 3:(GN+2) ])
wid07 <- as.matrix(wiod07[ , 3:(GN+2) ])
wid08 <- as.matrix(wiod08[ , 3:(GN+2) ])
wid09 <- as.matrix(wiod09[ , 3:(GN+2) ])
wid10 <- as.matrix(wiod10[ , 3:(GN+2) ])
wid11 <- as.matrix(wiod11[ , 3:(GN+2) ])

# take out final demand
wfd95 <- as.matrix( wiod95[ , (GN+3):(length(wiod95)-1)] )
wfd96 <- as.matrix( wiod96[ , (GN+3):(length(wiod96)-1)] )
wfd97 <- as.matrix( wiod97[ , (GN+3):(length(wiod97)-1)] )
wfd98 <- as.matrix( wiod98[ , (GN+3):(length(wiod98)-1)] )
wfd99 <- as.matrix( wiod99[ , (GN+3):(length(wiod99)-1)] )
wfd00 <- as.matrix( wiod00[ , (GN+3):(length(wiod00)-1)] )
wfd01 <- as.matrix( wiod01[ , (GN+3):(length(wiod01)-1)] )
wfd02 <- as.matrix( wiod02[ , (GN+3):(length(wiod02)-1)] )
wfd03 <- as.matrix( wiod03[ , (GN+3):(length(wiod03)-1)] )
wfd04 <- as.matrix( wiod04[ , (GN+3):(length(wiod04)-1)] )
wfd05 <- as.matrix( wiod05[ , (GN+3):(length(wiod05)-1)] )
wfd06 <- as.matrix( wiod06[ , (GN+3):(length(wiod06)-1)] )
wfd07 <- as.matrix( wiod07[ , (GN+3):(length(wiod07)-1)] )
wfd08 <- as.matrix( wiod08[ , (GN+3):(length(wiod08)-1)] )
wfd09 <- as.matrix( wiod09[ , (GN+3):(length(wiod09)-1)] )
wfd10 <- as.matrix( wiod10[ , (GN+3):(length(wiod10)-1)] )
wfd11 <- as.matrix( wiod11[ , (GN+3):(length(wiod11)-1)] )

# take out output
out95 <- wiod95[ , length(wiod95) ]
out96 <- wiod96[ , length(wiod96) ]
out97 <- wiod97[ , length(wiod97) ]
out98 <- wiod98[ , length(wiod98) ]
out99 <- wiod99[ , length(wiod99) ]
out00 <- wiod00[ , length(wiod00) ]
out01 <- wiod01[ , length(wiod01) ]
out02 <- wiod02[ , length(wiod02) ]
out03 <- wiod03[ , length(wiod03) ]
out04 <- wiod04[ , length(wiod04) ]
out05 <- wiod05[ , length(wiod05) ]
out06 <- wiod06[ , length(wiod06) ]
out07 <- wiod07[ , length(wiod07) ]
out08 <- wiod08[ , length(wiod08) ]
out09 <- wiod09[ , length(wiod09) ]
out10 <- wiod10[ , length(wiod10) ]
out11 <- wiod11[ , length(wiod11) ]


# leontief decompose
l95 <- decomp(wid95,wfd95,countries,sectors,out95)
l96 <- decomp(wid96,wfd96,countries,sectors,out96)
l97 <- decomp(wid97,wfd97,countries,sectors,out97)
l98 <- decomp(wid98,wfd98,countries,sectors,out98)
l99 <- decomp(wid99,wfd99,countries,sectors,out99)
l00 <- decomp(wid00,wfd00,countries,sectors,out00)
l01 <- decomp(wid01,wfd01,countries,sectors,out01)
l02 <- decomp(wid02,wfd02,countries,sectors,out02)
l03 <- decomp(wid03,wfd03,countries,sectors,out03)
l04 <- decomp(wid04,wfd04,countries,sectors,out04)
l05 <- decomp(wid05,wfd05,countries,sectors,out05)
l06 <- decomp(wid06,wfd06,countries,sectors,out06)
l07 <- decomp(wid07,wfd07,countries,sectors,out07)
l08 <- decomp(wid08,wfd08,countries,sectors,out08)
l09 <- decomp(wid09,wfd09,countries,sectors,out09)
l10 <- decomp(wid10,wfd10,countries,sectors,out10)
l11 <- decomp(wid11,wfd11,countries,sectors,out11)

# save the data
save(l95, l96, l97, l98, l99, l00, l01, l02, l03, l04, l05, l06, l07, l08, l09, l10, l11, file = "data/wiod-leontief.RData")
