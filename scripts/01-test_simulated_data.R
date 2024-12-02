#### Preamble ####
# Purpose: Test simulated data
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test that the dataset has 1000 rows
test_that("dataset has 1000 rows", {
  expect_equal(nrow(simulated_data), 1000)
})

# Test that the 'vendor' column contains values only from the predefined list
test_that("'vendor' column contains only predefined values", {
  predefined_vendors <- c("Walmart", "Loblaws")
  expect_true(all(simulated_data$vendor %in% predefined_vendors))
})

# Test that the 'current_price' and 'old_price' columns are numeric types
test_that("'current_price' and 'old_price' are numeric", {
  expect_type(simulated_data$current_price, "double")
  expect_type(simulated_data$old_price, "double")
})

# Test that the 'month' column contains values from 1 to 12
test_that("Variable 'month' has unique values 1 to 12", {
  expect_setequal(unique(simulated_data$month), 1:12)
})
