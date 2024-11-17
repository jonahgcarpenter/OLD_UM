#Jonah Carpenter

library(tidyverse)

data("midwest")

#1 How do I define a vector of the just the PID? Call your variable  pid and use the PID variable.
pid <- midwest$PID
pid

#2 How do I create a data frame, avgIN, which contains the average population for  Indiana (IN) only.  Call your new column avg.?
avgIN <- midwest %>%
  filter(state == "IN") %>%
  summarise(avg = mean(poptotal))
avgIN

#3 How do I define a data frame of the just the PID? Call your data frame pidDF and use the PID variable. 
pidDF <- midwest %>%
  select(PID)
pidDF

#4 How do I create a data frame, pop30, that contains the number of counties in each Midwestern state with a population greater than 30000 - i.e.,  poptotal greater than 30000?  Your answer should only have 5 observations.
pop30 <- midwest %>%
  filter(poptotal > 30000) %>%
  group_by(state) %>%
  summarise(counties = n())
pop30

#5 How do I create a data frame , WI,  only containing information from Wisconsin (WI).  ALSO, add a new variable called region that is assigned the value Wisconsin.
WI <- midwest %>%
  filter(state == "WI") %>%
  mutate(region = "Wisconsin")
WI
