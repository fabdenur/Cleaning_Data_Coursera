run_analysis <- function()

## activates dplyr library
library(dplyr)

## sets working directory to where the new dataset has been saved
setwd("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset")

# reads the data from the `test` folder and saves it in data frames named after the files they came from
subject_test <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/test/Y_test.txt")

# reads the data from the `train` folder and saves it in data frames named after the files they came from
subject_train <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/train/Y_train.txt")

# column-binds the training and the test data with their respective (for now numerical) activity names
test_table <- cbind(subject_test, Y_test, X_test)
train_table <- cbind(subject_train, Y_train, X_train)

# row-binds the training and the test sets to create a single data set called table_1
table_1 <- rbind(test_table, train_table)

# reads the features file, which contains the variable names for the test data
# then saves these names in a features_names vector that includes two extra names in the beginning: "Subject" and "Activity"
features <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/features.txt")
features_names <- c("Subject", "Activity", as.character(features[ , 2]))

# assigns the variable names vector features_names to table_1
names(table_1) <- features_names

# selects the Subject, Activity columns and the columns that contain "std" and "mean" from table_1
# and assigns them to a data frame called table_2
table_2 <- table_1[, grepl("Subject", features_names) | grepl("Activity", features_names) | grepl("std", features_names) | grepl("mean", features_names)]

# reads the names that correspond to the numbered activities (column 2) of table_2
# and replaces the numbers by their corresponding names
activity_labels <- read.table("/Users/flavio/workspace/datasciencecoursera/UCI HAR Dataset/activity_labels.txt")
table_2[, 2] <- sapply(table_2[,2], function(i){as.character(activity_labels[i,2])})

# making the variable names a bit more descriptive: replace initial "f" with "freq.", initial "t" with "time."
# and remove special characters by replacing "-" with "." and deleting "()"
names_1 <- gsub("-",".",names(table_2))
names_2 <- as.character(sapply(names_1, function(x){if (substring(x, 1, 1) == "f") (sub("f", "freq.", x)) else (x)}))
names_3 <- as.character(sapply(names_2, function(x){if (substring(x, 1, 1) == "t") (sub("t", "time.", x)) else (x)}))
names_descriptive <- sub("\\(\\)", "", names_3)

# assign the more descriptive variable names to table_2
names(table_2) <- names_descriptive

# aggregates the data of table_2 into a tidy data frame called table_means
# in which mean values are grouped by Subject and Activity
table_means <-aggregate(table_2[3:81], by=list(Subject = table_2$Subject, Activity = table_2$Activity), FUN=mean, na.rm=TRUE)
