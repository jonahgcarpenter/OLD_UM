#Jonah Carpenter
#CSCI 444 - Lab 6

pacman::p_load(tidyverse, lubridate, RColorBrewer, leaflet)

url <- "https://data.insideairbnb.com/united-states/ny/new-york-city/2024-09-04/visualisations/listings.csv"

nyc <- read_csv(url)

nyc <- nyc %>%
  rename(
    borough = neighbourhood_group,
    min_nights = minimum_nights,
    num_reviews = number_of_reviews,
    count = calculated_host_listings_count,
    availability = availability_365
  ) %>%
  mutate(last_review = as_date(last_review)) %>%
  filter(availability > 0)

write_csv(nyc, "data/NYC_2024_listings.csv")

# 1
airbnb_counts_by_room <- nyc %>%
  group_by(borough, room_type) %>%
  summarise(count = sum(count))

ggplot(airbnb_counts_by_room, aes(x = room_type, y = count, fill = borough)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Number of Airbnbs by Types of Room in NYC", 
       x = "Types of Rooms", 
       y = "Number of Airbnbs") +
  theme(panel.background = element_blank(),
        legend.position = "none")

# most_airbnbs_per_room_type
# borough     room_type       total_airbnbs
# 1 Manhattan Entire home/apt       1002297
# 2 Brooklyn  Private room           490112
# 3 Manhattan Hotel room              68122
# 4 Brooklyn  Shared room              1258

#all boroughs have a hotel room

# 2
airbnb_counts_by_borough <- nyc %>%
  group_by(borough) %>%
  summarise(count = sum(count)) %>%
  arrange(desc(count))

ggplot(airbnb_counts_by_borough, aes(x = reorder(borough, -count), y = count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal() +
  labs(title = "Number of Airbnbs in NYC by Borough", 
       x = "NYC Borough", 
       y = "Number of Airbnbs") +
  theme(panel.background = element_blank()) +
  theme(legend.position = "none")

# > borough_with_most_airbnbs
#   1 Manhattan       1232941
# > borough_with_least_airbnbs
#  1 Staten Island           782

# 3
airbnb_avg_price_by_borough <- nyc %>%
  filter(!is.na(price)) %>%
  group_by(borough) %>%
  summarise(avg_price = mean(price)) %>%
  arrange(avg_price)

ggplot(airbnb_avg_price_by_borough, aes(x = reorder(borough, avg_price), y = avg_price)) +
  geom_col(fill = "darkgreen") +
  theme_minimal() +
  labs(title = "Average Price of Airbnbs by NYC Borough", 
       x = "NYC Borough", 
       y = "Average Price") +
  theme(panel.background = element_blank()) +
  theme(legend.position = "none")

# > borough_with_highest_price_avg
#   1 Manhattan      313.
# > borough_with_lowest_price_avg
#  1 Bronx        121.

# 4
nyc_neighborhood <- nyc %>%
  filter(!is.na(price)) %>%
  group_by(borough, neighbourhood) %>%
  summarise(avg_price = mean(price)) %>%
  arrange(desc(avg_price))

highest_cost <- nyc_neighborhood %>%
  group_by(borough) %>%
  slice_max(avg_price, n = 1)

lowest_cost <- nyc_neighborhood %>%
  group_by(borough) %>%
  slice_min(avg_price, n = 1)

highest_avg_cost <- highest_cost %>% slice_max(avg_price, n = 1)
lowest_avg_cost <- lowest_cost %>% slice_min(avg_price, n = 1)

ggplot(nyc_neighborhood, aes(x = reorder(neighbourhood, avg_price), y = avg_price)) +
  geom_bar(stat = "identity", fill = "blue") +
  facet_wrap(~ borough, scales = "free") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Average Price by Neighborhood in NYC",
       x = "Neighborhood",
       y = "Average Price") +
  theme(panel.background = element_blank())

# > print(highest_cost)
# borough       neighbourhood avg_price
# 1 Bronx         Riverdale          712.
# 2 Brooklyn      Vinegar Hill       363.
# 3 Manhattan     SoHo               900.
# 4 Queens        Briarwood          286.
# 5 Staten Island Rossville          840 

# 5
nyc_neighborhood_top5 <- nyc %>%
  filter(!is.na(price)) %>%
  group_by(borough, neighbourhood) %>%
  summarise(avg_price = mean(price)) %>%
  slice_max(avg_price, n = 5)

ggplot(nyc_neighborhood_top5, aes(x = reorder(neighbourhood, avg_price), y = avg_price, fill = neighbourhood)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ borough, scales = "free_x") +
  theme_minimal() +
  labs(title = "Top 5 Most Expensive Neighborhoods by Borough in NYC", 
       x = "Neighborhood", 
       y = "Average Price") +
  theme(panel.background = element_blank(),
        legend.position = "none",
        axis.text.x = element_text(angle = 0),
        strip.text = element_text(size = 10, face = "bold"),
        axis.title.y = element_blank())

# > print(most_expensive_rental)
# borough       neighbourhood avg_price
# 1 Bronx         Riverdale          712.
# 2 Brooklyn      Vinegar Hill       363.
# 3 Manhattan     SoHo               900.
# 4 Queens        Briarwood          286.
# 5 Staten Island Rossville          840 

# 6
nyc_2024 <- nyc %>%
  filter(!is.na(last_review), year(last_review) == 2024) %>%
  filter(!is.na(price))

ggplot(nyc_2024, aes(x = last_review, y = num_reviews, size = price, color = borough)) +
  geom_point(alpha = 0.3) +
  scale_color_brewer(palette = "Set2") +
  theme_minimal() +
  labs(title = "Airbnb Reviews", subtitle = "2024",
       x = "Date of Last Review", 
       y = "Number of Reviews") +
  theme(panel.background = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none")

# > print(max_reviews)
# borough   neighbourhood num_reviews
# 1 Manhattan East Village         1941

# 7
nyc_2024 <- nyc %>%
  filter(!is.na(last_review), year(last_review) == 2024) %>%
  filter(!is.na(price))

ggplot(nyc_2024, aes(x = last_review, y = num_reviews, size = price, color = borough)) +
  geom_point(alpha = 0.3) +
  scale_color_brewer(palette = "Set3") +
  theme_minimal() +
  facet_wrap(~ borough, nrow = 1) +
  labs(title = "Airbnb Reviews", subtitle = "2024", 
       x = NULL,
       y = "Number of Reviews") +
  theme(legend.position = "bottom",
        panel.background = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1))

# Bronx                 500
# Brooklyn              700
# Manhattan            2000
# Queens                650
# Staten Island         300

# 8
nyc_neighborhood_top3 <- nyc %>%
  group_by(borough, neighbourhood) %>%
  summarise(
    avg_price = mean(price, na.rm = TRUE),
    lat = mean(latitude, na.rm = TRUE),
    long = mean(longitude, na.rm = TRUE)
  ) %>%
  slice_max(avg_price, n = 3)

nyc_neighborhood_top3 %>%
  leaflet(options = leafletOptions(zoomSnap = 0.1)) %>%
  addTiles() %>%
  setView(lng = -74.00, lat = 40.71, zoom = 12) %>%
  addMarkers(~long, ~lat)

# > print(nyc_neighborhood_top3)
# borough       neighbourhood     avg_price   lat  long
# 1 Bronx         Riverdale              712.  40.9 -73.9
# 2 Bronx         Castle Hill            318.  40.8 -73.9
# 3 Bronx         Port Morris            216.  40.8 -73.9
# 4 Brooklyn      Vinegar Hill           363.  40.7 -74.0
# 5 Brooklyn      Carroll Gardens        327.  40.7 -74.0
# 6 Brooklyn      Brooklyn Heights       307.  40.7 -74.0
# 7 Manhattan     SoHo                   900.  40.7 -74.0
# 8 Manhattan     Battery Park City      725.  40.7 -74.0
# 9 Manhattan     NoHo                   576.  40.7 -74.0
# 10 Queens        Briarwood              286.  40.7 -73.8
# 11 Queens        Neponsit               272   40.6 -73.9
# 12 Queens        Arverne                251.  40.6 -73.8
# 13 Staten Island Rossville              840   40.5 -74.2
# 14 Staten Island Todt Hill              756   40.6 -74.1
# 15 Staten Island Fort Wadsworth         600   40.6 -74.1