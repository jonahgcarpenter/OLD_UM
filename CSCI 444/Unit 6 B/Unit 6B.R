library(dplyr)
library(readr)

cat_data <- read_csv("C:/Users/jonah/Documents/444/Unit 6 B/data/cat-lovers-v2.csv")

glimpse(cat_data)
names(cat_data) # Check the available column names

cat_data <- cat_data %>%
  mutate(number_of_cats = as.numeric(number_of_cats))

mean_cats <- mean(cat_data$number_of_cats, na.rm = TRUE)

cat_data <- cat_data %>%
  mutate(
    handedness = case_when(
      handedness == "l" ~ "left",
      handedness == "r" ~ "right",
      handedness == "a" ~ "ambidextrous",
      TRUE ~ handedness
    )
  )

below_mean_cats <- cat_data %>%
  filter(!is.na(number_of_cats) & number_of_cats < mean_cats)

below_mean_cats

mean_cats
n_below_mean <- nrow(below_mean_cats)

#Now, what is the mean number of cats owned?  How many respondents have below the mean number of cats (use filter)?
#mean = .7586207
#how many below the mean = 33