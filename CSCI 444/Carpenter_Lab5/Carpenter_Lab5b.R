# ######### PART B
#Jonah Carpenter
#Lab5b
library(tidyverse)
library(rvest)

videoGames <- read_csv("data/metacritics_2024.csv")

videoGames$platforms <- videoGames$platforms %>%
  str_replace_all("\\s*\\n+\\s*", ", ") %>%
  str_replace_all("\\s*,\\s*", ", ") %>%
  str_replace_all(",,+", ", ") %>%
  str_trim() %>%
  str_remove_all(",\\s*$")

num_platforms <- videoGames %>%
  mutate(num_platforms = str_count(platforms, ",") + 1) %>%
  pull(num_platforms)

# > print(num_platforms)
# [1] 5 1 1 1 3 1 7 1 4 3 5 2 2 5 4 6 2 1 1 1 5 6 6 1 1 2 4 4 3 6 2 4 1 1 6 3 7 3 1 4 1 1 6 2 2
# [46] 3 4 4 1 4 6 4 5 4 4 3 5 6 3 6 2 3 4 2 4 6 2 3 2 1 1 4 3 5 6 3 1 6 1 1 2 5 1 6 3 2 4 3 6 6
# [91] 2 3 3 4 1 2

max_platforms <- max(num_platforms)

# Output the maximum number of platforms as a comment
# max_platforms = 7

videoGames <- videoGames %>%
  separate(platforms, into = paste0("platform", 1:max_platforms), sep = ",", fill = "right") %>%
  mutate(across(starts_with("platform"), str_trim))

videoGames <- videoGames %>%
  pivot_longer(cols = starts_with("platform"), names_to = "platformNum", values_to = "platform", values_drop_na = TRUE)

unique_platforms <- videoGames %>%
  filter(!is.na(platform)) %>%
  mutate(platform = str_trim(platform),
         platform = str_to_lower(platform),
         platform = case_when(
           str_detect(platform, "xbox") ~ "Xbox",
           str_detect(platform, "playstation") ~ "PlayStation",
           str_detect(platform, "nintendo") ~ "Nintendo",
           platform == "pc" ~ "PC",
           TRUE ~ platform
         )) %>%
  distinct(platform) %>%
  nrow()

# > print(unique_platforms)
# [1] 6

#1 What games have 2 or more platforms? - view plot
multi_platform_games <- videoGames %>%
  group_by(title) %>%
  summarise(platform_count = n()) %>%
  filter(platform_count > 1)

ggplot(multi_platform_games, aes(x = reorder(title, platform_count), y = platform_count, fill = factor(platform_count))) +
  geom_bar(stat = "identity") +
  coord_flip() +
  guides(fill = "none") +
  labs(title = "Question 1", x = "Title", y = "Number of Platforms") +
  theme_minimal()


#2 What are the top three genres?  2D Platformer, Adventure, Compilation
all_genres <- videoGames %>%
  count(genre) %>%
  arrange(desc(n))

ggplot(all_genres, aes(x = reorder(genre, n), y = n, fill = genre)) +
  geom_col() +
  coord_flip() +
  guides(fill = "none") +
  labs(title = "Question 2", x = "Genre", y = "Count")

#3 Which platform has the LEAST games on the website? Meta Quest at 1
platform_counts <- videoGames %>%
  count(platform) %>%
  arrange(n)

ggplot(platform_counts, aes(x = reorder(platform, n), y = n, fill = platform)) +
  geom_col() +
  coord_flip() +
  guides(fill = "none") +
  labs(title = "Question 3", x = "Platform", y = "Number of Games")
  
#4 Which of the top 6 genres are found on at least 6 platforms? They all are found on 6+ platforms
top_6_genres <- videoGames %>%
  count(genre) %>%
  ungroup() %>%
  slice_max(n, n = 6)

games_on_top_platforms <- videoGames %>%
  filter(genre %in% top_6_genres$genre) %>%
  group_by(platform, genre) %>%
  summarise(game_count = n()) %>%
  ungroup()

ggplot(games_on_top_platforms, aes(x = reorder(genre, game_count), y = game_count, fill = genre)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~ platform, ncol = 3) +
  guides(fill = "none") +
  labs(title = "Question 4", x = "Genre", y = "Number of Games") +
  theme_minimal()

#5 Which genre is the most popular for users? 3 Way tie between Visual novel, top-down shoot'em-up, and point-and-click
user_popular_genre <- videoGames %>%
  filter(!is.na(genre), !is.na(userscore)) %>%
  group_by(genre) %>%
  summarize(mean_userscore = mean(userscore, na.rm = TRUE)) %>%
  arrange(desc(mean_userscore))

ggplot(user_popular_genre, aes(x = reorder(genre, mean_userscore), y = mean_userscore, fill = genre)) +
  geom_col() +
  coord_flip() +
  guides(fill = "none") +
  labs(title = "Question 5", x = "Genre", y = "Mean User Score") +
  theme_minimal()

#6 Which genre is the most popular among critics? Party
critic_popular_genre <- videoGames %>%
  group_by(genre) %>%
  summarize(mean_metascore = mean(metascore, na.rm = TRUE)) %>%
  arrange(desc(mean_metascore))

ggplot(critic_popular_genre, aes(x = reorder(genre, mean_metascore), y = mean_metascore, fill = genre)) +
  geom_col() +
  coord_flip() +
  guides(fill = "none") +
  labs(title = "Question 6", x = "Genre", y = "Mean Metascore")

