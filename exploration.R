# libraries ---------------------------------------

library(muadc); library(dplyr); library(tidyr); 
library(stringr); library(lubridate); library(magrittr); 
library(caret)

# setup -------------------------------------------------------------------

if (!exists('training')) {
   source('loaddata.R')
}

# kitchen sink analsysis for a baseline ------------------------------------------
   # here we're getting 78% accuracy, which is nothing to sneeze at
modelrpart  <- train(classe ~ ., data = training,method='rpart')
   # 
modelrf  <- train(classe ~ ., data = training, method='rf')


# exploratory analysis ----------------------------------------------------

factorcolumns  <- lapply(t2,function(x) if(is.factor(x)) levels(x)  )

# due to goofiness, these came across as factors, rather than numeric
   # fix them up
training$kurtosis_roll_belt <- as.numeric(as.character(training$kurtosis_roll_belt))
training$skewness_roll_belt <- as.numeric(as.character(training$skewness_roll_belt))
training$max_yaw_belt <- as.numeric(as.character(training$max_yaw_belt))
training$min_yaw_belt <- as.numeric(as.character(training$min_yaw_belt))
training$amplitude_yaw_belt <- as.numeric(as.character(training$amplitude_yaw_belt))
training$kurtosis_yaw_arm <- as.numeric(as.character(training$kurtosis_yaw_arm))
training$skewness_yaw_arm <- as.numeric(as.character(training$skewness_yaw_arm))
training$kurtosis_roll_dumbbell <- as.numeric(as.character(training$kurtosis_roll_dumbbell))
training$kurtosis_picth_dumbbell <- as.numeric(as.character(training$kurtosis_picth_dumbbell))
training$skewness_roll_dumbbell <- as.numeric(as.character(training$skewness_roll_dumbbell))
training$skewness_pitch_dumbbell <- as.numeric(as.character(training$skewness_pitch_dumbbell))
training$max_yaw_dumbbell <- as.numeric(as.character(training$max_yaw_dumbbell))
training$min_yaw_dumbbell <- as.numeric(as.character(training$min_yaw_dumbbell))
training$amplitude_yaw_dumbbell <- as.numeric(as.character(training$amplitude_yaw_dumbbell))


# what percent of the column is useless data (either NA, an empty string or our old Excel friend "DIV/O")
percentNA  <- apply(training,2,function(x) sum(is.na(x) | grepl("DIV\\/0",x) | grepl("$^",x))/length(x)  )

# dump the columns that are 98% empty data
columnstouse  <- percentNA < .98
# nix the useless columns (dates & time stamps, row indexes)
columnstouse[1]  <- F # X
columnstouse[3]  <- F # raw_timestamp_part_1
columnstouse[4]  <- F # raw_timestamp_part_2
columnstouse[5]  <- F # cvtd_timestamp
columnstouse[6]  <- F # new_window
columnstouse[7]  <- F # num_window


t2  <- training[,columnstouse]


# rpart2 ------------------------------------------------------------------
   # here, we're getting only 50% accuracy which is a pretty significant drop
   # so, let's reject this method. Too bad.

modelpart2  <- train(classe ~
                        user_name +roll_belt +pitch_belt +
                        yaw_belt +total_accel_belt +
                        gyros_belt_x + gyros_belt_y + gyros_belt_z + 
                        accel_belt_x + accel_belt_y + accel_belt_z + 
                        magnet_belt_x + magnet_belt_y + magnet_belt_z +
                        roll_arm + pitch_arm + yaw_arm + total_accel_arm +
                        gyros_arm_x + gyros_arm_y + gyros_arm_z +
                        accel_arm_x + accel_arm_y + accel_arm_z +
                        magnet_arm_x + magnet_arm_y + magnet_arm_z + 
                        roll_dumbbell + pitch_dumbbell + yaw_dumbbell + 
                        total_accel_dumbbell + gyros_dumbbell_x + 
                        gyros_dumbbell_y + gyros_dumbbell_z + accel_dumbbell_x + 
                        accel_dumbbell_y + accel_dumbbell_z + magnet_dumbbell_x + 
                        magnet_dumbbell_y + magnet_dumbbell_z +
                        roll_forearm + pitch_forearm + yaw_forearm + 
                        total_accel_forearm + gyros_forearm_x + 
                        gyros_forearm_y + gyros_forearm_z + accel_forearm_x +
                        accel_forearm_y + accel_forearm_z + magnet_forearm_x + 
                        magnet_forearm_y + magnet_forearm_z +  magnet_forearm_z
                     , data = training,method='rpart')


# rpart3 ------------------------------------------------------------------



modrf3  <- train(t2[,1:134],t2$classe,method='rf')

# notes -------------------------------------------------------------------

# X is just the index. It is not a predictor, so drop it.
# the timestamps aren't relevant.
   training$raw_timestamp_part_1
   training$raw_timestamp_part_2
   training$cvtd_timestamp
# no clue what these window things are, but they're largely useless too
   training$num_window
   training$new_window

# came over as factors, but should be numeric
kurtosis_roll_belt
skewness_roll_belt
max_yaw_belt
min_yaw_belt
amplitude_yaw_belt
kurtosis_yaw_arm
skewness_yaw_arm
kurtosis_roll_dumbbell
kurtosis_picth_dumbbell
skewness_roll_dumbbell
skewness_pitch_dumbbell
max_yaw_dumbbell
min_yaw_dumbbell
amplitude_yaw_dumbbell


