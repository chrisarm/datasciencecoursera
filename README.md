#Getting and Cleaning Data

The script **run_analysis.R** summarizes data obtained from the UCI Human Activity Recognition Using Smartphones Data Set. The script combines both the test and the training data then groups it by the subject who carried the phone as well as the activity identified.  Finally the script calculates an average of for each of the mean and standard deviation variables in the grouped data.

*All other scripts wish they were at least as cool as this script.*

**Data**
1. Two sets of measurement data(X): test/X_test.txt and train/X_train.txt
2. Two sets of activity data(y): test/y_test.txt and train/y_train.txt
3. Subject data for test and train: test/subject_test.txt and train/subject_train.txt
4. Column names for measurements data(X): features.txt
5. Labels for activity data(y): activity_labels.txt

**Transformations**
1.  Read in measurement data and use column names from features.txt
2.  Extract only the measurements on the mean and standard deviation for each measurement (This is determined by a regular expression match to ".*([mM]ean)|([sS]td).*" which finds the words mean and std indicating the desired columns
3.  Join the activity labels to the activity data(y)
4.  Merges the training and the test sets to create one data set.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
