# Jonah Carpenter
# Fall 24 CSCI 444
# Homework 3
# Breweries in the US

pacman::p_load(tidyverse, rvest, robotstxt, xml2, stringr)

paths_allowed("https://www.ratebeer.com/")

scrape_category <- function(category, include_groups = FALSE) {
  url <- paste0("https://www.ratebeer.com/", category, "/unitedstates/24/213/")
  
  page <- read_html(url)
  
  names <- c()
  cities <- c()
  beer_counts <- c()
  urls <- c()
  statuses <- c()
  established <- c()
  groups <- c()
  
  status_list <- c("active")
  
  if (category == "breweries") {
    status_list <- c("active", "closed")
  }
  
  for (status in status_list) {
    page_section <- page %>% xml_find_all(paste0("//div[@id='tabs']//div[@id='", status, "']"))
    
    if (is_empty(page_section)) next
    
    name_data <- page_section %>%
      xml_find_all(".//a[contains(@href, '/brewers/')]") %>%
      xml_text(trim = TRUE) %>%
      paste0("_Brewery")
    
    if (status == "active") {
      city_data <- page_section %>%
        xml_find_all(".//a[@class='filter']") %>%
        xml_text(trim = TRUE)
    } else {
      city_data <- page_section %>%
        xml_find_all(".//span[@style='font-size:11px;color:#b2b2b2;']") %>%
        xml_text(trim = TRUE)
    }
    
    beer_count_data <- page_section %>%
      xml_find_all(".//td[i[@style='color:#ccc;']]") %>%
      xml_text(trim = TRUE) %>%
      str_trim() %>%
      str_remove_all("[^0-9]") %>%
      as.numeric()
    
    url_data <- page_section %>%
      xml_find_all(".//a[contains(@href, '/brewers/')]") %>%
      xml_attr("href") %>%
      paste0("https://www.ratebeer.com", .)
    
    established_data <- page_section %>%
      xml_find_all(".//td[@style='color:#ccc;text-align:right;'][1]") %>%
      xml_text(trim = TRUE) %>%
      as.numeric()
    
    status_label <- ifelse(status == "active", "Open", "Closed")
    status_data <- rep(status_label, length(name_data))
    
    if (include_groups) {
      group_data <- page_section %>%
        xml_find_all(".//td[@class='hidden-xs hidden-sm']") %>%
        xml_text(trim = TRUE)
      groups <- c(groups, group_data)
    }
    
    names <- c(names, name_data)
    cities <- c(cities, city_data)
    beer_counts <- c(beer_counts, beer_count_data)
    urls <- c(urls, url_data)
    statuses <- c(statuses, status_data)
    established <- c(established, established_data)
  }
  
  if (length(names) == 0) {
    names <- NA_character_
    cities <- NA_character_
    beer_counts <- NA_real_
    urls <- NA_character_
    statuses <- NA_character_
    established <- NA_real_
    if (include_groups) {
      groups <- NA_character_
    }
  }
  
  if (include_groups) {
    return(data.frame(
      names = names,
      cities = cities,
      beer_counts = beer_counts,
      urls = urls,
      statuses = statuses,
      established = established,
      groups = groups,
      stringsAsFactors = FALSE
    ))
  } else {
    return(data.frame(
      names = names,
      cities = cities,
      beer_counts = beer_counts,
      urls = urls,
      statuses = statuses,
      established = established,
      stringsAsFactors = FALSE
    ))
  }
}
msBreweries <- scrape_category("breweries")
msBreweries_groups <- scrape_category("breweries", include_groups = TRUE)
msMeaderies <- scrape_category("mead")
msCideries <- scrape_category("cider")
msSake <- scrape_category("sake")

usBreweries <- usBreweries %>%
  filter(!is.na(name) & name != "")
usBreweries_groups <- usBreweries_groups %>%
  filter(!is.na(name) & name != "")

write.csv(msBreweries, "msBreweries.csv", row.names = FALSE)
write.csv(msBreweries_groups, "msBreweries_groups.csv", row.names = FALSE)
write.csv(msMeaderies, "msMeaderies.csv", row.names = FALSE)
write.csv(msCideries, "msCideries.csv", row.names = FALSE)
write.csv(msSake, "msSake.csv", row.names = FALSE)

ms_2024 <- bind_rows(msBreweries, msMeaderies, msCideries)
write.csv(ms, "ms_2024.csv", row.names = FALSE)

msBreweries <- read.csv("msBreweries.csv")
msBreweries_groups <- read.csv("msBreweries_groups.csv")
msMeaderies <- read.csv("msMeaderies.csv")
msCideries <- read.csv("msCideries.csv")
msSake <- read.csv("msSake.csv")
ms_2024 <- read.csv("ms_2024.csv")

# MS
# 1
# Which type of brewery is the most popular in Mississippi: breweries, meaderies, cideries or sake producers?
# Brewery
ms_2024$type <- case_when(
  grepl("_Brewery$", ms_2024$names) ~ "Brewery",
  grepl("_Meadery$", ms_2024$names) ~ "Meadery",
  grepl("_Cidery$", ms_2024$names) ~ "Cidery",
  grepl("_Sake$", ms_2024$names) ~ "Sake"
)

brewery_counts <- ms_2024 %>%
  group_by(type) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(brewery_counts, aes(x = reorder(type, -count), y = count, fill = type)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip the axes
  labs(title = "Mississippi Breweries by Type", fill = "Type") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "top"
  )

# 2
# Which group of breweries is the most popular?
# MicroBrewery
brewery_group_counts <- msBreweries_groups %>%
  group_by(groups) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(brewery_group_counts, aes(x = reorder(groups, -count), y = count, fill = groups)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip the axes
  labs(title = "Mississippi Brewery Groups", fill = "Brewery") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "top"
  )

# 3
# Looking at the years 2003-2024, which type of brewery has the most openings (i.e., established)? What three years had the most openings? What year were meaderies included? What year were cideries included?
# Breweries, 2022/2020/and 2017, 2017 for Cider, 2018 for Mead
ms_filtered <- ms_2024 %>%
  filter(established >= 2003 & established <= 2024) %>%
  drop_na(established)

brewery_year_counts <- ms_filtered %>%
  group_by(established, type) %>%
  summarise(count = n()) %>%
  ungroup()

ggplot(brewery_year_counts, aes(x = factor(established), y = count, fill = type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Mississippi Breweries, Meaderies, Cideries and Sake Producers by Year",
    fill = "Breweries",
    x = "Year Established",
    y = "Number"
  ) +
  theme_minimal() +
  scale_x_discrete(limits = 2003:2024)

# US
# Why is Wyoming 51 and not 50? What is the additional entry’s name and what is its number?
# 9/district-of-columbia/

states_data <- read_csv("data/states.csv")
states <- states_data$name %>%
  tolower() %>%
  str_replace_all(" ", "-") %>%
  str_replace_all("[.,]", "")
states <- sort(states)

urlTypes <- c("breweries", "mead", "cider", "sake")
nameTypes <- c("Brewery", "Meadery", "Cidery", "Sake Producer")

scrape_all_states <- function(include_groups = FALSE) {
  names <- c()
  cities <- c()
  beer_counts <- c()
  urls <- c()
  statuses <- c()
  established <- c()
  groups <- c()
  
  for (i in 1:51) {  
    for (j in 1:length(urlTypes)) {
      url <- paste0("https://www.ratebeer.com/", urlTypes[j], "/unitedstates/", i, "/213/")
      print(paste("Scraping:", url))
      
      Sys.sleep(2)
      
      page <- tryCatch(read_html(url), error = function(e) NULL)
      if (is.null(page)) {
        print(paste("Failed to load page for", states[i], urlTypes[j]))
        next
      }
      
      status_list <- if (urlTypes[j] == "breweries") c("active", "closed") else c("active")
      
      for (status in status_list) {
        page_section <- page %>% xml_find_all(paste0("//div[@id='tabs']//div[@id='", status, "']"))
        
        if (is_empty(page_section)) {
          print(paste("No data for", status, "status in", states[i]))
          next
        }
        
        name_data <- page_section %>%
          xml_find_all(".//a[contains(@href, '/brewers/')]") %>%
          xml_text(trim = TRUE) %>%
          paste0("_", nameTypes[j])
        
        city_data <- if (status == "active") {
          page_section %>%
            xml_find_all(".//a[@class='filter']") %>%
            html_text(trim = TRUE) %>%
            paste0("_", states[i], "_Opened")
        } else {
          page_section %>%
            xml_find_all(".//span[@style='font-size:11px;color:#b2b2b2;']") %>%
            html_text(trim = TRUE) %>%
            paste0("_", states[i], "_Closed")
        }
        
        beer_count_data <- page_section %>%
          xml_find_all(".//td[i[@style='color:#ccc;']]") %>%
          html_text(trim = TRUE) %>%
          str_trim() %>%
          str_remove_all("[^0-9]") %>%
          as.numeric()
        
        url_data <- page_section %>%
          xml_find_all(".//a[contains(@href, '/brewers/')]") %>%
          xml_attr("href") %>%
          paste0("https://www.ratebeer.com", .)
        
        established_data <- page_section %>%
          xml_find_all(".//td[@style='color:#ccc;text-align:right;'][1]") %>%
          html_text(trim = TRUE) %>%
          as.numeric()
        
        status_label <- ifelse(status == "active", "Open", "Closed")
        status_data <- rep(status_label, length(name_data))
        
        if (include_groups && urlTypes[j] == "breweries") {
          group_data <- page_section %>%
            xml_find_all(".//td[@class='hidden-xs hidden-sm']") %>%
            html_text(trim = TRUE)
          groups <- c(groups, group_data)
        } else {
          group_data <- rep(NA, length(name_data))
        }
        
        names <- c(names, name_data)
        cities <- c(cities, city_data)
        beer_counts <- c(beer_counts, beer_count_data)
        urls <- c(urls, url_data)
        statuses <- c(statuses, status_data)
        established <- c(established, established_data)
      }
    }
  }
  
  max_length <- max(length(names), length(cities), length(beer_counts), length(urls), length(statuses), length(established), length(groups))
  names <- c(names, rep(NA, max_length - length(names)))
  cities <- c(cities, rep(NA, max_length - length(cities)))
  beer_counts <- c(beer_counts, rep(NA, max_length - length(beer_counts)))
  urls <- c(urls, rep(NA, max_length - length(urls)))
  statuses <- c(statuses, rep(NA, max_length - length(statuses)))
  established <- c(established, rep(NA, max_length - length(established)))
  groups <- c(groups, rep(NA, max_length - length(groups)))
  
  if (include_groups) {
    return(data.frame(
      names = names,
      cities = cities,
      beer_counts = beer_counts,
      urls = urls,
      statuses = statuses,
      established = established,
      groups = groups,
      stringsAsFactors = FALSE
    ))
  } else {
    return(data.frame(
      names = names,
      cities = cities,
      beer_counts = beer_counts,
      urls = urls,
      statuses = statuses,
      established = established,
      stringsAsFactors = FALSE
    ))
  }
}

usBreweries <- scrape_all_states(include_groups = FALSE)
write.csv(usBreweries, "data/usBreweries_2024.csv", row.names = FALSE)

usBreweries <- read_csv("data/usBreweries_2024.csv") %>%
  separate(names, into = c("name", "type"), sep = "_") %>%
  separate(cities, into = c("city", "state", "status"), sep = "_")

usBreweries_groups <- scrape_all_states(include_groups = TRUE)
write.csv(usBreweries_groups, "data/usBreweries_groups_2024.csv", row.names = FALSE)

usBreweries_groups <- read_csv("data/usBreweries_groups_2024.csv") %>%
  separate(names, into = c("name", "type"), sep = "_") %>%
  separate(cities, into = c("city", "state", "status"), sep = "_")

# How many breweries are not associated with cities?
no_city_entries <- usBreweries %>%
  filter(city == "" | is.na(city))
view(no_city_entries)

# 8
# Which type of brewery has had the most success? Which type of brewery has been hardest hit by closures?
# breweries for both
brewery_summary <- usBreweries %>%
  group_by(type, status) %>%
  summarise(count = n()) %>%
  ungroup()

ggplot(brewery_summary, aes(x = type, y = count, fill = type)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ status, scales = "free_y") +
  labs(
    title = "US Breweries by Type",
    fill = "Brewery",
    x = "Brewery Type",
    y = "Number"
  ) +
  theme_minimal() +
  theme(legend.position = "top")

# 9
# Which group of breweries is the most popular? Which group is zero?
# Micro, Commissioner
brewery_groups_summary <- usBreweries_groups %>%
  filter(!is.na(groups)) %>%
  group_by(groups) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(brewery_groups_summary, aes(x = reorder(groups, -count), y = count, fill = groups)) +
  geom_bar(stat = "identity") +
  coord_flip() +  # Flip the axes
  labs(
    title = "US Brewery Groups",
    fill = "Brewery"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "top"
  )

# 10
# Which states do not have any opened/active meaderies, cideries, or sake producers?
# "kentucky" "ohio" 
opened_specialty_breweries <- usBreweries %>%
  filter(status == "Opened", type %in% c("Meadery", "Cidery", "Sake Producer")) %>%
  group_by(state, type) %>%
  summarise(count = n(), .groups = "drop")

ggplot(opened_specialty_breweries, aes(x = type, y = count, fill = type)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ state, scales = "free_y") +
  labs(
    title = "US Meaderies, Cideries and Sake Producers",
    fill = "Brewery",
    x = "Brewery Type",
    y = "Number"
  ) +
  theme_minimal() +
  theme(legend.position = "top")

all_states <- unique(usBreweries$state)
states_without_specialty_breweries <- setdiff(all_states, opened_specialty_breweries$state)

# 11
# Which states, including the count, have meaderies? Which states, including the count, have cideries? Which states, including the count, have sake producers?
opened_specialty_breweries <- usBreweries %>%
  filter(status == "Opened", type %in% c("Meadery", "Cidery", "Sake Producer"))

meaderies_count <- opened_specialty_breweries %>%
  filter(type == "Meadery") %>%
  count(state, name = "meadery_count") %>%
  arrange(state)

cideries_count <- opened_specialty_breweries %>%
  filter(type == "Cidery") %>%
  count(state, name = "cidery_count") %>%
  arrange(state)

sake_producers_count <- opened_specialty_breweries %>%
  filter(type == "Sake Producer") %>%
  count(state, name = "sake_count") %>%
  arrange(state)

# > print(meaderies_count, n = Inf)
# state                meadery_count
# 1 alabama                          1
# 2 alaska                           5
# 3 arizona                          3
# 4 california                      19
# 5 colorado                        17
# 6 connecticut                      2
# 7 delaware                         2
# 8 district-of-columbia            15
# 9 florida                          9
# 10 georgia                          3
# 11 hawaii                           5
# 12 idaho                            8
# 13 illinois                        11
# 14 indiana                          4
# 15 iowa                             2
# 16 kansas                           5
# 17 louisiana                        6
# 18 maine                            8
# 19 maryland                         3
# 20 massachusetts                   21
# 21 michigan                         5
# 22 minnesota                        1
# 23 mississippi                      4
# 24 missouri                         2
# 25 nebraska                         2
# 26 nevada                           5
# 27 new-hampshire                    4
# 28 new-mexico                      17
# 29 new-york                        15
# 30 north-carolina                   3
# 31 north-dakota                    14
# 32 oklahoma                        15
# 33 oregon                          21
# 34 rhode-island                     1
# 35 south-dakota                     3
# 36 tennessee                       17
# 37 texas                            1
# 38 utah                             6
# 39 vermont                         15
# 40 virginia                        23
# 41 west-virginia                    6
# 42 wisconsin                       13
# 43 wyoming                          3

# > print(cideries_count, n = Inf)
# state                cidery_count
# 1 alaska                          2
# 2 arizona                         4
# 3 arkansas                        1
# 4 california                     87
# 5 colorado                       29
# 6 connecticut                    10
# 7 delaware                        1
# 8 district-of-columbia            4
# 9 florida                         4
# 10 georgia                         1
# 11 hawaii                          7
# 12 idaho                          13
# 13 illinois                       21
# 14 indiana                        11
# 15 iowa                            3
# 16 kansas                          2
# 17 louisiana                      26
# 18 maine                           6
# 19 maryland                       18
# 20 massachusetts                  47
# 21 michigan                       21
# 22 minnesota                       1
# 23 mississippi                     4
# 24 missouri                        7
# 25 montana                         4
# 26 nevada                         11
# 27 new-hampshire                   4
# 28 new-jersey                      5
# 29 new-mexico                     81
# 30 new-york                       20
# 31 north-carolina                  3
# 32 north-dakota                    9
# 33 oklahoma                       61
# 34 oregon                         55
# 35 pennsylvania                    3
# 36 rhode-island                    2
# 37 south-carolina                  2
# 38 south-dakota                    7
# 39 tennessee                      11
# 40 texas                           3
# 41 utah                           27
# 42 vermont                        37
# 43 virginia                       64
# 44 washington                      1
# 45 west-virginia                   4
# 46 wisconsin                      55
# 47 wyoming                         1

# > print(sake_producers_count, n = Inf)
# state                sake_count
# 1 arizona                       1
# 2 california                   10
# 3 colorado                      1
# 4 district-of-columbia          1
# 5 illinois                      1
# 6 kansas                        1
# 7 louisiana                     1
# 8 maryland                      1
# 9 massachusetts                 1
# 10 michigan                      1
# 11 new-mexico                    2
# 12 new-york                      1
# 13 oklahoma                      1
# 14 south-dakota                  1
# 15 tennessee                     1
# 16 vermont                       1

# 12
# At what year would you say the number of breweries started to increase in the US (HINT: the year should be before 2000)? What about meaderies? What about cideries? What about sake producers?
# 1996, Mead in 2012, Cider in 2003, Sake in 2013
establishment_trends <- usBreweries %>%
  filter(!is.na(established) & established > 0) %>%
  group_by(established, type) %>%
  summarise(count = n(), .groups = 'drop')

ggplot(establishment_trends, aes(x = established, y = count, color = type)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "US Establishment of Breweries",
    color = "Brewery",
    x = "Year",
    y = "Number Established"
  ) +
  theme_minimal() +
  theme(legend.position = "top")

# 13
# What years are the peakgrowths (look for 2 of the 3 to peak)? Why do you think these peak growths occurred?
# 2016-2018 were peak years, more demand
recent_establishment_trends <- establishment_trends %>%
  filter(established >= 2004)

ggplot(recent_establishment_trends, aes(x = established, y = count, color = type)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "US Establishment of Breweries",
    color = "Brewery",
    x = "Year",
    y = "Number Established"
  ) +
  theme_minimal() +
  theme(legend.position = "top")

# 14
# For each type of brewery (i.e., brewery, meadery, cidery and sake producer), what is the top state? 
#Brew = California, Cider = California, Mead = Virginia, Sake = California
breweries_by_state_type <- usBreweries %>%
  filter(!is.na(type)) %>%
  group_by(state, type) %>%
  summarise(count = n(), .groups = "drop")

ggplot(breweries_by_state_type, aes(x = count, y = reorder_within(state, count, type), fill = type)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ type, scales = "free") +
  scale_y_reordered() +
  labs(
    title = "Number of Breweries by State"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_blank(),
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 7),
    strip.text = element_text(size = 10),
    legend.position = "none"
  )

# 15
# What states are in the top 5 for each of the four types of Breweries?
top_5_breweries <- usBreweries %>%
  filter(!is.na(type)) %>%
  group_by(state, type) %>%
  summarise(count = n(), .groups = "drop") %>%
  group_by(type) %>%
  slice_max(order_by = count, n = 5) %>%
  ungroup()

ggplot(top_5_breweries, aes(x = count, y = reorder_within(state, count, type), fill = type)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ type, scales = "free") +
  scale_y_reordered() +
  labs(
    title = "US Establishment of Breweries",
    fill = "Number of US Breweries by State",
    x = "Brewery Count"
  ) +
  theme_minimal() +
  theme(
    axis.title.y = element_blank(),
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 7),
    strip.text = element_text(size = 10),
    legend.position = "top"
  )

# First, how many pounds of honey are needed to produce a gallon of mead? Now, what are the top 5 state that produce mead? Of these, which states ARE in the top 10 honey producing states? What was their 2021 production of honey in pounds?
# 3 pounds per, California is the only one with 8.2 Million pounds of honey

# How many pounds of apples are needed to make a gallon of cider? What are the top 5 states that produce cider? Of these, which state IS NOT one of the top 7 apple producing states? How many pounds of apples did this state harvest in 2021? Let's compare - how many pounds of apples did the top apple producing state harvest in 2021? What number is this state on the top 5 cidery states?
# 16 pounds per, NM harvested 7 million pounds, whereas the top state was Washington at 6.4 billion pounds and is not listed for cider

# How many pounds of rice are needed to make ~2 gallons of sake? What are the top 5 states that produce sake? Of these, which states ARE in the top 6 rice producing states (you may use 2020 data)? What was their rice production in pounds?
# 10-12 pounds per, California harvested 4.4 million tons