#Jonah Carpenter
# CSCI 444 - Lab 7

pacman::p_load(tidyverse, RColorBrewer, socviz, maps, mapproj, usmap, gridExtra, cowplot)

organRaw <- read_csv("data/Donor___State_of_Donation_Service_Area_by_Donation_Year,_Donor_Age,_Organ_2024.csv")
us_pop <- read_csv("data/state_pop.csv")

organ <- organRaw %>%
  pivot_longer(cols = Alabama:`Puerto Rico`, names_to = "State", values_to = "transplants") %>%
  mutate(region = tolower(State))

us_pop <- us_pop %>%
  mutate(region = tolower(state))

organ <- organ %>%
  left_join(us_pop, by = "region")

us_states <- us_map("states") %>%
  mutate(region = tolower(full))

# 1
totalTransplants <- organ %>%
  group_by(region) %>%
  summarize(transplants = sum(transplants, na.rm = TRUE)) %>%
  left_join(us_states, by = "region")

plot_usmap(data = totalTransplants, values = "transplants", color = "white") +
  scale_fill_continuous(type = "viridis", option = "plasma") +
  theme(legend.position = "right") +
  labs(title = "US Living Organ Donors", fill = "Transplants")

# California has the most transplants, and the grey states have either 0 or no data

top5 <- totalTransplants %>%
  slice_max(transplants, n = 5) %>%
  pull(full)

# [1] "California"   "Texas"        "Pennsylvania" "Florida"      "New York"

bottom5 <- totalTransplants %>%
  slice_min(transplants, n = 5) %>%
  pull(full)

# [1] "Delaware"      "Vermont"       "South Dakota"  "West Virginia" "New Hampshire"

# 2
state_abbreviations <- tibble(
  region = tolower(state.name),
  state_abb = tolower(state.abb)
)

state_abbreviations <- state_abbreviations %>%
  add_row(region = "district of columbia", state_abb = "dc") %>%
  add_row(region = "puerto rico", state_abb = "pr")

organ_with_abbr <- organ %>%
  left_join(state_abbreviations, by = "region") %>%
  mutate(region = state_abb)

organ_with_pop <- organ_with_abbr %>%
  left_join(us_pop, by = "region")

popTransplants <- popTransplants %>%
  rename(state = region)

plot_usmap(data = popTransplants, values = "per_capita", color = "white") +
  scale_fill_distiller(palette = "Spectral", direction = 1, na.value = "grey90") +
  theme(legend.position = "right") +
  labs(title = "US Organ Transplants by Population", fill = "Per Capita")

top5_per_capita_states <- popTransplants %>%
  slice_max(per_capita, n = 5) %>%
  select(state, per_capita)

bottom5_per_capita_states <- popTransplants %>%
  slice_min(per_capita, n = 5) %>%
  select(state, per_capita)

# MedStar Georgetown University Hospital

# > top5_per_capita_states
# 1 dc        0.116 
# 2 ks        0.0346
# 3 mn        0.0295
# 4 pa        0.0295
# 5 ma        0.0251

# > bottom5_per_capita_states
# 1 de       0.00173
# 2 wv       0.00203
# 3 nh       0.00277
# 4 vt       0.00283
# 5 sd       0.00373


# 3
organ_faceted_filtered <- organ %>%
  filter(Organ != "All Donors" & !is.na(Organ)) %>%
  group_by(region, Organ) %>%
  summarize(transplants = sum(transplants, na.rm = TRUE)) %>%
  left_join(us_states, by = "region")

plot_usmap(data = organ_faceted_filtered, values = "transplants", color = "white") +
  facet_wrap(~Organ) +
  scale_fill_distiller(palette = "Spectral") +
  theme(legend.position = "right") +
  labs(title = "US Organ Transplants by Organ", fill = "No. of Transplants")

organ_totals <- organ %>%
  filter(Organ != "All Donors") %>%
  group_by(Organ) %>%
  summarize(total_transplants = sum(transplants, na.rm = TRUE)) %>%
  arrange(desc(total_transplants))

most_transplants <- organ_totals %>% slice(1)
least_transplants <- organ_totals %>% slice(n())

# > most_transplants
# 1 Kidney           1834646

# > least_transplants
# 1 Intestine             15588

# 4
organ_list <- c("Kidney", "Liver", "Heart", "Pancreas", "Lung", "Intestine")

organ_faceted <- organ %>%
  group_by(Organ, region) %>%
  summarize(transplants = sum(transplants, na.rm = TRUE)) %>%
  left_join(us_states, by = "region")

top5_states_list <- lapply(organ_list, function(organ_type) {
  organ_data <- organ %>%
    filter(Organ == organ_type) %>%
    group_by(region) %>%
    summarize(transplants = sum(transplants, na.rm = TRUE)) %>%
    slice_max(transplants, n = 5, with_ties = FALSE) %>%
    arrange(desc(transplants))
  
  if (nrow(organ_data) > 0) {
    return(list(organ_type = organ_type, top_states = organ_data))
  } else {
    message(paste("No data available for", organ_type))
    return(NULL)
  }
})

top5_states_list <- Filter(Negate(is.null), top5_states_list)

for (entry in top5_states_list) {
  cat("\nTop 5 states for", entry$organ_type, "transplants:\n")
  print(entry$top_states)
}

plots <- lapply(organ_list, function(organ_type) {
  organ_data <- organ_faceted %>%
    filter(Organ == organ_type)
  
  if (nrow(organ_data) > 0) {
    plot_usmap(data = organ_data, values = "transplants", color = "white") +
      scale_fill_distiller(palette = "Spectral") +
      labs(title = paste("US", organ_type, "Transplants"))
  } else {
    message(paste("No data available for", organ_type))
    return(NULL)
  }
})

plots <- Filter(Negate(is.null), plots)
do.call(grid.arrange, c(plots, ncol = 2))

# Top 5 states for Kidney transplants:
# 1 california        194952
# 2 texas             143880
# 3 pennsylvania      118736
# 4 new york          111874
# 5 florida           102046

# Top 5 states for Liver transplants:
# 1 california        100214
# 2 texas              76930
# 3 pennsylvania       74761
# 4 florida            64200
# 5 new york           52162

# Top 5 states for Heart transplants:
# 1 california         44183
# 2 texas              36400
# 3 pennsylvania       25408
# 4 florida            24844
# 5 new york           17560

# Top 5 states for Pancreas transplants:
# 1 california         19264
# 2 pennsylvania       15976
# 3 florida            12820
# 4 texas              12640
# 5 illinois           11104

# Top 5 states for Lung transplants:
# 1 california         25240
# 2 texas              20988
# 3 pennsylvania       14776
# 4 florida            13620
# 5 ohio                9256

# Top 5 states for Intestine transplants:
# 1 florida             1868
# 2 pennsylvania        1052
# 3 texas                952
# 4 indiana              880
# 5 tennessee            788

# 5
kidneyByYear <- organ %>%
  filter(Organ == "Kidney", year != "0") %>%
  group_by(year, region) %>%
  summarize(transplants = sum(transplants, na.rm = TRUE)) %>%
  left_join(us_states, by = "region")

ggplot(kidneyByYear) +
  geom_sf(aes(geometry = geom, fill = transplants), color = "white") +
  scale_fill_distiller(palette = "Spectral") +
  facet_wrap(~ year, ncol = 5) +
  labs(title = "US Kidney Transplants by Year", fill = "No. of Transplants") +
  theme_void() +
  theme(legend.position = "right", strip.text = element_text(size = 8))

#they have steadily increased over time and from 23-24 have seen a slight decrease