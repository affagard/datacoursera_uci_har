# Code Book
Getting and Cleaning Data Course Project

## Subject
Data set and the script to process two new tidy data sets from several data source files 

## Data source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Raw data came from the Human Activity Recognition Using Smartphones Dataset (www.smartlab.ws) in Genova.
Captures of raw data have been made with people wearing a Samsung Galaxy S II smartphone during several set of experimentations.
Initial pre-processed data for the project are in the ```/raw``` folder as they were deliver to perform the project.
All details and references about experiments in ```/raw/README.txt```

## Raw data input
All raw data are in the folder ```/raw```
Experiments are divided into 6 activities and into 2 subjects called ```test```and ```train```
Files used in the final script
 * ```/raw/train/train/X_train.txt``` : measurements for 561 variables (called features) for train
 * ```/raw/train/train/y_train.txt``` : activities for each measurement for train
 * ```/raw/test/test/X_test.txt``` : measurements for 561 variables (called features) for test
 * ```/raw/test/test/y_test.txt``` : activities for each measurement for test
 * ```/raw/features.txt``` : Names of the 561 measured varibles
 * ```/raw/activity_labels.txt``` : Names of the 6 activities
 
 

## Processing of the project
5 steps to create 2 tidy data sets and a unique script to perform them

 * Q1 : Merges the training and the test sets to create one data set.
 * Q2 : Extracts only the measurements on the mean and standard deviation for each measurement.
 * Q3 : Uses descriptive activity names to name the activities in the data set.
 * Q4 : Appropriately labels the data set with descriptive variable names.
 * Q5 : Average of each variable for each activity and each subject.


## Result
The final and unique script to perform the tidy data set results is ```run_analysis.R```

```run_analysis.R``` creates 2 dataframe variables
 * ```df``` : a tidy data set in a dataframe variable performed with steps 1 to 4 of the project. Steps are tagged with comments inside script.
 * ```df_averages``` : a tidy data set in a dataframe variable performed with the final step 5 of the project

```df_averages``` is exported in the file ```tidy.dataset.txt```
 * Exported via ```write.table()``` function
 * ```row.names = FALSE```
 
 ## Data set result
 ### df
  * ```activity``` : char, 
  * ```subject``` :
 ### df_averages
  * For each varibale of ```df```, means by activity and by subject 
 
 
 
 This work has been performed with RStudio Version 1.1.463 on Mac OS X 10.14.4
 Using ```library(dplyr)```
 
 Public Repo : https://github.com/affagard/datacoursera_uci_har
 