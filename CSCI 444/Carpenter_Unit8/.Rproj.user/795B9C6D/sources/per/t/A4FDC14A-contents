#Jonah Carpenter
#Unit8
library(tidyverse)
library(lubridate)

weather_data <- read_csv("data/weather.csv")

weather_long <- weather_data %>%
  pivot_longer(cols = starts_with("d"), names_to = "day", values_to = "measure") %>%
  mutate(day = str_remove(day, "d"))

weather_long <- weather_long %>%
  filter(!is.na(measure) & measure >= 0)

weather_long <- weather_long %>%
  mutate(date = ymd(paste0(year, "-", month, "-", day)))

today_data <- weather_long %>%
  filter(month(date) == month(today()) & day(date) == day(today()))

avg_rainfall <- today_data %>%
  group_by(year, month, day) %>%
  summarise(avg_rainfall = mean(measure, na.rm = TRUE)) %>%
  distinct()

ggplot(avg_rainfall, aes(x = year, y = avg_rainfall)) +
  geom_line(color = "slateblue") +
  labs(title = "Average Rainfall Over the Years",
       x = "Year", y = "Average Rainfall") +
  theme_minimal()
