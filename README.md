## Overview
This file is an explanation of how the script cleans the data. For details on how to run the script and the output see [the code book](codebook.md)

The cleaning script takes just the mean and standard deviation measurements from both of the test and train data sets. It then adds the subject and activity labels for each row of observations. Finally it, aggregates the data by averaging them across subject and activity.

Below is a overview of each function

### runAnalysis
The top level function. Calls methods to get a data table of all the raw measuremnts, calls a method to do the aggregation, and then writes out the final file

### getDataWithNames
Reads in from the features.txt file which has all the names of each column of the original measurements.
Creates a column selector which can be used select just the columns that have "mean()" or "std()" in the names. This column selector is passed to the getMeasurementData function which will read each of the data sets. Finally column names are generated and added to the data frame.

### getAggregateData
This method takes in the full set of measurements and averagres the data grouped by subject and activity. It then orderes the data by subject and activity to make it easier to read.

### getMeasurementData
Reads data from each of the train and test data sets and merges them together

### getDataFromDataSet
Reads all the data required from one data set. This includes the measurement data, along with the corresponding subjects and activities.

The measurement data is in a fixed width format with a field width of 16 characters. The columnSelector provides a way of choosing desired columns by putting in a "16" for columns that are wanted and "-16" for unwanted columns.

It then uses functions to get the acticities and subjects columns and combines them all together into a single data table.

### getActivitiesColumn
This function creates the activities column for the table. It gets all of the activties for the measurements and then uses the activity_labels.txt file to translate the activity number into a more easily readable name.

### getSubjects
Creates the subjects column for the table. It simply reads these in from the appropriate data set.

### getLabels
This function parses the contents of features.txt file to get just the ones with "mean()" and "std()" in the names. It then transformas the names into a more readable format as described in the [codebook file](codebook.md)

### getColumnSelector
Creates a vector that can be used to select the desired columns. The vectore will have "16" for any column that contains "mean()" or "std()" and -16 for any column that does not.

### makeFileName
A utility function to ease the creation of file names in the correct data directory.
### getActivitiesColumn

