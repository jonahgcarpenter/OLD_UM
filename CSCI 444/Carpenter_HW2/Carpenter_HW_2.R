# Jonah Carpenter
# CSCI 444
# Homework 2
# Washington DC Bike Sharing Rentals

library(tidyverse)
library(rvest)
library(robotstxt)
library(lubridate)

m <- c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")

for (i in 1:9) {
  month_str <- sprintf("%02d", i)
  url <- paste0("https://s3.amazonaws.com/capitalbikeshare-data/2023", month_str, "-capitalbikeshare-tripdata.zip")
  zip_file <- tempfile(tmpdir = "temp_data", fileext = ".zip")
  download.file(url, zip_file, mode = "wb")
  
  unzip_dir <- tempfile(tmpdir = "temp_data")
  
  tryCatch({
    unzip(zip_file, exdir = unzip_dir)
  }, error = function(e) {
    print(paste("Error unzipping file for month:", m[i], "->", e$message))
  })
  
  csv_file <- list.files(unzip_dir, pattern = "*.csv$", full.names = TRUE)
  csv_file <- csv_file[!grepl("__MACOSX", csv_file)]
  
  if (length(csv_file) > 0) {
    print(paste("Downloading data for month:", m[i]))
    print(csv_file[1])
    
    one_file <- read_csv(csv_file[1])
    colnames(one_file) <- make.unique(colnames(one_file))
    write_csv(one_file, paste0("temp_data/bike_data_", m[i], ".csv"))
  } else {
    print(paste("No valid CSV file found for month:", m[i]))
  }
}

for (i in 10:12) {
  url <- paste0("https://s3.amazonaws.com/capitalbikeshare-data/2023", i, "-capitalbikeshare-tripdata.zip")
  zip_file <- tempfile(tmpdir = "temp_data", fileext = ".zip")
  download.file(url, zip_file, mode = "wb")
  
  unzip_dir <- tempfile(tmpdir = "temp_data")
  
  tryCatch({
    unzip(zip_file, exdir = unzip_dir)
  }, error = function(e) {
    print(paste("Error unzipping file for month:", m[i], "->", e$message))
  })
  
  csv_file <- list.files(unzip_dir, pattern = "*.csv$", full.names = TRUE)
  csv_file <- csv_file[!grepl("__MACOSX", csv_file)]
  
  if (length(csv_file) > 0) {
    print(paste("Downloading data for month:", m[i]))
    print(csv_file[1])
    
    one_file <- read_csv(csv_file[1])
    colnames(one_file) <- make.unique(colnames(one_file))
    write_csv(one_file, paste0("temp_data/bike_data_", m[i], ".csv"))
  } else {
    print(paste("No valid CSV file found for month:", m[i]))
  }
}

csv_files <- list.files("temp_data", pattern = "\\.csv$", full.names = TRUE)
bikes <- map_dfr(csv_files, read_csv)

bikes <- bikes %>%
  select(started_at, ended_at, member_casual, rideable_type) %>%
  mutate(
    month = month(started_at, label = TRUE, abbr = TRUE),
    Season = case_when(
      month(started_at) %in% c(12, 1, 2) ~ "Winter",
      month(started_at) %in% c(3, 4, 5) ~ "Spring",
      month(started_at) %in% c(6, 7, 8) ~ "Summer",
      month(started_at) %in% c(9, 10, 11) ~ "Fall"
    ),
    Membership = case_when(
      member_casual == "casual" ~ "Non-Member",
      member_casual == "member" ~ "Member"
    ),
    Date = as_date(started_at)
  )

write_csv(bikes, "data/bikes_2023.csv")


base_url <- "https://i-weather.com/weather/washington/history/monthly-history/?gid=4140963&station=19064&month="
date_2023 <- c()
min_temp_2023 <- c()
max_temp_2023 <- c()
rain_2023 <- c()

for (i in 1:12) {
  url <- paste0(base_url, i, "&year=2023&language=english&country=us-united-states")
  html_page <- read_html(url)
  
  date <- html_page %>% 
    html_nodes("table tbody tr td:nth-child(1) > a") %>% 
    html_text() %>% 
    trimws()
  
  min_temp <- html_page %>% 
    html_nodes("table tbody tr td:nth-child(2)") %>% 
    html_text() %>% 
    parse_number()
  
  max_temp <- html_page %>% 
    html_nodes("table tbody tr td:nth-child(3)") %>% 
    html_text() %>% 
    parse_number()
  
  rain <- html_page %>% 
    html_nodes("table tbody tr td:nth-child(5)") %>% 
    html_text() %>% 
    parse_number()
  
  max_length <- min(length(date), length(min_temp), length(max_temp), length(rain))
  date <- date[1:max_length]
  min_temp <- min_temp[1:max_length]
  max_temp <- max_temp[1:max_length]
  rain <- rain[1:max_length]
  
  date_2023 <- c(date_2023, date)
  min_temp_2023 <- c(min_temp_2023, min_temp)
  max_temp_2023 <- c(max_temp_2023, max_temp)
  rain_2023 <- c(rain_2023, rain)
}

max_temp_2023[is.na(max_temp_2023)] <- 26
rain_2023[is.na(rain_2023)] <- 0
date_2023 <- as.Date(date_2023, format = "%m/%d/%Y")
valid_indices <- !is.na(date_2023)

weather <- data.frame(
  Date = date_2023[valid_indices],
  min_temp = min_temp_2023[valid_indices],
  max_temp = max_temp_2023[valid_indices],
  rain = rain_2023[valid_indices]
)

weather <- weather %>%
  mutate(
    Date = as_date(Date),
    Temperature = (max_temp * 9/5) + 32,  
    Rain = rain / 25.4
  )

write_csv(weather, "data/weather_2023.csv")

bikes <- read_csv("data/bikes_2023.csv")
weather <- read_csv("data/weather_2023.csv")

# VIZ3
bike_count <- bikes %>%
  group_by(Date) %>%
  summarize(Bike_Rentals = n())

bike_count_merge <- left_join(bike_count, weather, by = "Date")

ggplot(bike_count_merge, aes(x = Date, y = Bike_Rentals, color = Temperature)) +
  geom_point() +
  labs(title = "Bike Rentals by Date (with Temperature)", 
       x = "Date", 
       y = "Bike Rentals") +
  theme_minimal()

# VIZ4
bike_membership <- bikes %>%
  group_by(Date, member_casual) %>%
  summarize(Bike_Rentals = n())

bike_membership_merge <- left_join(bike_membership, weather, by = "Date")

ggplot(bike_membership_merge, aes(x = Date, y = Bike_Rentals, color = Temperature)) +
  geom_point() +
  facet_wrap(~ member_casual) +
  labs(title = "Bike Rentals by Date and Membership (with Temperature)", 
       x = "Date", 
       y = "Bike Rentals") +
  theme_minimal()

# VIZ5a
bike_membership <- bikes %>%
  group_by(member_casual) %>%
  summarize(Bike_Rentals = n())

ggplot(bike_membership, aes(x = member_casual, y = Bike_Rentals, fill = member_casual)) +
  geom_col() +
  labs(
    title = "Member vs. Non-Member Bike Rentals",
    x = "Membership",
    y = "Bike Rentals",
    fill = "Membership"
  ) +
  theme_minimal()

# VIZ5b
bike_season <- bikes %>%
  group_by(Season, member_casual) %>%
  summarize(Bike_Rentals = n())

ggplot(bike_season, aes(x = Season, y = Bike_Rentals, fill = Season)) +
  geom_col() +
  facet_wrap(~ member_casual) +  # Facet wrap by members and non-members
  labs(
    title = "Member vs. Non-Member Bike Rentals by Season",
    x = "Season",
    y = "Bike Rentals",
    fill = "Season"
  ) +
  theme_minimal()

# VIZ6
bike_monthly <- bikes %>%
  group_by(Date, member_casual) %>%
  summarize(Bike_Rentals = n()) %>%
  mutate(Month = month(Date, label = TRUE, abbr = TRUE),
         Day = day(Date))  # Extract only the day of the month

ggplot(bike_monthly, aes(x = Day, y = Bike_Rentals, fill = member_casual)) +  # Use Day on x-axis
  geom_bar(stat = "identity", position = "stack") +  # Stacked bars for members and non-members
  facet_wrap(~ Month, scales = "free_y", nrow = 4, ncol = 3) +  # Facet by month
  labs(title = "Bike Rentals by Month: Members vs Non-Members", 
       x = "Day",  # Change x-axis label to 'Day'
       y = "Bike Rentals", 
       fill = "Membership") +
  theme_minimal()

# VIZ7
bike_type <- bikes %>%
  group_by(Date = as.Date(started_at), Bike_Type = rideable_type) %>%
  summarize(Bike_Rentals = n())

bike_type_merge <- left_join(bike_type, weather, by = "Date")

bike_type_merge <- bike_type_merge %>%
  mutate(rain = ifelse(is.na(rain), 0, rain))

ggplot(bike_type_merge, aes(x = Date)) +
  geom_point(aes(y = Bike_Rentals, color = Bike_Type), size = 1.5) +
  geom_line(aes(y = rain * 5000), color = "blue", linetype = "dashed") +
  labs(title = "Bike Rentals by Type of Bike and Rainfall", 
       x = "Date", 
       y = "Bike Rentals") +
  scale_y_continuous(
    sec.axis = sec_axis(~ . / 5000, name = "Rainfall (mm)")
  ) +
  theme_minimal()
