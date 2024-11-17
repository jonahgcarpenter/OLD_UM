#Jonah Carpenter
# Unit 9 Activity B/C


library(tidyr)
library(tibble)
library(ggplot2)
library(dplyr)
library(readr)
library(RColorBrewer)

data(french_fries)

ff <- as_tibble(french_fries)

ff_long <- pivot_longer(ff, cols = potato:painty, names_to = "category", values_to = "amount")

ff_summary <- ff_long %>%
  group_by(category) %>%
  summarize(mean_amount = mean(amount, na.rm = TRUE))

color_vector <- c("red", "blue", "green", "purple", "orange")

ggplot(ff_summary, aes(x = reorder(category, -mean_amount), y = mean_amount, fill = category)) +
  geom_col(show.legend = FALSE) +
  ggtitle("French Fries") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank()) +
  ylab("Average Rating") +
  scale_fill_manual(values = color_vector) +
  coord_flip()

imdb_top_250 <- read_csv("data/imdb_top_250.csv")

ggplot(imdb_top_250, aes(x = year)) +
  geom_histogram(bins = 9, fill = brewer.pal(9, "Set1"), color = "black") +
  ggtitle("Top 250 Grossing Movies") +
  theme(plot.title = element_text(hjust = 0.5),
        panel.background = element_blank()) +
  xlab("Year") +
  ylab("Dollars in Millions")
