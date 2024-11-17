# Jonah Carpenter
# CSCI 444 - Unit 10

library(tidyverse)
library(ggplot2)
library(maps)
library(stringr)

diabetes_data <- read_csv("data/diabetes2013.csv", skip = 1)

# A
diabetes_data <- diabetes_data %>%
  rename(region = State, id = `FIPS Codes`) %>%
  mutate(across(c(percent, number), as.numeric)) %>%
  drop_na() %>%
  mutate(region = tolower(region))

county_map <- map_data("county")

county_map <- county_map %>%
  rename(region = region, subregion = subregion) %>%
  mutate(id = subregion)

map_data_joined <- county_map %>%
  left_join(diabetes_data, by = "region")

ggplot(map_data_joined, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = percent), color = "gray") +
  coord_equal() +
  scale_fill_gradient2(low = "beige", high = "red", mid = "orange", midpoint = 0.05) +
  theme_void() +
  theme(legend.position = "bottom", legend.box = "horizontal") +
  guides(fill = guide_legend(nrow = 1))

# B
fips_to_state <- c(
  "01" = "alabama", "02" = "alaska", "04" = "arizona", "05" = "arkansas",
  "06" = "california", "08" = "colorado", "09" = "connecticut", "10" = "delaware",
  "12" = "florida", "13" = "georgia", "15" = "hawaii", "16" = "idaho",
  "17" = "illinois", "18" = "indiana", "19" = "iowa", "20" = "kansas",
  "21" = "kentucky", "22" = "louisiana", "23" = "maine", "24" = "maryland",
  "25" = "massachusetts", "26" = "michigan", "27" = "minnesota", "28" = "mississippi",
  "29" = "missouri", "30" = "montana", "31" = "nebraska", "32" = "nevada",
  "33" = "new hampshire", "34" = "new jersey", "35" = "new mexico", "36" = "new york",
  "37" = "north carolina", "38" = "north dakota", "39" = "ohio", "40" = "oklahoma",
  "41" = "oregon", "42" = "pennsylvania", "44" = "rhode island", "45" = "south carolina",
  "46" = "south dakota", "47" = "tennessee", "48" = "texas", "49" = "utah",
  "50" = "vermont", "51" = "virginia", "53" = "washington", "54" = "west virginia",
  "55" = "wisconsin", "56" = "wyoming"
)

diabetes_data_state <- diabetes_data %>%
  mutate(state_fips = str_sub(id, 1, 2)) %>%
  mutate(region = fips_to_state[state_fips]) %>%
  group_by(region) %>%
  summarize(obesityMean = mean(as.numeric(percent), na.rm = TRUE))

us_map <- map_data("state")

us_map_joined <- us_map %>%
  left_join(diabetes_data_state, by = "region")

us_centroids <- us_map_joined %>%
  group_by(region) %>%
  summarize(long = mean(long), lat = mean(lat), obesityMean = mean(obesityMean))

ggplot(us_map_joined, aes(long, lat, group = group)) +
  geom_polygon(aes(fill = obesityMean), color = "gray") +
  geom_text(data = us_centroids, aes(long, lat, label = round(obesityMean, 1)), 
            color = "black", size = 4, inherit.aes = FALSE) +
  coord_equal() +
  scale_fill_gradient2(low = "beige", high = "red", mid = "orange", midpoint = 0.3) +
  theme_void() +
  theme(legend.position = "bottom", legend.box = "horizontal") +
  guides(fill = guide_legend(nrow = 1))

