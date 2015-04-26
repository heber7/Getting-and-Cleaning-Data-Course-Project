##Cleaning data

setwd("C:/Users/heber_000/Documents/Coursera/(03) Getting Cleaning Data/data/Project")
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
##List all variables:
unzip(temp, list = TRUE)

YTest <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"))
XTest <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"))
SubjectTest <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"))
YTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
XTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
SubjectTrain <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
Features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
unlink(temp)

## Adjust names on columns
colnames(XTrain) <- t(Features[2])
colnames(XTest) <- t(Features[2])

## Merging X & Y data
XTrain$activities <- YTrain[, 1] 
XTrain$Volunteers <- SubjectTrain[, 1]
XTest$activities <- YTest[, 1]
XTest$Volunteers <- SubjectTest[, 1]


## Step1: Merges the training and the test sets to create one data set (x,sub,y)

Consol <- rbind(XTrain, XTest)
duplicated(colnames(Consol))
Consol <- Consol[, !duplicated(colnames(Consol))]

## Step2: Extracts only the measurements on the mean and standard deviation for each measurement.

#For Mean
Mean <- grep("mean()", names(Consol), value = FALSE, fixed = TRUE)
Mean <- append(Mean, 471:477)
InstrumentMeanMatrix <- Consol[Mean]
# For Standard deviation
STD <- grep("std()", names(Consol), value = FALSE)
InstrumentSTDMatrix <- Consol[STD]

## Step3: Uses descriptive activity names to name the activities in the data set

Consol$activities <- as.character(Consol$activities)
Consol$activities[Consol$activities == 1] <- "WALKING"
Consol$activities[Consol$activities == 2] <- "WALKING_UPSTAIRS"
Consol$activities[Consol$activities == 3] <- "WALKING_DOWNSTAIRS"
Consol$activities[Consol$activities == 4] <- "SITTING"
Consol$activities[Consol$activities == 5] <- "STANDING"
Consol$activities[Consol$activities == 6] <- "LAYING"
Consol$activities <- as.factor(Consol$activities)


## Step4: Appropriately labels the data set with descriptive variable names.

##gsub perform replacement of the first and all matches respectively

names(Consol) <- gsub("Acc", "Accelerator", names(Consol))
names(Consol) <- gsub("Mag", "Magnitude", names(Consol))
names(Consol) <- gsub("Gyro", "Gyroscope", names(Consol))
names(Consol) <- gsub("^t", "time", names(Consol))
names(Consol) <- gsub("^f", "frequency", names(Consol))

#re-name the Volunteers

Consol$Volunteers <- as.character(Consol$Volunteers)
Consol$Volunteers[Consol$Volunteers == 1] <- "Volunteer 01"
Consol$Volunteers[Consol$Volunteers == 2] <- "Volunteer 02"
Consol$Volunteers[Consol$Volunteers == 3] <- "Volunteer 03"
Consol$Volunteers[Consol$Volunteers == 4] <- "Volunteer 04"
Consol$Volunteers[Consol$Volunteers == 5] <- "Volunteer 05"
Consol$Volunteers[Consol$Volunteers == 6] <- "Volunteer 06"
Consol$Volunteers[Consol$Volunteers == 7] <- "Volunteer 07"
Consol$Volunteers[Consol$Volunteers == 8] <- "Volunteer 08"
Consol$Volunteers[Consol$Volunteers == 9] <- "Volunteer 09"
Consol$Volunteers[Consol$Volunteers == 10] <- "Volunteer 10"
Consol$Volunteers[Consol$Volunteers == 11] <- "Volunteer 11"
Consol$Volunteers[Consol$Volunteers == 12] <- "Volunteer 12"
Consol$Volunteers[Consol$Volunteers == 13] <- "Volunteer 13"
Consol$Volunteers[Consol$Volunteers == 14] <- "Volunteer 14"
Consol$Volunteers[Consol$Volunteers == 15] <- "Volunteer 15"
Consol$Volunteers[Consol$Volunteers == 16] <- "Volunteer 16"
Consol$Volunteers[Consol$Volunteers == 17] <- "Volunteer 17"
Consol$Volunteers[Consol$Volunteers == 18] <- "Volunteer 18"
Consol$Volunteers[Consol$Volunteers == 19] <- "Volunteer 19"
Consol$Volunteers[Consol$Volunteers == 20] <- "Volunteer 20"
Consol$Volunteers[Consol$Volunteers == 21] <- "Volunteer 21"
Consol$Volunteers[Consol$Volunteers == 22] <- "Volunteer 22"
Consol$Volunteers[Consol$Volunteers == 23] <- "Volunteer 23"
Consol$Volunteers[Consol$Volunteers == 24] <- "Volunteer 24"
Consol$Volunteers[Consol$Volunteers == 25] <- "Volunteer 25"
Consol$Volunteers[Consol$Volunteers == 26] <- "Volunteer 26"
Consol$Volunteers[Consol$Volunteers == 27] <- "Volunteer 27"
Consol$Volunteers[Consol$Volunteers == 28] <- "Volunteer 28"
Consol$Volunteers[Consol$Volunteers == 29] <- "Volunteer 29"
Consol$Volunteers[Consol$Volunteers == 30] <- "Volunteer 30"
Consol$Volunteers <- as.factor(Consol$Volunteers)

#Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
Consol.dt <- data.table(Consol)
TidyData <- Consol.dt[, lapply(.SD, mean), by = 'Volunteers,activities']
write.table(TidyData, file = "Tidydatset.txt", row.names = FALSE)

