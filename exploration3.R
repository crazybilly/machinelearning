# libraries ---------------------------------------

library(muadc); library(dplyr); library(tidyr); 
library(stringr); library(lubridate); library(magrittr); 
library(caret)

# data --------------------------------------------

if( !exists('training')) {
   source('loaddata.R')
}


segment  <- createDataPartition(training$classe,p=.8,list=F)

train  <- training[segment, ]
test   <- training[-segment,]


# dump useless columns ----------------------------------------------------


uselessnames  <- c(  "X", "user_name"
                     , "raw_timestamp_part_1", "raw_timestamp_part_2"
                     , "cvtd_timestamp"
                     , "new_window", "num_window"
)
useless  <- sapply(names(train),function(x) {as.logical(sum(x == uselessnames))})  %>% 
   as.vector
t2 <- train[,!useless] 


# numeric to factors ------------------------------------------------------


t3m  <- apply(t2[,1:ncol(t2)-1],2,function(x) as.numeric(as.character(x)))
t3  <- as.data.frame.matrix(t3m)
t3$classe  <- t2$classe



# identify zeroVariation columns ------------------------------------------

nearZero  <- nearZeroVar(t3)
t4  <- t3[,-nearZero]


# percent NA --------------------------------------------------------------

percentNA  <- apply(t4,2,function(x) sum(is.na(x) | grepl("DIV\\/0",x) | grepl("$^",x))/length(x)  )
percentNAindex  <- percentNA < .97

t5  <- t4[,percentNAindex]

