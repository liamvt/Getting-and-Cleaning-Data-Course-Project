# Getting-and-Cleaning-Data-Course-Project

This file describes how to download the data, how the run_analysis.R script works and what files will be outputted by the script

1. Download the data from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Unzip the "UCI HAR Dataset" folder into your working directory
3. Copy the run_analysis.R file into your working directory and enter the command source("run_analysis.R")

  - The run_analysis.R script performs the following transformations on the raw data:
      - Reads in the three parts of both the training and testing raw data sets
      - Adds variables names to each of the three parts of the training and test datasets
        * Combines the three parts of the training set together using cbind
        * Combines the three parts of the test set together using cbind
        * Combines the training and test sets together to form one data set using rbind
      - Uses the select() function from the dplyr package to select only those variables that measure a mean or standard variation, along with the subject ID and activity variables
      - Uses the mapvalues function to add descriptive activity names to the activity column
        * Formerly the activity variable took the values of 1, 2, 3 etc. which represented a particular activity
        * Replaced with actual descriptive activity names that correspond to the numeric value ("WALKING", "WALKING_UPSTASIRS" etc.)
      - Uses the gsub function to remove "." from variable names
      - Uses the ddply function to create a new data fram that takes the average of each variable for each activity set
        * Writes this new data frame to a .txt file using write.table

4. The run_analysis.R script outputs a file named "tidyDf.txt" into the working directory
  - To read this file in R, enter the command read.table("tidyDf.txt")
