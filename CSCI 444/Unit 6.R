library(dplyr)
library(tidyr)
library(reshape)

#A
ff <- french_fries %>%
  arrange(time, subject) %>%
  mutate(Avg = rowMeans(select(., potato, buttery, grassy, rancid, painty), na.rm = TRUE)) %>%
  print()

#B
ff_summary <- ff %>%
  group_by(subject, treatment, time) %>%
  summarize(
    potatoAvg = mean(potato, na.rm = TRUE),
    butteryAvg = mean(buttery, na.rm = TRUE),
    grassyAvg = mean(grassy, na.rm = TRUE),
    rancidAvg = mean(rancid, na.rm = TRUE),
    paintyAvg = mean(painty, na.rm = TRUE)
  ) %>%
  print()
