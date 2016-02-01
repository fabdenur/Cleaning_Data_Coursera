# Cleaning_Data_Coursera
run.analysis script for Data Cleaning course assignment

the *run.analysys.R* script works by performing the following steps:

- activates dplyr library

- reads the data from the `test` folder and saves it in data frames named after the files they came from

- reads the data from the `train` folder and saves it in data frames named after the files they came from

- column-binds the training and the test data with their respective (for now numerical) activity names

- row-binds the training and the test sets to create a single data set called table_1

- reads the features file, which contains the variable names for the test data then saves these names in a features_names vector that includes two extra names in the beginning: "Subject" and "Activity"

- assigns the variable names vector *features_names* to table_1

-  selects the Subject, Activity columns and the columns that contain "std" and "mean" from table_1
and assigns them to a data frame called table_2

- reads the names that correspond to the numbered activities (column 2) of table_2 and replaces the numbers by their corresponding names

- making the variable names a bit more descriptive: replace initial "f" with "freq.", initial "t" with "time." and remove special characters by replacing "-" with "." and deleting "()"

- assign the more descriptive variable names to table_2

- aggregates the data of *table_2* into a tidy data frame called *table_means* in which mean values are grouped by Subject and Activity
