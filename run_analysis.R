# Load all data

features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")


# Build the test data set

test <- cbind(subject_test,y_test,X_test)

# Build the train data set

train <- cbind(subject_train,y_train,X_train)

# Part 1: Merge the training and the test sets to create one data set

total_data <- rbind(test,train)

# Part 4: Name all variables with appropriate names

names(total_data) <- c("subject_id", "activity_id", as.character(features[,2]))

# Part 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# The logic used here is to extract anything with 'std' or 'mean' in the variable name, excluding 'meanfreq'

means <- setdiff(grep("Mean", as.character(features[,2]),ignore.case=TRUE),
                 grep("Meanfreq", as.character(features[,2]),ignore.case=TRUE)
                 ) + 2

std <- grep("std", as.character(features[,2]),ignore.case=TRUE) + 2

extract <- append(means,std)

extract <- sort(extract)

data_std_mean <- total_data[,c(1,2,extract)]

#Part 3: Use descriptive activity names to name the activities in the data set

tidy_data <- merge(data_std_mean,activity_labels, by.x = "activity_id", by.y="V1")

# Part 4: Name all variables with appropriate names

colnames(tidy_data)[colnames(tidy_data)=="V2"] <- "activity_name"

tidy_data <- tidy_data[,c(1,ncol(tidy_data),3:ncol(tidy_data)-1)]

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.

require(reshape2)

tidy_data_2 <- melt(tidy_data, id = c("activity_id", "activity_name", "subject_id"))

tidy_data_2 <- dcast(tidy_data_2, activity_name + subject_id ~ variable, mean)
        
# Write out final tidy data set

write.table(tidy_data_2, file = 'tidy_data.txt', row.name=FALSE)
