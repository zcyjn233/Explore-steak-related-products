#### Preamble ####
# Purpose: Test simulated data
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(testthat)

# Load the simulated dataset
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test that the dataset contains exactly 1000 rows
test_that("Dataset contains 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Test that the 'vendor' column contains only predefined values
test_that("'vendor' column contains only predefined values", {
  predefined_vendors <- c("Walmart", "Loblaws")
  expect_true(all(simulated_data$vendor %in% predefined_vendors))
})

# Test that 'current_price' and 'old_price' columns are numeric
test_that("'current_price' and 'old_price' columns are numeric", {
  expect_type(simulated_data$current_price, "double")
  expect_type(simulated_data$old_price, "double")
})

# Test that the 'month' column contains unique values from 1 to 12
test_that("'month' column contains values from 1 to 12", {
  expect_setequal(unique(simulated_data$month), 1:12)
})