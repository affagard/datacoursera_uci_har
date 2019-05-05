# Coursera : Getting and Cleaning Data Course Project

## Repo
named : datacoursera_uci_har

## Aim of this Course Project

Create an R script called run_analysis.R to set 2 tidy data sets.

## Data source
Raw data came from the Human Activity Recognition Using Smartphones Dataset (www.smartlab.ws) in Genova.
Captures of raw data have been made with people wearing a Samsung Galaxy S II smartphone during several set of experimentations.
Initial pre-processed data for the project are in the raw folder as they were deliver to perform the project

## Processing of the project
5 steps to create 2 tidy data sets and a unique script to perform them

 * Q1 : Merges the training and the test sets to create one data set.
 * Q2 : Extracts only the measurements on the mean and standard deviation for each measurement.
 * Q3 : Uses descriptive activity names to name the activities in the data set.
 * Q4 : Appropriately labels the data set with descriptive variable names.
 * Q5 : Average of each variable for each activity and each subject.


## Result
The final and unique script to perform the tidy data set results is run_analysis.R

```run_analysis.R``` creates 2 dataframe variables
 * ```df``` : a tidy data set in a dataframe variable performed with steps 1 to 4 of the project. Steps are tagged with comments inside script.
 * ```df_averages``` : a tidy data set in a dataframe variable performed with the final step 5 of the project

```df_averages``` is exported in an independant file : ```tidy.dataset.txt```
 * Exported via ```write.table()``` function
 * ```row.names = FALSE```
 
 