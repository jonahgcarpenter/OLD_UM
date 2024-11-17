#Jonah Carpenter
#Unit 7 - Activity B

library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)

drugdeaths <- read.delim("data/drugdeaths.txt", sep = "^")

#Selected
drugdeaths_selected <- drugdeaths %>%
  select(Sex, Age, Heroin, Cocaine, Fentanyl, Oxycodone, Oxymorphone, EtOH, Hydro.codeine, Benzodiazepine, Methadone, Amphet, Tramad)

#Long
drugdeaths_long <- drugdeaths_selected %>%
  mutate(across(c(Heroin, Cocaine, Fentanyl, Oxycodone, Oxymorphone, EtOH, Hydro.codeine, Benzodiazepine, Methadone, Amphet, Tramad), 
                ~ str_trim(.))) %>%
  mutate(across(c(Heroin, Cocaine, Fentanyl, Oxycodone, Oxymorphone, EtOH, Hydro.codeine, Benzodiazepine, Methadone, Amphet, Tramad), 
                ~ ifelse(. == "Y", "Y", NA))) %>%
  pivot_longer(cols = Heroin:Tramad, names_to = "Type", values_to = "Result", values_drop_na = TRUE) %>%
  select(Type, Result)

#Count
opioid_deaths_count <- drugdeaths_long %>%
  filter(Result == "Y") %>%
  count(Type)

#Plot
ggplot(opioid_deaths_count, aes(x = reorder(Type, n), y = n, fill = Type)) +
  geom_col() +
  labs(x = "Type of Opioid", y = "Number of Deaths", title = "Opioid Deaths by Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        legend.position = "none") +
  scale_fill_brewer(palette = "Set3")
