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



# function ----------------------------------------------------------------

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
