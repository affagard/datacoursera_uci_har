library(dplyr)

print("Waiting ...")

## Get activity codes from "raw/train/y_train.txt", set to train_activities
train_activities <- read.table("raw/train/y_train.txt", header = FALSE, sep = "", col.names = c("activity"))
print("train_activities OK")
print("Waiting ...")

## Get measurements  from "raw/train/X_train.txt", set to x_train
x_train <- tbl_df(read.table("raw/train/X_train.txt", header = FALSE, sep = ""))
print("Read X_train.txt - OK")
print("Waiting ...")

## Add column subject to train_activities
train_activities <- mutate(train_activities, subject = "train")

## Bind train_activities, subject and x_train, set to df_train
df_train <- cbind(train_activities,x_train)

## Free memory
train_activities <- NULL
x_train <- NULL


## Get activity codes from "raw/test/y_test.txt", set to test_activities
test_activities <- read.table("raw/test/y_test.txt", header = FALSE, sep = "", col.names = c("activity"))
test_activities <- mutate(test_activities, subject = "test")
print("Read y_test.txt - OK")
print("Waiting ...")

## Get measurements  from "raw/test/X_test.txt", set to x_test
x_test <- tbl_df(read.table("raw/test/X_test.txt", header = FALSE, sep = ""))
print("Read X_test.txt - OK")
print("Waiting ...")

## Bind test_activities, subject and x_test, set to df_test
df_test <- cbind(test_activities,x_test)

## Free memory
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


## Q3 : Uses descriptive activity names to name the activities in the data set
##
## Read activity_labels.txt
activity_labels <- read.table("raw/activity_labels.txt", header = FALSE, sep = "", quote = "\"", dec = ".", fill = TRUE, comment.char = "")
##
## Replace code by labels when matching, set to lower case
df$activity <- as.factor(tolower(as.character(activity_labels[match(df$activity,activity_labels$V1), 'V2'])))
print("Q3 : Uses descriptive activity names to name the activities in the data set - OK")
print("Waiting ...")

## Q4 : Appropriately labels the data set with descriptive variable names.
## Set some significant names to X measures columns
##
## Read features.xt and set to data frame features
features <- tbl_df(read.delim("raw/features.txt", header = FALSE, sep = "", quote = "\"", dec = ".", fill = TRUE, comment.char = ""))
features$name <- features$V2
features$name <- gsub("\\(\\)","",features$name)
# features$name <- gsub(",","",features$name)
features$name <- gsub("-",".",features$name)
features$name <- tolower(features$name)
## Add columns to check which is mean and wich is standard deviation
features$ismean <- grepl("mean\\(\\)",features$V2)
features$isstandarddev <- grepl("std\\(\\)",features$V2)
## Set new significant names
new_names <- features$name
new_names <- append(new_names, c("activity","subject"), after = 0)
names(df) <- new_names
new_names <- NULL
print("Q4 : Appropriately labels the data set with descriptive variable names - OK")
print("Waiting ...")

## Delete from df duplicated column names
##
df <- df[!duplicated(names(df))]


## Q2 : Extracts only the measurements on the mean and standard deviation for each measurement. 
## Drop columns that are neither mean nor standard deviation
columns_to_drop <- filter(features, ismean == FALSE & isstandarddev == FALSE)
c <- as.character(columns_to_drop$name)
df <- select(df, -one_of(c))
print("Q2 : Extracts measurements on the mean and standard deviation - OK")
print("Step 4 set to variable df")
print("Waiting ...")
       
## Q5 : Average of each variable for each activity and each subject.

df_averages <- group_by(df,activity,subject)
df_averages <- summarise_all(df_averages,mean,na.rm=TRUE)
print("Q5 : Average of each variable for each activity and each subject - OK")
print("Step 5 set to variable df_averages")
print("Waiting ...")


print("End")




