#Jonah Carpenter
#Activity C
library(rvest)
library(stringr)
library(tibble)
library(ggplot2)


# Step 1:
page <- read_html("https://www.imdb.com/chart/boxoffice/")

# Step 2:
titles <- page %>%
  html_nodes("h3.ipc-title__text") %>%
  html_text()
titles <- titles[str_detect(titles, "^\\d+\\.\\s")]

# Step 3:
gross_data <- page %>%
  html_nodes(".sc-8f57e62c-2.ftiqYS") %>%
  html_text()

# Step 4:
weekend_gross <- gross_data[seq(1, length(gross_data), by = 3)] %>%
  str_replace_all("\\$|M", "") %>%  # Remove $ and M
  as.numeric()

total_gross <- gross_data[seq(2, length(gross_data), by = 3)] %>%
  str_replace_all("\\$|M", "") %>%
  as.numeric()

weeks <- gross_data[seq(3, length(gross_data), by = 3)] %>%
  as.numeric()

# Step 5:
topGrossingFilms <- tibble(
  Title = titles,
  Weekend_Gross = weekend_gross,
  Gross = total_gross,
  Number_of_weeks = weeks
)

# Step 6:
topGrossingFilms <- topGrossingFilms %>%
  mutate(Average_Gross = Gross / Number_of_weeks) %>%
  arrange(desc(Average_Gross))  # Sort in descending order of Average_Gross

# Step 7
print(topGrossingFilms)

# Step 8
write.csv(topGrossingFilms, "top_grossing_films.csv", row.names = FALSE)

# Step 9
ggplot(topGrossingFilms, aes(x = Number_of_weeks, y = Average_Gross, fill = Title)) +
  geom_col() +
  labs(title = "Average Gross by Number of Weeks",
       x = "Number of Weeks in Theaters",
       y = "Average Gross",
       fill = "Title") +  
  theme_minimal() +
  theme(legend.position = "right")

