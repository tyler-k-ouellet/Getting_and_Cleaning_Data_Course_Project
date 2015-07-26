# Getting_and_Cleaning_Data_Course_Project
Project for Coursera course

The file CodeBook.md explains the variables and structure of the data set. 

The file run_analysis.R will do the following:
  1. open and load date files located in UCI HAR Dataset into R
  2. build a data frame for the test and the train data
  3. append the test and the train data
  4. name all variables with appropriate names
  5. exclude variables not related to mean or standard deviation measurements
  6. add activity names variable for each activity
  7. find mean for each variable for every subject and activity
