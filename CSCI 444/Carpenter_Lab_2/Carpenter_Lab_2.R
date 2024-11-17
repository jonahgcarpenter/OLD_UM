library(tidyverse)
library(fivethirtyeight)

grads <- college_recent_grads
glimpse(grads)


#Which major has the lowest unemployment rate? Which has the highest?
grads <- grads %>% 
  arrange(unemployment_rate) %>% 
  select(rank, major, unemployment_rate)

grads_v1 <- grads %>%
  arrange(unemployment_rate) %>%
  select(rank, major, unemployment_rate) %>%
  mutate(unemployment_rate = round(unemployment_rate, digits = 3))

grads_v2 <- grads %>%
  arrange(unemployment_rate) %>%
  select(rank, major, unemployment_rate) %>%
  mutate(unemployment_rate = sprintf("%0.3f%%", unemployment_rate * 100))

grads_v3 <- grads %>%
  arrange(unemployment_rate) %>%
  select(rank, major, unemployment_rate)

options(digits = 3)
grads_v3 %>%
  head(10)

top_10_unemployment <- grads %>% head(10)
bottom_10_unemployment <- grads %>% tail(10)

#Top10 = Mathematics And Computer Science, Military Technologies, Botany, Soil Science, Educational Administration And Supervision, Engineering Mechanics Physics And Science, Court Reporting, Mathematics Teacher Education, Petroleum Engineering, General Agriculture
#Bottom10 = Architecture, Geography, Computer Programming And Data Processing, Mining And Mineral Engineering, Communication Technologies, Public Policy, Clinical Psychology, Computer Networking And Telecommunications, Public Administration, Nuclear Engineering

#The nuclear engineering being the bottom of unemployment surprised me given the level of work required


#Which major has the highest percentage of women? Which has the lowest? 
high_women_grads <- college_recent_grads %>% 
  mutate(prop_women = women / total) %>% 
  arrange(desc(prop_women)) %>% 
  select(major) %>%
  head(10)

#top10 = Early Childhood Education, Communication Disorders Sciences And Services, Medical Assisting Services, Elementary Education, Family And Consumer Sciences, Special Needs Education, Human Services And Community Organization, Social Work, Nursing, Miscellaneous Health Medical Professions

low_women_grads <- college_recent_grads %>% 
  mutate(prop_women = women / total) %>% 
  arrange(prop_women) %>% 
  select(major) %>%
  head(10)

#bottom10 = Military Technologies, Mechanical Engineering Related Technologies, Construction Services, Mining And Mineral Engineering, Naval Architecture And Marine Engineering, Mechanical Engineering, Petroleum Engineering, Transportation Sciences And Technologies, Forestry, Aerospace Engineering

#women typically don't go into fields of stem or hard labor


#How do the distributions of median income compare across major categories?

#Because median is not affected by extreme outliers in the data

college_recent_grads %>%
  ggplot(mapping = aes(x = median, fill = major_category)) +
  geom_histogram(binwidth = 5000)

#chose 5000 just for a cleaner plot

college_recent_grads %>%
  summarize(min = min(median), max = max(median),
            mean = mean(median), med = median(median),
            sd = sd(median),
            q1 = quantile(median, probs = 0.25),
            q3 = quantile(median, probs = 0.75))

#median is better because it is closer to the center of the data

college_recent_grads %>%
  ggplot(mapping = aes(x = median, fill = major_category)) +
  geom_histogram(binwidth = 5000) +
  facet_wrap( ~ major_category, ncol = 4)

#from this plot we can see engineering has the highest, and psychology and social Work has the lowest

college_recent_grads %>%
  group_by(major_category) %>%
  summarise(median_income = median(median)) %>%
  arrange(median_income)


#How do the distributions of median income compare across major categories? 
women_grads_median <- college_recent_grads %>%
  select(major, major_category, women, total, median) %>%
  mutate(prop_women = women / total)

NA_values <- women_grads_median %>%
  filter(is.na(prop_women))

#Food Science has the NA value

women_grads_median <- women_grads_median %>%
  na.omit()

correlation <- cor(women_grads_median$prop_women, women_grads_median$median)
#-0.618689751213045

#defined in ggplot because then they are global meaning the entire plot

num_categories <- n_distinct(women_grads_median$major_category)

color_names <- c("red", "blue", "green", "orange", "purple", "pink", "yellow", "brown", 
                 "cyan", "magenta", "gold", "darkgreen", "darkblue", "salmon", "gray", "turquoise")

women_grads_median %>%
  ggplot(mapping = aes(x = prop_women, y = median, color = major_category)) +
  geom_point() +
  scale_color_manual(values = color_names) +  # Apply the distinct colors to the plot
  ggtitle("Scatterplot of Median Income vs Proportion of Women by Major Category") +
  xlab("Proportion of Women") +
  ylab("Median Income")

#the data does not surprise me, it shows male dominate fields (STEM) have higher incomes when fields that are predominantly female (health, education, and social work) are typically lower paying