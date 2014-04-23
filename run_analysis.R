#this program is assignmen solution for coursera getting and cleaning data course

#solution starts here
##1: Merges the training and the test sets to create one data set.
#read program
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

vName = read.table("UCI HAR Dataset/features.txt")
vName = vName[,2]

# correctly name the columns of the data
names(xTrain) <- vName
names(xTest) <- vName

## Merge Test and Train
xMatrix <- rbind(xTest,xTrain)
yLabel <- rbind(yTest,yTrain) 


#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# only keep means and standard deviation variables

onlyMeanSd <- c(sort(c(grep("std()", vName),grep("mean()",vName))))
reducedMatriX <- xMatrix[,onlyMeanSd]

##3. Uses descriptive activity names to name the activities in the data set

# Activity lables read
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt"); 

##4. Appropriately labels the data set with descriptive activity names
yLabelLabels<-vector(mode="character", length=length(yLabel))

# annotating and writing yLable for each activity
for(i in 1:6){
  index <- which(yLabel==i)
  yLabelLabels[index] <- as.character(activityLabels[i,2])
}


## function for adding subject in the dataset
addSubject <- function(x){return(paste("Subject", as.character(x), sep=""))}

# apply said function to every element 
subjectNamesTest<- sapply(subjectTest, FUN<-addSubject)
subjectNamesTrain<- sapply(subjectTrain, FUN<-addSubject)

# also merge the test and train subject names
subNames <- rbind(subjectNamesTrain, subjectNamesTest)

newDataSet <- matrix(ncol=length(names(reducedMatriX)), nrow=length(unique(subNames)))

rownames(newDataSet) <- unique(subNames)
colnames(newDataSet) <- names(reducedMatriX)

#unique subject names from subjects
uniqueSubjectNames<-unique(subNames)

#repeat for each unique subject and calculate the mean for the observations
for(i in rep(1:length(uniqueSubjectNames))){
    selected <- which(subNames == uniqueSubjectNames[i])
    colMean <- colMeans(reducedMatriX[selected,])
    newDataSet[i,] <- colMean
}

##5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
write.csv(newDataSet,file="newDataSet.csv")


