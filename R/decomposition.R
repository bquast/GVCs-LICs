# decomposition.R
# Bastiaan Quast
# bquast@gmail.com

# load the library
library(decompr)

# run the Leontief decomposition
l1995 <- decomp(wid1995,
                wfd1995,
                countries,
                sectors,
                output1995,
                method = "leontief")
l2000 <- decomp(wid2000,
                wfd2000,
                countries,
                sectors,
                output2000,
                method = "leontief")
l2005 <- decomp(wid2005,
                wfd2005,
                countries,
                sectors,
                output2005,
                method = "leontief")
l2008 <- decomp(wid2008,
                wfd2008,
                countries,
                sectors,
                output2008,
                method = "leontief")

# save Leontief the data
save(l1995, l2000, l2005, l2008, file = "data/TiVa-Leontief.RData")



# run the Wang-Wei-Zhu decomposition 
w1995 <- decomp(wid1995,
                wfd1995,
                countries,
                sectors,
                output1995,
                method = "wwz")
w2000 <- decomp(wid2000,
                wfd2000,
                countries,
                sectors,
                output2000,
                method = "wwz")
w2005 <- decomp(wid2005,
                wfd2005,
                countries,
                sectors,
                output2005,
                method = "wwz")
w2008 <- decomp(wid2008,
                wfd2008,
                countries,
                sectors,
                output2008,
                method = "wwz")

# save the Wang-Wei-Zhu data
save(w1995, w2000, w2005, w2008, file = "data/TiVa-WWZ.RData")
