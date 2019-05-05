library(dplyr)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){

        print("Waiting while dowloading zipped data source ...")
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

## Getting and Cleaning Data Course Project
## Results : df and df_averages

print("Waiting ...")

## Read features.txt and set to data frame features
features <- tbl_df(read.delim("UCI HAR Dataset/features.txt", header = FALSE, sep = "", quote = "\"", dec = ".", fill = TRUE, comment.char = ""))
features$name <- features$V2
features$name <- gsub("\\(\\)","",features$name)
features$name <- gsub("-",".",features$name)
features$name <- tolower(features$name)
## Add columns to check which is mean and wich is standard deviation
features$ismean <- grepl("mean\\(\\)",features$V2)
features$isstandarddev <- grepl("std",features$V2)

## Get Train activity codes
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", col.names = c("activity"))
print("train_activities OK")
print("Waiting ...")

## Get Train measurements
x_train <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = ""))
names(x_train) <- features$name
print("Read X_train.txt - OK")
print("Waiting ...")

## Get Train subjects
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train_subjects) <- "subject"

## Add column subject to train_activities
train_activities <- mutate(train_activities, subject = "train")

## Bind subjects, activities and X , set to df_train
df_train <- cbind(train_subjects, train_activities, x_train)

## Free memory
train_subjects <- NULL
train_activities <- NULL
x_train <- NULL


## Get Test activity codes
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", col.names = c("activity"))
print("Read y_test.txt - OK")
print("Waiting ...")

## Get Test measurements
x_test <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = ""))
names(x_test) <- features$name
print("Read X_test.txt - OK")
print("Waiting ...")

## Get Test subjects
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test_subjects) <- "subject"

## Bind subjects, activities and X , set to df_train
df_test <- cbind(test_subjects, test_activities, x_test)

## Free memory
test_subjects <- NULL
test_activities <- NULL
x_test <- NULL

## Q1 : Merges the training and the test sets to create one data set
## Union test and train in a single data frame, set to df
df <- union(df_test, df_train)
print("Q1 : Merges the training and the test sets to create one data set - OK ->")
print("Waiting ...")

## Free memory
df_train <- NULL
df_test <- NULL

## Q2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
## Delete from df duplicated column names
##
df <- df[!duplicated(names(df))]
## Drop columns that are neither mean nor standard deviation
columns_to_drop <- filter(features, ismean == FALSE & isstandarddev == FALSE)
c <- as.character(columns_to_drop$name)
df <- select(df, -one_of(c))
print("Q2 : Extracts measurements on the mean and standard deviation - OK")
print("Waiting ...")

## Q3 : Uses descriptive activity names to name the activities in the data set
##
## Read activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
##
## Replace code by labels when matching, set to lower case
df$activity <- as.factor(tolower(as.character(activity_labels[match(df$activity,activity_labels$V1), 'V2'])))
print("Q3 : Uses descriptive activity names to name the activities in the data set - OK")
print("Waiting ...")

## Q4 : Appropriately labels the data set with descriptive variable names.
## Done before merging
print("Q4 : Appropriately labels the data set with descriptive variable names - OK")
print("Waiting ...")


       
## Q5 : Average of each variable for each activity and each subject.

df_averages <- group_by(df,subject,activity)
df_averages <- summarise_all(df_averages,mean,na.rm=TRUE)
print("Q5 : Average of each variable for each activity and each subject - OK")
print("Step 5 set to variable df_averages")
print("Waiting ...")

## Write table 
write.table(df_averages,"tidy.dataset.txt", row.names = FALSE)

print("End")




