#Load any libraries needed.
library(plyr)

# Step 1 Read in and merge the data sets.
setwd("C:/RCode/GetandCleanData/ClassProject")
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./UCI HAR Dataset/train/y_train.txt")
training_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Merge the training and test sets into combined data sets.
combined_set <- rbind(training_set, test_set)
combined_labels <- rbind(training_labels,test_labels)
combined_subject <- rbind(training_subject,test_subject)

# Give the columns names
names(combined_labels) <-"activity"
names(combined_subject) <- "subject"
# For the data set need to read features for variable names
features <- read.table("./UCI HAR Dataset/features.txt")
names(combined_set)<- features[,2]

# Combine all into one data set now
singledataset <- cbind(combined_labels,combined_subject,combined_set)



# Step 2 Extract measurements on the means and stddev for each measurement

# Get the list of columns that are for mean or stddev data
features_names <- features$V2[grep("mean|std", features$V2)]
features_names <- as.character(features_names)
# Add activity and subject columns
features_names <- c("activity","subject",features_names)

# Keep only the columns we want
singledataset <- singledataset[,features_names]


# Step 3 Use descriptive activity names to name the data set rows
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
combined_labels[,1] <-activities[combined_labels[,1],2]
singledataset[,1] <-activities[combined_labels[,1],2]


# Step 4 give the variables more descriptive names
names(singledataset) <- gsub("(\\(|\\)|-|,|_)", "", names(singledataset))
names(singledataset) <- gsub("mean", "Mean", names(singledataset))
names(singledataset) <- gsub("std", "Std", names(singledataset))
names(singledataset) <- gsub("bodybody", "Body", names(singledataset))
names(singledataset) <- sub("^t", "Time", names(singledataset))
names(singledataset) <- sub("^f", "FFT-", names(singledataset))
names(singledataset) <- gsub("Mag", "Magnitude", names(singledataset))
names(singledataset) <- gsub("Acc", "Acceleration", names(singledataset))
names(singledataset) <- gsub("Freq", "Frequency", names(singledataset))
                             
# Step 5 create a tidy data set

tidy_data <- ddply(singledataset, .(subject, activity), function(x) colMeans(x[, 3:81]))

write.table(tidy_data, "tidy_data.txt",row.name=FALSE)

