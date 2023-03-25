# Bike-Share-Data-Analysis

This project involves analyzing bike share data for the year 2020. The data was gathered from 10 different CSV files, each representing a different month of the year. The goal of this analysis is to gain insights into the usage patterns of bike share users, including the average ride length, the number of rides taken by members vs. casual riders, and the average ride length by day of the week.

#Getting Started
To run this analysis, you will need to download all 10 CSV files containing the bike share data for each month of 2020. The CSV files should be stored in the same directory as the R script. Additionally, you will need to install the necessary packages (tidyverse, dplyr, lubridate, and ggplot2) if you haven't already.

#Data Cleaning and Analysis
The R script used to clean and analyze the data is included in this repository. The script performs the following tasks:

Loads the necessary packages
Reads in the CSV files for each month of the year
Checks if the column names and data types match for each data frame
Changes the data types in April and December data frames to match the other months
Combines all data frames into a single data frame
Removes unnecessary columns
Converts the started_at and ended_at columns to POSIXct data type
Calculates the ride length for each trip in seconds
Removes trips from HQ QR starting stations or negative ride lengths
Removes all rows that contain missing values in any column
Converts the numeric values in the day_of_week column to their corresponding weekday names
Orders the days of the week in the correct order for analysis
Performs descriptive analysis on ride_length
Aggregates ride length by member type to find the mean and median ride length for members and casuals
Calculates the average ride length for each combination of member type and day of the week
Results
The results of the analysis can be found in the R script. They include the total number of rides for members and casual riders, the summary of the ride_length, the mean and median ride length for members and casuals, and the average ride length by day of the week.

#Visualizations
The script also includes several visualizations created using ggplot2. These visualizations help to illustrate some of the insights gained from the analysis.

#Conclusion
The analysis of the bike share data for 2020 provides valuable insights into the usage patterns of bike share users. The results show that the majority of rides were taken by members, and that the average ride length for members was longer than for casual riders. The analysis also shows that ride length varies by day of the week, with longer rides taken on weekends. These insights can be used to improve the bike share program and make it more accessible and convenient for users.
