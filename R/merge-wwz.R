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

# save the data
save(w1995_2008, file = "data/w1995_2008.RData" )
