# Getting and Cleaning Data Course Project

## This file describes the files and steps used to clean and summarize a dataset of smartphone accelerometer data.

## Project Instructions
The instructions given for the project:

>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

>http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

>Here are the data for the project: 

>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

> You should create one R script called run_analysis.R that does the following. 
>Merges the training and the test sets to create one data set.
>Extracts only the measurements on the mean and standard deviation for each measurement. 
>Uses descriptive activity names to name the activities in the data set
>Appropriately labels the data set with descriptive variable names. 
>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Repository Contents

The files included in this repository are:
**ReadMe.md** which describes all the files and how they are used.
**run_analysis.r** which is the actual R code that cleans and summarizes the data set.
**tidy_data.txt** is the summarized data set and is an output of run_analysis.r
**CodeBook.md** describes the variables in the original data and which variables were selected for summarization.  It also includes all the steps used to clean, merge and summarize the data.

## Steps to replicate this project

1.  Download and unzip the raw data from the source given above.  Unizip the data in your working directory.
2.  The run_analysis.r file needs to be in your working directory.  In the beginning of the file the setwd command needs to be updated with your correct path.
3.  The run_analysis.r file requires the use of the plyr package.
4.  Executing the run_analysis.r produces the tidy_data.txt file which is the average of each variable for each activity and each subject.

 
## Process Used to Clean and Summarize the data set in *run_analysis.r*

1. Load plyr package and set the working directory
2. Read the training and test data sets.
3. Combine the training and test data sets using rbind.
4. For the labels and subject data tables rename the columns as "activity" and "subject" respectively.
5. Read the features.txt file from the raw data to get the variable names for the data.
6. Use cbind to combine the labels, subject, and set datasets into a single dataset called singledataset.  This accomplishes Step 1 of the instructions.
7. From the features.txt data set, use grep to get a list of columns that contain the phrases "mean" or "std".  Those are the columns that will be summarized later.
8. Subset singledataset to only keep those variables that have "mean" or "std" in their names.  This accomplishes Step 2 of the instructions.
9. Read the activity_labels.txt raw data file to get descriptive names for the activities.
10.  Merge the activity_labels.txt data table into singledataset.  This accomplishes Step 3 of the instructions.
11.  Use sub and gsub to give the variables more descriptive names than the original data set.  The substitutions made were:
	* Remove special characters ( ) - , _
	* Replace "mean" with "Mean"
	* Replace "std" with "Std"
	* Replace "bodybody" with "Body"
	* Replace variables starting with "t" to start with "Time" 
	* Replace variables starting with "f" to start with "FFT"
	* Replace "Mag" with "Magnitude"
	* Replace "Acc" with "Acceleration"	
	* Replace "Freq" with "Frequency"
	* This accomplishes Step 4 of the instructions.
12.  Use ddply on singledataset to calculate the colMeans by subject and activity.
13.  Use write.table to create the tidy data set.  This accomplishes Step 5 of the instructions.

