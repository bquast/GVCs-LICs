# leontief matrix form
# Bastiaan Quast
# bquast@gmail.com

library(decompr)

lm1995 <- load_tables_vectors(wid1995,
                              wfd1995,
                              countries,
                              sectors,
                              output1995)
lm2000 <- load_tables_vectors(wid2000,
                              wfd2000,
                              countries,
                              sectors,
                              output2000)
lm2005 <- load_tables_vectors(wid2005,
                              wfd2005,
                              countries,
                              sectors,
                              output2005)
lm2008 <- load_tables_vectors(wid2008,
                              wfd2008,
                              countries,
                              sectors,
                              output2008)

lmf1995 <- leontief(lm1995, long=FALSE)
lmf2000 <- leontief(lm2000, long=FALSE)
lmf2005 <- leontief(lm2005, long=FALSE)
lmf2008 <- leontief(lm2008, long=FALSE)

# run nrca's

library(gvc)

nrca1995 <- nrca(lmf1995)
nrca2000 <- nrca(lmf2000)
nrca2005 <- nrca(lmf2005)
nrca2008 <- nrca(lmf2008)

# save nrca's
save(nrca1995, nrca2000, nrca2005, nrca2008, file ="data/nrca.RData")
