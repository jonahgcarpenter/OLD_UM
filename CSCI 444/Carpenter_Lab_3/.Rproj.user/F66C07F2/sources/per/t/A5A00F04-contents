#Jonah Carpenter Lab 3

library(tidyverse)
library(sjmisc)
dn <- read_csv("data/dennys.csv")
lq <- read_csv("data/laquinta.csv")
states <- read_csv("data/states.csv")

#1
str(dn)
nrow(dn)
ncol(dn)

# variables include: address, city, state, zip, longitude, and latitude 
# 1643 rows and 6 columns

#2
str(lq)
nrow(lq)
ncol(lq)

# variables include: address, city, state, zip, longitude, and latitude 
# 909 rows and 6 columns

#3
dn_us <- dn %>% filter(state %in% states$abbreviation)
dn_not_us <- dn %>% filter(state %nin% states$abbreviation)
nrow(dn_us)
nrow(dn_not_us)

#there are 1643 within the US, and 0 outside the US

#4
lq_us <- lq %>% filter(state %in% states$abbreviation)
lq_not_us <- lq %>% filter(state %nin% states$abbreviation)
nrow(lq_us)
nrow(lq_not_us)

#there are 895 within the US, and 14 outside the US

#5
dn_us_count <- dn_us %>%
  group_by(state) %>%
  count() %>%
  arrange(desc(n)) %>%
  top_n(10)

#CA, TX, FL, AZ, IL, NY, WA, OH, MO, PA in order by most locations

lq_us_count <- lq_us %>%
  group_by(state) %>%
  count() %>%
  arrange(desc(n)) %>%
  top_n(10)

#TX, FL, CA, GA, TN, OK, LA, CO, NM, NY in order by most locations

#most of these are more developed/bigger cities with higher population density so this does not suprise me

#6
dn_us <- dn_us %>% mutate(establishment = "Denny's")
lq_us <- lq_us %>% mutate(establishment = "La Quinta")
dn_lq <- bind_rows(dn_us, lq_us)

#7
ggplot(dn_lq) +
  geom_point(aes(x = longitude, y = latitude, color = establishment), alpha = 0.25)

#the trend seems to be following the population around the location. Sticking to the 2 coast, along with Texas and Florida to ensure they are build around high population areas

#8
library(maps)
state_data <- map_data("state")

ggplot(state_data) +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = "gray") +
  coord_quickmap() +
  geom_point(data = dn_lq, aes(x = longitude, y = latitude, color = establishment))

#they seem to be missing data values or outliers, but nothing in the data set goes to -160 long

ca_data <- dn_lq %>% filter(state == "CA")
tx_data <- dn_lq %>% filter(state == "TX")
or_data <- dn_lq %>% filter(state == "OR")
ky_data <- dn_lq %>% filter(state == "KY")

ca_map <- state_data %>% filter(region == "california")
tx_map <- state_data %>% filter(region == "texas")
or_map <- state_data %>% filter(region == "oregon")
ky_map <- state_data %>% filter(region == "kentucky")

ggplot() +
  geom_polygon(data = ca_map, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "black") +
  geom_point(data = ca_data, mapping = aes(x = longitude, y = latitude, color = establishment), alpha = 0.25) +
  coord_quickmap() +
  theme_minimal()
ggplot() +
  geom_polygon(data = tx_map, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "black") +
  geom_point(data = tx_data, mapping = aes(x = longitude, y = latitude, color = establishment), alpha = 0.25) +
  coord_quickmap() +
  theme_minimal()
ggplot() +
  geom_polygon(data = or_map, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "black") +
  geom_point(data = or_data, mapping = aes(x = longitude, y = latitude, color = establishment), alpha = 0.25) +
  coord_quickmap() +
  theme_minimal()
ggplot() +
  geom_polygon(data = ky_map, mapping = aes(x = long, y = lat, group = group), fill = NA, color = "black") +
  geom_point(data = ky_data, mapping = aes(x = longitude, y = latitude, color = establishment), alpha = 0.25) +
  coord_quickmap() +
  theme_minimal()

#there is a degree of truth to this statement, but only due to them both being companies who target the same customers: people traveling the US