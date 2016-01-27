# decomposition.R
# Bastiaan Quast
# bquast@gmail.com

# load the library
library(decompr)

# run the Leontief decomposition
l1995 <- decomp(inter1995,
                final1995,
                countries,
                industries,
                output1995,
                method = "leontief")
l2000 <- decomp(inter2000,
                final2000,
                countries,
                industries,
                output2000,
                method = "leontief")
l2005 <- decomp(inter2005,
                final2005,
                countries,
                industries,
                output2005,
                method = "leontief")
l2008 <- decomp(inter2008,
                final2008,
                countries,
                industries,
                output2008,
                method = "leontief")
l2009 <- decomp(inter2009,
                final2009,
                countries,
                industries,
                output2009,
                method = "leontief")
l2010 <- decomp(inter2010,
                final2010,
                countries,
                industries,
                output2010,
                method = "leontief")
l2011 <- decomp(inter2011,
                final2011,
                countries,
                industries,
                output2011,
                method = "leontief")

# save Leontief the data
save(l1995, l2000, l2005, l2008, file = "data/TiVa-Leontief.RData")



# run the Wang-Wei-Zhu decomposition
w1995 <- decomp(inter1995,
                final1995,
                countries,
                industries,
                output1995,
                method = "wwz")
w2000 <- decomp(inter2000,
                final2000,
                countries,
                industries,
                output2000,
                method = "wwz")
w2005 <- decomp(inter2005,
                final2005,
                countries,
                industries,
                output2005,
                method = "wwz")
w2008 <- decomp(inter2008,
                final2008,
                countries,
                industries,
                output2008,
                method = "wwz")

# save the Wang-Wei-Zhu data
save(w1995, w2000, w2005, w2008, file = "data/TiVa-WWZ.RData")
