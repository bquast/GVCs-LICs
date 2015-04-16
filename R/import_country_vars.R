# import-country-vars.R
# Bastiaan Quast
# bquast@gmail.com

# load library
library(readr)

# load the data
country_vars <- read_csv(file = "data/Country_variables.csv")

# save the data
save(country_vars, file = "data/country_vars.RData")
