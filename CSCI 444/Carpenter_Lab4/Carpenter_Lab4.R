#Jonah Carpenter
#CSCI 444 - Lab 4
library(tidyverse)

dn <- read_csv("data/dennys.csv")
lq <- read_csv("data/laquinta.csv")

# there are 3 denny's in alaska
dn_ak <- dn %>% filter(state == "AK")
nrow(dn_ak)

# there are 2 laquintas in alaska
lq_ak <- lq %>% filter(state == "AK")
nrow(lq_ak)

# 1322 observations with the var names: address.x, city.x/y,state, zip.x/y,longitude.x/y,latitude.x/y, distance
ak_all <- full_join(dn_ak, lq_ak, by = "state")
glimpse(ak_all)

haversine <- function(long1, lat1, long2, lat2, round = 3) {
  R <- 6371
  delta_long <- (long2 - long1) * pi / 180
  delta_lat <- (lat2 - lat1) * pi / 180
  a <- sin(delta_lat / 2) ^ 2 + cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * sin(delta_long / 2) ^ 2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  d <- R * c
  round(d, digits = round)
}

ak_all <- ak_all %>%
  mutate(distance = haversine(longitude.x, latitude.x, longitude.y, latitude.y))

# > glimpse(ak_min)
# Rows: 3
# Columns: 3
# Groups: city.x [2]
# $ city.x       <chr> "Anchorage", "Anchorage", "Fairbank…
# $ address.x    <chr> "2900 Denali", "3850 Debarr Road", …
# $ min_distance <dbl> 2.035, 5.998, 5.197
ak_min <- ak_all %>%
  group_by(city.x, address.x) %>%
  summarize(min_distance = min(distance))

deep_south <- c("AL", "SC", "MS", "GA", "LA")
dn_ds <- dn %>% filter(state %in% deep_south)
lq_ds <- lq %>% filter(state %in% deep_south)
ds_all <- full_join(dn_ds, lq_ds, by = "state") %>%
  mutate(distance = haversine(longitude.x, latitude.x, longitude.y, latitude.y))

# > glimpse(ds_min)
# Rows: 10
# Columns: 4
# Groups: state, city.x [9]
# $ state        <chr> "LA", "GA", "GA", "AL", "GA", "GA",…
# $ city.x       <chr> "Metairie", "Augusta", "Savannah", …
# $ address.x    <chr> "5910 Veterans", "3026 Washington R…
# $ min_distance <dbl> 0.020, 0.024, 0.070, 0.133, 0.224, …
ds_min <- ds_all %>%
  group_by(state, city.x, address.x) %>%
  summarize(min_distance = min(distance)) %>%
  arrange(min_distance) %>%
  head(10)

ds_avg <- ds_min %>%
  group_by(state) %>%
  summarize(avg_dist = mean(min_distance))

ggplot(ds_avg, aes(x = state, y = avg_dist, fill = state)) +
  geom_col()

# On average, in which state are Denny’s and La Quinta the furthest apart? On average, in which state are they the closest?
state_avg_dist <- ds_all %>%
  group_by(state) %>%
  summarize(avg_dist = mean(distance, na.rm = TRUE))

furthest_state <- state_avg_dist %>%
  filter(avg_dist == max(avg_dist))

closest_state <- state_avg_dist %>%
  filter(avg_dist == min(avg_dist))

furthest_state
closest_state

# > furthest_state
# A tibble: 1 × 2
# state avg_dist
# <chr>    <dbl>
#  1 LA        281.
# > closest_state
# A tibble: 1 × 2
# state avg_dist
# <chr>    <dbl>
#  1 SC        172.
