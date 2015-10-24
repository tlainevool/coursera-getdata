baseDir <- "UCI HAR Dataset/"

getDataWithNames <- function() {
        features <- read.table(makeFileName("features.txt"))[,2]
        columnSelector = getColumnSelector(features)
        data <- getData(columnSelector)
        colnames(data) <- getLabels(features)
        data
}

#Read in data from test and training sets and merge them together
getData <- function(columnSelector) {
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
        testData <- read.fwf(fileName, widths = columnSelector)
        activities = getActivitiesColumn(dataSetName)
        subjects = getSubjects(dataSetName)
        cbind(subjects, activities, testData)
}

#A helper function to construct filenames in the right base directory
makeFileName <- function(...) {
        paste(baseDir, ..., sep = "")
}

#Read the activities from the "y" files and the activity labels and convert
# into the activity names
getActivitiesColumn <- function(dataSetName) {
        activityLabels <- read.table(makeFileName("activity_labels.txt"))
        fileName <- makeFileName(dataSetName, "/y_" , dataSetName, ".txt")
        activities <- readLines(fileName)
        sapply(activities, function(num) { activityLabels[num,2] })
}

#Read the data from the subject file
getSubjects <- function (dataSetName) {
        readLines(makeFileName(dataSetName, "/subject_", dataSetName, ".txt"))
}

#Gets only the lines from input that match mean() or std()
getLabels <- function(features) {
        c( "Subject", "Activity", grep("mean\\(\\)|std\\(\\)", features, value = TRUE))
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