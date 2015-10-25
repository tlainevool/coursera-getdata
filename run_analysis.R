#Run the analysis
runAnalysis <- function() { 
        data <- getDataWithNames()
        aggregate = getAggregateData(data)
        print("Writing data to tidy_data.txt")
        write.table(aggregate, 
                    file = file("tidy_data.txt", "w+"), 
                    row.names = FALSE)
}

#Get all of the measurments data, with subjects, activities and labels 
getDataWithNames <- function() {
        #read in the features labels
        features <- read.table(makeFileName("features.txt"))[,2]
        #select just the ones that are for mean or std
        columnSelector = getColumnSelector(features)
        #get all the measurement data for the selected columns
        data <- getMeasurementData(columnSelector)
        #add the labels
        colnames(data) <- getLabels(features)
        data
}

#Group the data by Subject and activity and sort it
getAggregateData <- function(data) {
        print("Aggregating and sorting data...")
        data <- aggregate(
                data, 
                by=list(Subject = data$Subject, Activity = data$Activity),
                mean)
        data <- data[-c(3,4)]
        data[,1] <- as.numeric(data[,1])
        data[order(data$Subject,data$Activity),]
}

#Read in data from test and training sets and merge them together
getMeasurementData <- function(columnSelector) {
        testData <- getDataFromDataSet("test", columnSelector)
        trainData <- getDataFromDataSet("train", columnSelector)
        rbind(testData, trainData)
}

#Get all the data from one of the given data sets.
# - Read in all the measurments from the main data set
# - Read in the activities
# - Read in the subjects
# - put them all together into a single dataframe
getDataFromDataSet <- function (dataSetName, columnSelector) {
        fileName <- makeFileName(dataSetName, "/X_", dataSetName, ".txt")
        measurements <- read.fwf(fileName, widths = columnSelector)
        activities = getActivitiesColumn(dataSetName)
        subjects = getSubjectsColumn(dataSetName)
        cbind(subjects, activities, measurements)
}

#Read the activities from the "y" files and the activity labels and convert
# into the activity names
getActivitiesColumn <- function(dataSetName) {
        activityLabels <- read.table(makeFileName("activity_labels.txt"))
        fileName <- makeFileName(dataSetName, "/y_" , dataSetName, ".txt")
        activities <- readLines(fileName)
        sapply(activities, function(num) { activityLabels[num,2] })
}

#Read the data from the subject file for a particular data set
getSubjectsColumn <- function (dataSetName) {
        readLines(makeFileName(dataSetName, "/subject_", dataSetName, ".txt"))
}

#Gets only the features from input that match mean() or std(), tidys the names
# and adds extra labels for Subject and Activity
getLabels <- function(features) {
        #extract just the names with mean() or std()
        cols <- grep("mean\\(\\)|std\\(\\)", features, value = TRUE)
        
        #These two lines clean up the header names
        cols <- sub("t([a-zA-Z]*)-(.*)\\(\\)(-?.?)", 
                    "time-\\1-\\2\\3", 
                    cols )
        cols <- sub("f([a-zA-Z]*)-(.*)\\(\\)(-?.?)", 
                    "frequency-\\1-\\2\\3", 
                    cols )
        
        c( "Subject", "Activity", cols)
}

#Get a vector that can be used in conjuctionwith read.fwf. Each item should
#contain 16 if that column is a match and -16 if it should be skipped
getColumnSelector <- function(features) {
        sapply(features, 
               function(field) { 
                       if( grepl("mean\\(\\)|std\\(\\)", field[1]) )
                               16
                       else 
                               -16 
                       })
}

#A helper function to construct filenames in the right base directory
makeFileName <- function(...) {
        fileName = paste("UCI HAR Dataset/", ..., sep = "")
        print(paste("Reading data from '", fileName, "'...", sep = "" ))
        fileName
}

