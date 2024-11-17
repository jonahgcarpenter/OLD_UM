# ######### PART A
#Jonah Carpenter
#Lab5_a

library(tidyverse)
library(rvest)
library(stringr)

page1 <- read_html("https://www.metacritic.com/browse/game/all/all/current-year/metascore/?page=1")
page2 <- read_html("https://www.metacritic.com/browse/game/all/all/current-year/metascore/?page=2")
page3 <- read_html("https://www.metacritic.com/browse/game/all/all/current-year/metascore/?page=3")
page4 <- read_html("https://www.metacritic.com/browse/game/all/all/current-year/metascore/?page=4")
pages <- list(page1, page2, page3, page4)

xml_structure(page1)

title1 <- page1 %>% html_nodes("h3 span:nth-of-type(2)") %>% html_text(trim = TRUE)
title2 <- page2 %>% html_nodes("h3 span:nth-of-type(2)") %>% html_text(trim = TRUE)
title3 <- page3 %>% html_nodes("h3 span:nth-of-type(2)") %>% html_text(trim = TRUE)
title4 <- page4 %>% html_nodes("h3 span:nth-of-type(2)") %>% html_text(trim = TRUE)
titles <- c(title1, title2, title3, title4)

url1 <- page1 %>% html_nodes(".c-finderProductCard a") %>% html_attr("href")
url2 <- page2 %>% html_nodes(".c-finderProductCard a") %>% html_attr("href")
url3 <- page3 %>% html_nodes(".c-finderProductCard a") %>% html_attr("href")
url4 <- page4 %>% html_nodes(".c-finderProductCard a") %>% html_attr("href")
urls <- c(url1, url2, url3, url4)

titles_clean <- str_trim(titles)
urls_clean <- paste0("https://www.metacritic.com", urls)

url_page <- read_html(urls_clean[1])

scores <- url_page %>% 
  html_nodes("span[data-v-e408cafe]") %>% 
  html_text() %>% 
  as.numeric()

one_metascore <- scores[1]
one_userscore <- scores[2]

one_platform <- url_page %>% 
  html_nodes(".c-gameDetails_Platforms ul") %>%
  html_text() %>% 
  str_squish() %>%
  str_split("\n") %>%
  unlist() %>%
  str_trim() %>%
  paste(collapse = ", ")

one_genre <- url_page %>% 
  html_nodes(xpath = "//span[text()='Genres:']/following-sibling::ul//span[@class='c-globalButton_label']") %>%
  html_text() %>% 
  str_trim()

metascore <- c()
userscore <- c()
platform <- c()
genre <- c()

for (oneURL in urls_clean) {
  url_page <- read_html(oneURL)
  
  scores <- url_page %>% 
    html_nodes("span[data-v-e408cafe]") %>% 
    html_text() %>%
    str_trim() %>%
    as.numeric()
  
  if (length(scores) >= 2) {
    metascore <- c(metascore, scores[1])
    userscore <- c(userscore, scores[2])
  } else {
    metascore <- c(metascore, NA)
    userscore <- c(userscore, NA)
  }
  
  platforms_data <- url_page %>% 
    html_nodes(".c-gameDetails_Platforms ul") %>%
    html_text() %>% 
    str_squish() %>%
    str_split("\n") %>%
    unlist() %>%
    str_trim() %>%
    paste(collapse = ", ")
  
  platform <- c(platform, platforms_data)
  
  genre_data <- url_page %>% 
    html_nodes(xpath = "//span[text()='Genres:']/following-sibling::ul//span[@class='c-globalButton_label']") %>%
    html_text() %>% 
    str_trim() %>%
    paste(collapse = ", ")
  
  genre <- c(genre, genre_data)
}

videoGames_2024 <- tibble(
  title = titles_clean,
  metascore = metascore,
  userscore = userscore,
  platforms = platform,
  genre = genre
)

if (!dir.exists("data")) {
  dir.create("data")
}

write_csv(videoGames_2024, "data/metacritics_2024.csv")

videoGames <- read_csv("data/metacritics_2024.csv")

na_title <- videoGames %>% filter(is.na(title))
na_metascore <- videoGames %>% filter(is.na(metascore))
na_userscore <- videoGames %>% filter(is.na(userscore))
na_platform <- videoGames %>% filter(is.na(platforms))
na_genre <- videoGames %>% filter(is.na(genre))

# All 8 of these games had a NA for userscore: Metaphor: ReFantazio, The Crimson Diamond, Dragon Ball: Sparking! Zero, ROBOBEAT, Samurai Warriors 4 DX, Hidden Through Time 2: Myths & Magic, Vampire Therapist, Earth Defense Force: World Brothers 2

ggplot(videoGames, aes(x = metascore, y = userscore)) + 
  geom_point() + 
  labs(title = "Metascore vs Userscore", x = "Metascore", y = "Userscore")

correlation <- cor(videoGames$metascore, videoGames$userscore, use = "complete.obs")
cat("Correlation coefficient:", correlation, "\n")

# Correlation coefficient: 0.2879899, no because higher rated games usually have better user reviews as well.

outliers <- videoGames %>% 
  filter(userscore >= 8, metascore <= 81, !is.na(metascore), !is.na(userscore))

#   title                           metascore userscore platforms     genre
#<chr>                               <dbl>     <dbl> <chr>         <chr>
#  1 Snufkin: Melody of Moominvalley        81       8.7 PC Nintendo … Adve…
#2 Black Myth: Wukong                     81       8.3 PC PlayStati… Acti…
#3 Freedom Planet 2                       81       8   PC Nintendo … 2D P…

#sometimes critics hate something but the general population likes it.
