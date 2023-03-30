#--Load necessary packages--
library(tidyverse)
library(dplyr)
library(lubridate)  
library(ggplot2)


#--Gather data--
jan_feb_mar <- read.csv("Jan_Feb_Mar_2020_bike_case_stady.csv")
apr <-read.csv("April_2020_bike_case_stady.csv")
may <-read.csv("May_2020_bike_case_stady.csv")
jun <-read.csv("Jun_2020_bike_case_stady.csv")
jul <-read.csv("Jul_2020_bike_case_stady.csv")
aug <-read.csv("Aug_2020_bike_case_stady.csv")
sep <-read.csv("Sep_2020_bike_case_stady.csv") 
oct <-read.csv("Oct_2020_bike_case_stady.csv")
nov <-read.csv("Nov_2020_bike_case_stady.csv")
dec <-read.csv("Dec_2020_bike_case_stady.csv")

#--Check if column names match for each data frame--
colnames(jan_feb_mar)
colnames(apr)
colnames(may)
colnames(jun)
colnames(jul)
colnames(aug)
colnames(sep)
colnames(oct)
colnames(nov)
colnames(dec)

#--Check data types for each data frame to ensure consistency--
str(jan_feb_mar)
str(apr)
str(may)
str(jun)
str(jul)
str(aug)
str(sep)
str(oct)
str(nov)
str(dec)

#--Change data types in April and December data frames to match the other month--
apr <- mutate(apr, start_station_id = as.integer(start_station_id),
              end_station_id = as.integer(end_station_id),
              start_lat = as.numeric(start_lat),
              start_lng = as.numeric(start_lng),
              end_lat = as.numeric(end_lat),
              end_lng = as.numeric(end_lng))
dec <- mutate(dec, start_station_id = as.integer(start_station_id),
              end_station_id = as.integer(end_station_id),
              start_lat = as.numeric(start_lat),
              start_lng = as.numeric(start_lng),
              end_lat = as.numeric(end_lat),
              end_lng = as.numeric(end_lng))

#-Combine all data frames for the full year into a single data frame-
all_trips <- bind_rows(jan_feb_mar, apr, may, jun, jul, aug, sep, oct, nov, dec)

#-Remove unnecessary columns- 
all_trips <- all_trips %>% 
  select(-c(start_lat, end_lat, start_lng, end_lng))

#--Perform initial exploratory data analysis--
colnames(all_trips)
nrow(all_trips)
ncol(all_trips)
head(all_trips)
str(all_trips)
summary(all_trips)
View(all_trips)

#--Examine the distribution and unique values of the member_casual--
table(all_trips$member_casual)
unique(all_trips$member_casual)

#--Convert the started_at and ended_at columns to POSIXct data type--
all_trips <- mutate(all_trips, started_at = as.POSIXct(started_at, format="%d/%m/%Y %H:%M"),
                    ended_at = as.POSIXct(ended_at, format="%d/%m/%Y %H:%M"))

#--Calculate the ride length for each trip in seconds--
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

#--Convert the ride_length column to a numeric data type--
all_trips$ride_length <- as.numeric(all_trips$ride_length)

#--Create a new version of the all_trips data frame that excludes trips from HQ QR starting stations or negative ride lengths--
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | 
                              all_trips$ride_length<0),]

#--Remove all rows that contain missing values in any column--
all_trips_v2 <- drop_na(all_trips_v2)

#--Convert the numeric values in the existing column to their corresponding weekday names--
all_trips_v2$day_of_week <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
all_trips_v2$day_of_week <- days_of_week[all_trips_v2$day_of_week]

#--Order the days of the week in the correct order for analysis--
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week,
                                    levels=c("Monday", "Tuesday", "Wednesday",
                                             "Thursday", "Friday", "Saturday", 
                                             "Sunday"))


# Descriptive analysis on ride_length (all figures in seconds)

#--Calculates the total number of rides for members and casual riders--
all_trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n())


#--Generates a summary of the ride_length--
summary(all_trips_v2$ride_length)


#--Aggregate ride length by member type to find the mean and median ride length for members and casuals--
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)



#--Calculate the average ride length for each combination of member type (member/casual) and day of week--
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + 
            all_trips_v2$day_of_week, FUN = mean)

#--Groups the data by day_of_week and member_casual columns, and then counts the number of rides for each group.
all_trips_v2 %>% 
  group_by(day_of_week,member_casual) %>% 
  summarise(number_of_ride = n()) %>% 
  arrange(day_of_week)


#--Creates a bar chart that displays the total number of rides taken by members and casual riders--
all_trips_v2 %>%
  group_by(member_casual) %>%
  summarise(ride_count = length(ride_id)) %>%
  ggplot(aes(x = member_casual, y = ride_count, fill = member_casual)) +
  geom_col(position = "dodge", color = "black", width = 0.7) +
  geom_text(aes(label = ride_count), position = position_dodge(width = 0.7),
            vjust = -0.5) +
  scale_fill_manual(values = c("#E69F00", "#56B4E9")) +
  labs(title = "Total rides taken by Members and Casual riders",
       x = "",
       y = "Number of rides",
       fill = "User type") +
  theme_minimal() +
  theme(legend.position = "top",
        panel.grid.major.y = element_line(color = "gray", linetype = "dashed"),
        panel.grid.minor.y = element_blank()) 

#--Generates a bar chart visualization of the number of rides for member and casual riders grouped by the day of the week--
all_trips_v2 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week)  %>% 
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + 
  scale_fill_manual(values = c("#E69F00", "#56B4E9")) +
  labs(title = "Table 1: Number of Rides by Day and Rider Type") + 
  ylab("Number of Rides (1e+05 = 100,000)") + 
  xlab("Day of Week") +
  theme_minimal() +
  theme(legend.position = "bottom")

#--visualizes the average duration of rides by day of the week and rider type (member or casual)--
all_trips_v2 %>%
  group_by(member_casual, day_of_week) %>%
  summarise(average_duration = mean(ride_length),
            sd_duration = sd(ride_length)/sqrt(n())) %>%
  ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge", color = "black", width = 0.7) +
  geom_errorbar(aes(ymin = average_duration - sd_duration, ymax = average_duration + sd_duration),
                position = position_dodge(width = 0.7), width = 0.2) +
  scale_fill_manual(values = c("#E69F00", "#56B4E9")) +
  labs(title = "Average duration of ride by day of the week",
       subtitle = "ride_length and weekday",
       x = "Day of the week",
       y = "Average ride duration (seconds)",
       fill = "User type") +
  theme_minimal() +
  theme(legend.position = "top",
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())













