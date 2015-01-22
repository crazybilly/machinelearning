# libraries ---------------------------------------

library(muadc);  # available at http://github.com/crazybilly/muadc
library(dplyr); library(tidyr); 
library(stringr); library(lubridate); library(magrittr); 

library(caret)

# data --------------------------------------------

if (!exists("training")) {
   if(!file.exists("data/pml-training.csv")) {
      download.file("data/pml-training.csv",url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
   }
   training <- read.csv("data/pml-training.csv",)  %>% 
      tbl_df
}

if (!exists("quiz")) {
   if(!file.exists("data/pml-testing.csv")) {
      download.file("data/pml-testing.csv",url="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")
   }
   quiz <- read.csv("data/pml-testing.csv")  %>% 
      tbl_df
}
