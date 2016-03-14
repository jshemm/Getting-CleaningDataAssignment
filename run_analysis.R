output <- function(dir) {
    #This function operates on the UCI Human Activity Recognition Using Smartphones Data Set
    #The function:
    #   1. Merges the training and test data sets.
    #   2. Extracts only the variables on the mean and standard deviation for each signal measurement.
    #   3. Uses descriptive activity names to name the activities in the data set.
    #   4. Appropriately labels the data set with descriptive variable names.
    #   5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    # 1. Merge training and test data sets.
    train_data <- "train/X_train.txt"; train_labels <- "train/y_train.txt"
    test_data <- "test/X_test.txt"; test_labels <- "test/y_test.txt"
    training <- read.table(train_data) #read training data
    trainingLabels <- read.table(train_labels)
    training[,length(training)+1] <- trainingLabels
    test <- read.table(test_data) #read test data
    testLabels <- read.table(test_labels)
    test[,length(test)+1] <- testLabels
    TTdata <- merge(training, test, all = T) #merge the data sets
    rm("training", "test") #remove original data sets
    vars <- read.table("features.txt") #read variable names
    
    # 4. Appropriately label the data set with descriptive variable names.
    names(TTdata) <- vars$V2 #assign var names to data set
    names(TTdata)[562] <- "Labels"
    
    # 2. Extract only the variables on the mean and standard deviation for each signal measurement.
    a <- grep("mean[^Freq]()|std[^Freq]()", vars$V2) #vars with mean() or std() in title
    mnsdTTdata <- TTdata[c(a,562)]
    
    # 3. Use descriptive activity names to name the activities in the data set.
    actLabels <- read.table("activity_labels.txt")
    mnsdTTdata$Labels <- actLabels$V2[mnsdTTdata$Labels]
    
    #  5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
    NDF <- data.frame(matrix(data = NA, nrow = 6, ncol = 66))
    for (i in 1:length(actLabels$V2)) {
        NDF[i,1:66] <- colMeans(mnsdTTdata[mnsdTTdata$Labels==actLabels$V2[i],mnsdTTdata$Labels[1:66]])
    }
    names(NDF) <- vars$V2[a] #assign var names to data set
    NDF$Labels <- actLabels$V2
    return(NDF)
}