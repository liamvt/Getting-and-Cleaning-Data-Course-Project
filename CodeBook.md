# Code Book

The run_analysis.R script outputs the tidy data set **tidyDf.txt**

**tidyDf** contains 68 variables that synthesize data obtained from recording the daily activities of 30 subjects carrying a waist mounted smartphone with embedded sensors
  - There are 2 categorical variables and 66 measurement variables

## Categorical Variables

The first two variables of **tidyDf** are categorical
  - **subjectID**: Indicates one of the thirty subjects
  - **activity**: Indicates which of the following six activities the subject was performing when the measurement was taken
    * Walking
    * Walking Upstairs
    * Walking Downstairs
    * Sitting
    * Standing
    * Laying


## Measurement Variables

The variables from column 3-68 are all measurement variables. Each summarizes a particular measurement taken for each subject.

  - The measurement variables contain five elments and can be decoded using the following key:
    1. time or frequency
      - Variables are prefixed "t" to denote time or "f" to denote frequency
    2. Signal category
      - "Body" or "Gravity"
    3. Signal Type
      - "Acc" for acceleration, "gyro" for gyroscopic, "AccJerk" for linear acceleration, "GyroJerk" for angular velocity
    4. Dimension of magnitude
      - Some of the signals were measured along 3 axials, denoted by "X", "Y" or "Z"
      - Alternatively, variables contain the magnitude of the three-dimensional signals, denoted by "Mag"
    5. Mean or standard deviation
      - The measurement variables estimate either the mean ("mean") or standard deviation ("std") of the particular signal

Example: The variable **tBodyGyroJerkmeanZ** represents the following measurement
  - **t**: time
  - **Body**: body signal category
  - **GyroJerk**: angular velocity
  - **Z**: measurement of Z-dimension
  - **mean**: mean value of the signals recorded
  
## Individual Observations

In the raw data, for a given **subjectID** and **activity** pair (e.g. **subjectID**=12, **activity**=Sitting), there are multiple observations of each measurement variable
  
The tidyDf data set contains the mean of each particular measurement variable for a given pair of the categorical variables
  - Thus, for each **subjectID** (1-30), there are six observations per measurement variable
    - These represent one observation for each of the six **activity** observations (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying)

Example: Row 7, column 3 contains:
  - The mean of the **tBodyAccmeanX** variable, for **subjectID** = 2, while that subject's **activity** is walking
    


