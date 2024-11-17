# Jonah Carpenter
# Fall 2024 CSCI 444
# Homework 1
# Myers-Briggs Personality Test

library(tidyverse)
library(readxl)

setwd("data")

names <- c("Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Q20", "Q21", "Q22", "Q23", "Q24", "Q25", "Q26", "Q27", "Q28", "Q29", "Q30", "Q31", "Q32", "Q33", "Q34", "Q35", "Q36", "Q37", "Q38", "Q39", "Q40", "Q41", "Q42", "Q43", "Q44", "Q45", "Q46", "Q47", "Q48", "Q49", "Q50", "Q51", "Q52", "Q53", "Q54", "Q55", "Q56", "Q57", "Q58", "Q59", "Q60", "Q61", "Q62", "Q63", "Q64", "Q65", "Q66", "Q67", "Q68", "Q69", "Q70", "EI", "SN", "TF", "JP", "Personality_Type")

files <- list.files(pattern = "\\.xlsx$")

data <- map_dfr(files, ~ read_excel(.x, col_names = FALSE))

colnames(data) <- names

data[, 1:70] <- data[, 1:70] %>% replace(is.na(.), "A")

ggplot(data, aes(x = Personality_Type, fill = Personality_Type)) + 
  geom_bar() +
  labs(title = "Personality Types in Class", x = "Personality Type", y = "Count") +
  theme_minimal()

responses <- data %>%
  pivot_longer(Q1:Q70, names_to="question", values_to="answer") %>%
  select(question, answer)

responses_count <- responses %>%
  group_by(question, answer) %>%
  summarise(n = n(), .groups = 'drop')

responses_alt <- responses %>%
  mutate(rank = as.numeric(str_sub(question, 2))) %>%  
  group_by(question, answer, rank) %>%  
  summarise(n = n(), .groups = 'drop') %>%  
  arrange(rank, answer) 

ggplot(responses_alt, aes(x = answer, y = n, fill = answer)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ rank, ncol = 7) +
  labs(title = "Myers Briggs Results Ordered by Rank", subtitle = "Jonah Carpenter") +
  theme_minimal()

minority <- responses_count %>%
  filter(n <= min(.$n) + 1)

majority <- responses_count %>%
  filter(n >= max(.$n) - 1)



