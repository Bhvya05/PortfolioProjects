## Cyclistic bike-share analysis case study! 


install.packages(c("tidyverse", "dplyr", "readr", "lubridate", "ggplot2"))

setwd("D:/mba/data A/course 8/case study/New folder (2)")

cycle1 <- read_csv("202206-divvy-tripdata.csv")
cycle2 <- read_csv("202207-divvy-tripdata.csv")
cycle3 <- read_csv("202208-divvy-tripdata.csv")
cycle4 <- read_csv("202209-divvy-publictripdata.csv")
cycle5 <- read_csv("202210-divvy-tripdata.csv")
cycle6 <- read.csv("202211-divvy-tripdata.csv")

str(cycle1)

cycle1 <- cycle1[c(1:4,13)]
cycle2 <- cycle2[c(1:4,13)]
cycle3 <- cycle3[c(1:4,13)]
cycle4 <- cycle4[c(1:4,13)]
cycle5 <- cycle5[c(1:4,13)]
cycle6 <- cycle6[c(1:4,13)]


str(cycle1)
str(cycle2)
str(cycle3)
str(cycle4)
str(cycle5)
str(cycle6)


View(cycle5)
cycle5 <-  mutate(cycle5,started_at=as.POSIXct(started_at))
cycle5 <-  mutate(cycle5,ended_at=as.POSIXct(started_at))
str(cycle5)

alldata <- rbind(cycle1,cycle2,cycle3,cycle4,cycle5,cycle6)
View(alldata)

alldata["ride_duration"] <- alldata$ended_at - alldata$started_at
alldata["day_of_week"] <- weekdays(as.Date(alldata$started_at))


library(dplyr)
table(alldata['member_casual'])
table(alldata['rideable_type'])
table(alldata['day_of_week'])

library("lubridate")
alldata["month"] <- month(as.Date(alldata$started_at))
table(alldata['month'])



day_count <- alldata %>% count(day_of_week)
print(nrow(alldata))

alldata$ride_duration <- as.numeric(alldata$ended_at - alldata$started_at, units="mins")


# to delete a column
alldata <- alldata %>%  
  +     select(-c(unit))


# Compare members and casual users
aggregate(alldata$ride_duration ~ alldata$member_casual, FUN = mean)
aggregate(alldata$ride_duration ~ alldata$member_casual, FUN = median)
aggregate(alldata$ride_duration ~ alldata$member_casual, FUN = max)
aggregate(alldata$ride_duration ~ alldata$member_casual, FUN = min)


# See the average ride time by each day for members vs casual users
aggregate(alldata$ride_duration ~ alldata$member_casual + alldata$day_of_week, FUN = mean)

# Notice that the days of the week are out of order. Let's fix that.
alldata$day_of_week <- ordered(alldata$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# analyze ridership data by type and weekday
average_duration = mean(alldata$ride_duration) 
print(average_duration)

install.packages("ggplot2")
library(ggplot2)


# Let's visualize 

# 1) number of rides by rider type

alldata %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(alldata$ride_length)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge")

# 2) ride type preferred by casual riders and annual members

ggplot(data=alldata,  mapping=aes(x=member_casual, y=rideable_type, fill=rideable_type)) + geom_bar(position="dodge",stat="identity")



