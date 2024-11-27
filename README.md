![image alt](https://github.com/mamudjoof/Cleaning-ESPN-Data-Using-SQL/blob/main/DATA_CLEANINGSQL.png?raw=true)

# PROJECT TITLE:
# CLEANING AND ANALYZING CAREER BETTING AVERAGES DATA FOR CRICKETERS

# OBJECTIVE
This project aims to clean and analyze a dataset on the career batting averages of various cricketers. 
The objective is to extract meaningful insights about the players' careers, including the length of their careers, their batting performances, and trends across different time periods and countries. 
By transforming raw data and applying specific queries, this analysis seeks to answer key questions related to average career lengths, peak batting performances, and player statistics segmented by country and career duration.

# DATA SOURCE
The dataset was scraped from ESPN Cricinfo's website using Excel.
You can find the original dataset at the following link: https://www.espncricinfo.com/records/highest-career-batting-average-282910 

# METHODOLOGY
# Data Cleaning:
+ Renamed columns for clarity, transforming cryptic labels (e.g., "Mat" to "Matches Played") into more understandable names.
+ Replaced missing or ambiguous values such as "-", NULL with 0, 
+ Split complex columns like "Span" into separate "Start Year" and "End Year" fields for easier analysis of player tenure.
+ Separated the "Player" column into "Player Name" and "Country" to facilitate nationality-based queries.
+ Removed unnecessary columns that did not contribute to the analysis, such as certain numeric indicators.
+ Handled duplicate entries by identifying and removing duplicate player records based on key characteristics.

 # Data Analysis And Queries
+ Calculated the career length for each player by subtracting the start year from the end year.
+ Aggregated data to determine average career length across all players and identified the batting strike rate for players with careers longer than ten years.
+ Counted players who began their careers before 1960.
+ Determined the maximum highest innings scored for each country.
+ The country has the most players in the dataset
+ Determine players with the most matches played.

# TOOLS AND SOFTWARE USED:
+ Excel: Used to scrape data from ESPN Cricinfo's website.
+ SQL Server: Used to store, clean, and query data. SQL queries were used to manipulate, aggregate, and analyze data efficiently.
+ Power BI (planned): Intended for creating visualizations that display key insights on player statistics, country-wise breakdowns, and performance over time.
  
# RESULTS





# LEARNINGS AND INSIGHTS
From this project, I gained hands-on experience in data cleaning techniques, handling missing data, renaming columns, and structuring data for analysis in SQL. 
I improved my proficiency in parsing and splitting columns, especially with functions like PARSENAME for complex string handling. 
This experience also taught me how to manage and clean data efficiently in SQL Server, dealing with duplicates and transforming the dataset into a well-organized, analysis-ready form.

# AUTHOR
Mamud Joof

