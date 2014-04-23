PeerAssessment3
===============

Contains run_analysis.R


Requirements:

When run_analysis is executed is must be in the same directory as "getdata-projectfiles-UCI HAR Dataset.zip."


------------------------------------------------------------------------------------------------------------------------


How the script works:

-The script first unzips the Samsung zip file into a temporary directory.

-The subject numbers, activity labels, and features for both the training and testing data set are read into dataframes.

-The features labels are input from features.txt. The indices containing the mean() or the std() measures are stored in a vector (indices), and the the features corresponding tto those indices are stored in a vector(features).

-The test and train features are concatenated and all columns are removed that do not have an index in the vector indices;only the columns with a mean() or std() remain.

-The names from the features vector are assigned to the columns in the new data set.

-The subject datasets are concatenated and the sole column that is contained in the new data set is named "subject."

-The activity datasets are concatenated and the numbers are replaced with the activity names from activity_labels.txt.

-All three new datasets are merged together.

-A new data set,tidydata, is created by aggregating the merged dataset based on the mean of all numeric columns by the subject and activity.
 
 -The program returns to the original directory the program was run in.
 
 -tidydata is output to a file named tidydata.txt


------------------------------------------------------------------------------------------------------------------------

Output:

After being run, run_analysis.R will output the tidy data set in a text file named tidydata.txt in the directory it was run from.
