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
