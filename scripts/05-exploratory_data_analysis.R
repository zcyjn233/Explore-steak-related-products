#### Preamble ####
# Purpose: graph
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
# Ensure month is treated as a factor
analysis_data <- analysis_data %>%
  mutate(month = factor(month, levels = 1:12, labels = month.abb[1:12]))

#### Distribution of current_price by vendor ####
ggplot(analysis_data, aes(x = reorder(vendor, current_price, FUN = median), y = current_price, fill = vendor)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2) +
  coord_flip() + # Flip the coordinates for better readability
  labs(
    title = "Distribution of Current Price by Vendor",
    subtitle = "Steak-related products",
    x = "Vendor",
    y = "Current Price (CAD)",
    fill = "Vendor"
  ) +
  theme_light() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

#### Distribution of current_price by month ####
ggplot(analysis_data, aes(x = month, y = current_price, fill = month)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 2) +
  labs(
    title = "Monthly Distribution of Current Price",
    subtitle = "Steak-related products",
    x = "Month",
    y = "Current Price (CAD)",
    fill = "Month"
  ) +
  theme_light() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

#### Distribution of current_price by old_price ####
ggplot(analysis_data, aes(x = old_price, y = current_price)) +
  geom_point(alpha = 0.6, color = "orange", size = 2) + # Add transparency and size for clarity
  geom_smooth(method = "lm", color = "purple", se = FALSE, linetype = "dashed") + # Add trendline
  labs(
    title = "Relationship Between Old and Current Prices",
    subtitle = "Steak-related products",
    x = "Old Price (CAD)",
    y = "Current Price (CAD)"
  ) +
  theme_light() + # Change to a cleaner theme
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12)
  )


