#Jonah Carpenter
#Unit 7 - Activity A

library(dplyr)
library(stringr)

inpatient <- read.delim("data/inpatient.tsv", sep = "\t")

#Select
inpatient_clean <- inpatient %>%
  select(Average.Total.Payments, Average.Medicare.Payments) %>%
  rename(Average_Payments = Average.Total.Payments, Average_Medicare_Payments = Average.Medicare.Payments)

#Numeric
inpatient_clean <- inpatient_clean %>%
  mutate(Average_Payments = as.numeric(str_replace(Average_Payments, "\\$", "")),
         Average_Medicare_Payments = as.numeric(str_replace(Average_Medicare_Payments, "\\$", "")))

#Average
average_payments <- inpatient_clean %>%
  summarise(Average_Payments = mean(Average_Payments, na.rm = TRUE),
            Average_Medicare_Payments = mean(Average_Medicare_Payments, na.rm = TRUE))

#Print
print(average_payments)
