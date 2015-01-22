i# libraries ---------------------------------------

library(muadc); library(dplyr); library(tidyr); 
library(stringr); library(lubridate); library(magrittr); 

library(caret)

# data --------------------------------------------

if( !exists('modelt5')) {
   source('model.R')
}


# cross fold validation ---------------------------------------------------
   # 10 folds
   # average accuracy of 99.9%


foldindex  <- createFolds(training$class)

cvresults  <- lapply(foldindex, function(x) {
   ktruth  <- training$classe[x]
   kpredict  <- predict(modelt5,training[x,])
   postResample(kpredict,ktruth)
}) %>% 
   data.frame
accuracy  <- rowMeans(cvresults)

