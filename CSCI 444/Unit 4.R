#Jonah Carpenter
#Jacob Miller

install.packages("nycflights13")
library(nycflights13)

data(package = "nycflights13")
#How many datasets?
#5

class("flights")
#What type of R object is flights?
#Character

dim(flights)
View(flights)
#How many variables and obvservations?
#19, 336776 

#STEP4
Jan1 <- subset(flights, month == 1 & day == 1)

Jan1 <- Jan1[, c("carrier", "flight", "origin", "dest", "arr_time", "dep_time")]

Jan1$total_time <- (Jan1$arr_time %/% 100 * 60 + Jan1$arr_time %% 100) - 
  (Jan1$dep_time %/% 100 * 60 + Jan1$dep_time %% 100)

#STEP5
install.packages("devtools")
devtools::install_github("hadley/emo")
library(emo)

emo::ji("airplane")

