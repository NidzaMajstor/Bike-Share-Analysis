# Bike-Share-Data-Analysis
![Alt text](https://github.com/NidzaMajstor/Bike-Share-Analysis/blob/main/image.jpg)

## Scenario
You are a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve your recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## About Cyclistic
In 2016, Cyclistic launched a successful bike-sharing offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unloacked from one station and returned to any other station in the system anytime.

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.

## The Stakeholders
Lily Moreno: The director of marketing and my manager. Moreno is responsible for the development of campaigns and initiatives to promote the bike-share program.
Cyclistic marketing analytics team: A team of data analysts who are responsible for collecting, analyzing, and reporting data that helps guide Cyclistic marketing strategy.
Cyclistic executive team: A notoriously detail-oriented team which will decide whether to approve the recommended marketing program.
The Business Task
The goal of this case study is to provide clear insights for designing marketing strategies aimed at converting casual riders into annual members. Towards this goal, I asked the following questions:

* How do annual members and casual riders use Cyclistic bikes differently?
* Why would casual riders buy Cyclistic annual memberships?
* How can Cyclistic use digital media to influence casual riders to become members?


This project involves analyzing bike share data for the year 2020. The data was gathered from 10 different CSV files, each representing a different month of the year. The goal of this analysis is to gain insights into the usage patterns of bike share users, including the average ride length, the number of rides taken by members vs. casual riders, and the average ride length by day of the week.

## Getting Started
To run this analysis, you will need to download all 9 CSV files containing the bike share data for each month of 2020, as well as one containing the first three months. The CSV files should be stored in the same directory as the R script. Additionally, you will need to install the necessary packages (tidyverse, dplyr, lubridate, and ggplot2) if you haven't already.

## Data Cleaning and Analysis
The R script used to clean and analyze the data is included in this repository. The script performs the following tasks:

* Loads the necessary packages
* Reads in the CSV files for each month of the year
* Checks if the column names and data types match for each data frame
* Changes the data types in April and December data frames to match the other months
* Combines all data frames into a single data frame
* Removes unnecessary columns
* Converts the started_at and ended_at columns to POSIXct data type
* Calculates the ride length for each trip in seconds
* Removes trips from HQ QR starting stations or negative ride lengths
* Removes all rows that contain missing values in any column
* Converts the numeric values in the day_of_week column to their corresponding weekday names
* Orders the days of the week in the correct order for analysis
* Performs descriptive analysis on ride_length
* Aggregates ride length by member type to find the mean and median ride length for members and casuals
* Calculates the average ride length for each combination of member type and day of the week

# Visualizations
The script also includes several visualizations created using ggplot2. These visualizations help to illustrate some of the insights gained from the analysis. 
These visualizations are saved in the "Visualizations" folder as png files.

# Findings
## Ridership Comparison
* Members have a higher number of rides compared to casual riders.
## Ride Duration
* Casual riders ride for a longer time period with an average ride duration of 46 minutes.
* Members have a shorter average ride duration of 17 minutes.
## Ride Frequency and Consistency
* There is consistency in the number of rides taken by members throughout the week.
* Casual riders tend to take more rides during weekends.
## Average Ride Duration
* On average, each ride is about 27 minutes.
* Casual users ride for 2.7x to 3x longer than members on any day of the week.

# Recommendations

After analyzing the data, some recommendations to increase ridership and revenue for the bike-share program are:

* Offer a weekend-only membership at a different price point than the full annual membership to entice casual users towards a full annual membership. They can only unlock bikes on Friday, Saturday, or Sunday.
* Implementing targeted social media ads aimed at individuals who have previously used bike-sharing services and have expressed an interest in travel, outdoor sports, parks, museums, and Chicago's tourist landmarks.
* Offering progressive discounts based on ride length could incentivize members to use the bikes for longer periods, leading to increased revenue for the company. The longer the ride, the greater the discount on rates, providing members with an affordable and flexible means of transportation.
