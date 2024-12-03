#### Preamble ####
# Purpose: First modle
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
first_model <-
  stan_glm(
    formula = current_price ~ month + old_price + vendor,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 26
  )

# Inspect the data to understand its structure
str(analysis_data)

# Build the linear regression model (second model)
second_model <- lm(current_price ~ month + old_price + vendor, data = analysis_data)

# Summary of the model to evaluate its performance
summary(second_model)

# Diagnostics: Check residuals and model fit
par(mfrow = c(2, 2))
plot(second_model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)