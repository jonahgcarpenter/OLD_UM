#Jonah Carpenter HW1

library(tidyverse)
library(RColorBrewer)

data_path <- "ff_data"

ff <- map_dfr(list.files(data_path, pattern = "*.csv", full.names = TRUE), 
              ~ read_csv(.x, col_names = FALSE))

colnames(ff) <- c("subject", "potatoey", "buttery", "grassy", "rancid", "painty")

ff$subject <- factor(ff$subject)

color_palette <- brewer.pal(12, "Set3")

ggplot(ff, aes(x = subject, y = potatoey, fill = subject)) +
  geom_bar(stat = "identity") + 
  scale_fill_manual(values = color_palette) + 
  labs(title = "Potatoey Flavor Scores", x = "Subject", y = "Potatoey Score") +
  theme_minimal()
