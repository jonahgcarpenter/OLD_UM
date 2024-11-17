#install socviz package
library(tidyverse)
library(RColorBrewer)

#Load and wrangle college
college <-  read_csv("data/college.csv", col_names = TRUE)

college <- college %>%
  mutate(state = as.factor(state),
         region = as.factor(region),
         highest_degree = as.factor(highest_degree),
         control = as.factor(control),
         gender = as.factor(gender),
         loan_default_rate = as.numeric(loan_default_rate)) %>%
  na.omit

#Scatterplot of SAT avg relative to Tuition
college %>%
  ggplot() +
  geom_point(mapping = aes(x=tuition,
                           y=sat_avg, 
                           color = tuition,
                           #size = tuition,
  ),
  alpha = 0.25) +
  scale_color_distiller(palette="Dark2") +
  labs("SAT Average by Tuition",
       x = "Tuition",
       y = "SAT Average")

#Histogram of college tuition by public v. private (control)

college %>%
  ggplot() +
  geom_histogram(mapping = aes(x = tuition,
                               fill = control))

# Now do for for SAT avg
college %>%
  ggplot() +
  geom_histogram(mapping = aes(x = sat_avg,
                               fill = control))
