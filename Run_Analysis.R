library(plyr)
library(dplyr)

#### STEP 1: MERGE THE TRAINING AND TESTING SETS TO CREATE ONE DATA SET ####

## Read in features and activity labels data. Makes sure to set 
## StstringsAsFactors=FALSE), so that the features and activity labels can be read
## as character vectors

features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                             stringsAsFactors=FALSE)

## Read in test data: X_test.txt, y_test.txt, subject_test.txt

testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## None of the three dataframes have variable names.
## Use names function to change them

names(testX) <- features$V2  ## V2 is a character vector of feature names
names(subjectTest) <- "subjectID"
names(testY) <- "activity"

## Combine the three dataframes together. Order so that the leftmost is
## subjectTest, followed by testY, followed by testX

testDf <- cbind(subjectTest, testY, testX)


## Read in train data: X_train.txt, y_train.txt, subject_train.txt

trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## None of the three dataframes have variable names.
## Use names function to change them

names(trainX) <- features$V2 ## Use the same vector of character names as above
names(subjectTrain) <- "subjectID"
names(trainY) <- "activity"

## Combine the three dataframes together. Order so that the leftmost variable is
## subjectID, followed by activity, followed by the features

trainDf <- cbind(subjectTrain, trainY, trainX)

### Combine, by rbinding testDf to the bottom of trainDf

combinedDf <- rbind(trainDf, testDf)


#### STEP 2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STD ####

## Use make.names to insure that the variable names extracted from features are
## valid

valid_column_names <- make.names(names=names(combinedDf), unique=TRUE, 
                                 allow_ = TRUE)
names(combinedDf) <- valid_column_names

## Use the dplyr function select to select the subject and activity variables,
## as well as the mean and std variables for each measurement
combinedDf <- select(combinedDf, subjectID, activity, contains("mean.."), 
                       contains("std.."), -contains("gravitymean"))
length(names(combinedDf)) # 68


#### STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE ####
#### DATASET

## Use 2 step process where 1. the activity variable is coerced to be a factor
## 2. Use mapvalues function from plyr package to replace levels with those
## extracted from the activityLabels data frame

combinedDf$activity <- as.factor(combinedDf$activity) # coerce to factor
combinedDf$activity <- mapvalues(combinedDf$activity, 
                                   from = levels(combinedDf$activity), # 1,2,3 etc
                                   to = activityLabels$V2) # WALKING, etc. 

#### STEP4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES ####

## Descriptive variable names already assigned in step 1-2
## Use gsub to remove unneccessary periods

names(combinedDf) <- gsub("\\.", "", names(combinedDf))


#### STEP 5: CREATE A 2ND TIDY DATASET WITH THE AVE OF EACH VARIABLE FOR EACH ####
#### ACTIVITY SET

## Using the ddply function, pass subjectID and activity to the .variables 
## argument. Pass numcolwise(mean) to the .fun argument, to take the mean of 
## each numeric column

tidyDf <- ddply(combinedDf, c("subjectID", "activity"), numcolwise(mean))

## write to .txt using the write.table function

write.table(tidyDf, "tidyDf.txt", row.name=FALSE)


