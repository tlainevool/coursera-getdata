## Project Description
This project uses data from the Human Activity Recognition Using Smartphones Data Set experiments. It selects a subset of the data and makes a tidy version of it.

##Study design and data processing

###Collection of the raw data
Data is used from the Human Activity Recognition Using Smartphones Data Set. The original project is described here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Creating the tidy datafile

###Guide to create the tidy data file
to use the script, follow the follwoing steps:
1. Download the project data from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>, save it in you working directory and unzip it.
2. Load the script into your R environment by running 
        source("run_analisys.R")
3. Run the script with the following command 
        runAnalysis()
        

This will generate a file named tidy_data.txt that contains the cleaned data.

###Cleaning of the data
The cleaning script takes just the mean and standard deviation measurements from the orginal data set. It then adds the subject and activity labels for each row of observations. Finally it aggregates the data by averaging them across subject and activity. For a more detailed description of how the code works, see the [readme file](README.md)

##Description of the variables in the tiny_data.txt file
The resulting tiny data set contains a row for each subject and activity pair. There were 30 subjects and 6 activities, resulting in 180 rows of data.

There are 68 variable, described below.

###Subject
This is a numeric variable from 1 - 30 indicating which subject the measurements are for.

###Activity
This is an activity label, with the following six possibilities:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

###Measurement Variables
There are 66 measurement variable from the accelerometer and gyroscope 3-axial raw signals. Each name is divided into 4 parts, each separated by a dash ('-').

The for parts are:
1. "time"" or "frequency"" indicates which domain signals the observation is for.
2. The type of measurement 
3. "mean" or "std" to indicate if this was a mean value or standard deviation
4. (optional) indicating the axis of the observation (if needed)

