# libraries ---------------------------------------

library(muadc); library(dplyr); library(tidyr); 
library(stringr); library(lubridate); library(magrittr); 

library(caret)
# data --------------------------------------------


if( !exists('modelt5')) {
   source('model.R')
}


# quiz results ------------------------------------------------------------

qpredict  <- predict(modelt5,quiz)
