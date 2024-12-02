#### Preamble ####
# Purpose: Cleans the data
# Author: Wei Wang
# Date: 2 December 2024 
# Contact: won.wang@mail.utoronto.ca

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv")

joined_data <- raw_data %>%
  inner_join(product_data, by = c("product_id" = "id")) %>%
  select(nowtime, 
         vendor, 
         product_id, 
         product_name, 
         brand, 
         current_price, 
         old_price, 
         units, 
         price_per_unit)

cleaned_data <- joined_data %>% 
  filter(vendor %in% c("Walmart","Loblaws")) %>%
  select(nowtime, vendor, current_price, old_price, product_name) %>% 
  mutate(month = month(nowtime),
         current_price = parse_number(current_price),
         old_price = parse_number(old_price)) %>%
  filter(str_detect(tolower(product_name), "steak")) %>%
  select(-nowtime) %>%
  tidyr::drop_na()

#### Save data ####
write_parquet(x = cleaned_data,
              sink = "data/02-analysis_data/analysis_data.parquet")

write_csv(cleaned_data, "/Users/lucky/Desktop/involves-original-work/data/02-analysis_data/analysis_data.csv") 