#### Preamble ####
# Purpose: Simulate data
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
set.seed(26)

#### Simulate data ####
# Vendor names
vendors <- c("Walmart","Loblaws")

# Generate simulated data
simulated_data <- tibble(
  vendor = sample(vendors, size = 1000, replace = TRUE),  
  current_price = round(runif(1000, 0.5, 60), 3),  
  old_price = round(runif(1000, 1, 60), 3),
  month = sample(1:12, size = 1000, replace = TRUE)
)

write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
