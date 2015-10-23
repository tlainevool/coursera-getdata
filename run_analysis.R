getData <- function() {
    columnSelector = c(16,16,16)#pass this in with 16 for wanted columns, -16 for unwanted
    testData <- read.fwf("data/train/X_train.txt", widths = columnSelector)
    trainData <- read.fwf("data/train/X_train.txt", widths = columnSelector)
    rbind(testData, trainData)
}
