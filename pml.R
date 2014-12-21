library(caret)

#
# Load data from csv file
dataOriginal<-read.csv("pml-training.csv")
dataTestOriginal<-read.csv("pml-testing.csv")


#
# Discard user name and timestamp columns [1:5]
dataOriginal<-dataOriginal[, -(1:5)]
dataTestOriginal<-dataTestOriginal[, -(1:5)]

#
# Find near zero variance indices (default values)
indexNearZero <- nearZeroVar(dataOriginal)
data<-dataOriginal[, -indexNearZero]
dataTest<-dataTestOriginal[, -indexNearZero]

#
# Count NA values for the remaining predictors
NAdata<-is.na(data)
NAdataCount<-colSums(NAdata)

#
# Find predictrors with large number of NAs
LargeNAdataCount<-NAdataCount[NAdataCount>19000]
LargeNAdataCountNames<-names(LargeNAdataCount)

#
# Exclude predictors with large number of NAs
data<-data[, -which(names(data) %in% LargeNAdataCountNames)]
dataTest<-dataTest[, -which(names(dataTest) %in% LargeNAdataCountNames)]

#
# Find correlations
correlated <- findCorrelation(cor(data[, -54]), cutoff = 0.80, verbose=FALSE)
data<-data[, -correlated]
dataTest<-dataTest[, -correlated]


#classModel_RF <-train(x=data[, -42], y=data[, 42], method="rf", trControl = trainControl(method = "cv", number=4, allowParallel = TRUE))
