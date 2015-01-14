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


# exploratory analysis ----------------------------------------------------


# what percent of the column is useless data (either NA, an empty string or our old Excel friend "DIV/O")
percentNA  <- apply(training,2,function(x) sum(is.na(x) | grepl("DIV\\/0",x) | grepl("$^",x))/length(x)  )

# keep the columns that are at least 30% full of useful data
columnstouse  <- percentNA <.7


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



