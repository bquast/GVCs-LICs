# analyse.R
# Bastiaan Quast
# bquast@gmail.com

# load the rca data
load("data/rca.RData")

# calcute the difference between the two RCAs
rca["rca_difference"] <- rca["nrca"] - rca["trca"]
rca["abs_rca_diff"] <- abs(rca["rca_difference"])

ordered_rca <- rca[ order(rca["abs_rca_diff"]), ]

save(rca, ordered_rca, file = "data/rca.RData")


# load Leontief
load(file = 'data/TiVa-Leontief.RData')


# NRCA decomposition
nrca1995 <- nrca(l1995)
nrca2000 <- nrca(l2000)
nrca2005 <- nrca(l2005)
nrca2008 <- nrca(l2008)
nrca2009 <- nrca(l2009)
nrca2010 <- nrca(l2010)
nrca2011 <- nrca(l2011)


# save NRCAs
save(nrca1995, nrca2000, nrca2005, nrca2008, nrca2009, nrca2010, nrca2011, file ="data/nrca.RData")
