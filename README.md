GettingandCleaningData
======================


##This repo is for Getting and Cleaning Data coursera assignments.



##solution starts here
1: Merges the training and the test sets to create one data set.
read table X_train.txt,y_train.txt,subject_train.txt,X_test.txt,y_test.txt,subject_test.txt

read file features.txt describing features

Merge Test and Train data in xMatrix and labels of y data in yLabel


Extracting only the measurements on the mean and standard deviation for each measurement. 
onlyMeanSd <- c(sort(c(grep("std()", vName),grep("mean()",vName))))

and reduce the matrix is kept in newmatrix

read activity data from UCI HAR Dataset/activity_labels.txt

label the data set with descriptive activity names

annotate and write yLable for each activity
for(i in 1:6){
  index <- which(yLabel==i)
  yLabelLabels[index] <- as.character(activityLabels[i,2])
}

function for adding subject in the dataset
addSubject <- function(x){return(paste("Subject", as.character(x), sep=""))}


repeat for each unique subject and calculate the mean for the observations and write in the matrix

Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



