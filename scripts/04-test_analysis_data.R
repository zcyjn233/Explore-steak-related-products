#### Preamble ####
# Purpose: Test analysis data
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca



#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Test that the dataset has 1000 rows
test_that("Dataset contains exactly 1000 rows", {
  expect_equal(nrow(analysis_data), 1000)
})

# Test that the 'vendor' column contains only values from the predefined list
test_that("'vendor' column has only predefined values", {
  predefined_vendors <- c("Walmart", "Loblaws")
  expect_true(all(analysis_data$vendor %in% predefined_vendors))
})

# Test that the 'current_price' and 'old_price' columns are numeric
test_that("'current_price' and 'old_price' columns are numeric", {
  expect_type(analysis_data$current_price, "double")
  expect_type(analysis_data$old_price, "double")
})

# Test that the 'month' column contains values from 1 to 12
test_that("'month' column contains values from 1 to 12", {
  expect_true(all(analysis_data$month %in% 1:12))
})


