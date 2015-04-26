# Getting-and-Cleaning-Data-Course-Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set
The Data Set has been stored in `UCI HAR Dataset/` directory.
The `CodeBook.md` code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.
The `run_analysis.R` is the file script that has been for this work. 
The `tidydataset.txt` will be created, on the end of the above script, average of each variable for each activity and each subject. 
###########################
Running the script
Script to Run: run_analysis.R
Output:
## Step0: Transformation to clean up the data collected:
-Download file on a temp folder
-Provide list of variables
-Extract the necessary files for analyses (X,Y, features, and subjects)
-Unlink the temp folder
-Fix Columns names
-Merge the data 

## Step1: Merges the training and the test sets to create one data set (x,sub,y)
## Step2: Extracts only the measurements on the mean and standard deviation for each measurement.
## Step3: Uses descriptive activity names to name the activities in the data set
## Step4: Appropriately labels the data set with descriptive variable names.
## Step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
