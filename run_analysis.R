library(dplyr)
#setwd("/home/Chris/Documents/GetAndCleanData/UCI HAR Dataset/")
meanStdRegex <- ".*([mM]ean)|([sS]td).*" # Regular expression for Mean and Std matches when subsetting columns

#read in feature descriptions
measures <- read.table("features.txt", header=FALSE)

#read in activity descriptions
activityLabels<- read.table("activity_labels.txt",header=FALSE)

#read in test data
testx<-read.table("test/X_test.txt",header=FALSE, col.names = measures$V2)
testy<-read.table("test/y_test.txt",header=FALSE)
testSubjects<-read.table("test/subject_test.txt")

#subset only the mean and standard deviation measurement columns
testx<-subset(testx, select=grep(meanStdRegex, names(testx)))

#join activity descriptions to test activities identified
testy<-inner_join(testy, activityLabels, by="V1")

#append subject and activity columns
testx$subject <- testSubjects$V1
testx$activityID <- testy$V2

#Cleanup items no longer needed
rm(testSubjects)
rm(testy)

print("Finished with test data...")

#read in training data
trainx<-read.table("train/X_train.txt",header=FALSE, col.names = measures$V2)
trainy<-read.table("train/y_train.txt",header=FALSE)
trainSubjects<-read.table("train/subject_train.txt")

#subset only the mean and standard deviation measurement columns
trainx<-subset(trainx, select=grep(meanStdRegex, names(trainx)))

#join activity descriptions to training activities identified
trainy<-inner_join(trainy, activityLabels, by="V1")

#append subject and activity columns 
trainx$subject <- trainSubjects$V1
trainx$activityID <- trainy$V2

#Cleanup items no longer needed
rm(trainSubjects)
rm(trainy)
rm(measures)
rm(activityLabels)

print("Finished with training data...")

#append test table to training table
allData<-rbind(testx,trainx)

#Cleanup items no longer needed
rm(testx)
rm(trainx)

#Create second tidy data set for summarizing averages of all variables for each subject and activity
by_subject_activity <- group_by(allData, subject, activityID) %>% summarize_each(funs(mean),-c(subject,activityID))

#save resulting files
#saveRDS(by_subject_activity, file="by_subject_activity")
#saveRDS(allData, file = "allData.RDS")
write.table(by_subject_activity, file="tidy_by_subject_activity.tbl", row.names = FALSE)