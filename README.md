# Class Assignment
## JHU machine learning Mooc on Coursera

## Executive Summary

The objective of this analysis was to predict whether or not a user was doing a physical exercise correctly or not, based on sensor data.

Using a random forest model on 52 of the available columns, I was able to predict the results with 99.9% accuracy.

## Data sources 

The training data used in this analysis are [available online](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv].

[More information about the original project](http://groupware.les.inf.puc-rio.br/har) can be found online as well. 

## Exploratory Analysis

An intial view of the data made it obvious that there were a few fundamental problems.

### Useless Columns

First, some columns were unhelpful for predictions. These included:

- `X`, a row index
- `user_name`, the name of the subject performing the exercise
- `raw_timestamp_part_1`, a time of when the exercise was performed
- `raw_timestamp_part_2`, a time of when the exercise was performed
- `cvtd_timestamp`, a time of when the exercise was performed
- `new_window`, a time of when the exercise was performed
- `num_window", a time of when the exercise was performed

These columns were ignorned when building the model, as they didn't provide useful information that could be generalized to larger predictions.

### Zero Variance

Many of the remaning columns provided little to no variance and could be ignored in the model, reducing variance in the final model.

```{r}
 nearZeroVar(t3)
 # make a plot showing what's up
 ```

### Null values

Of the columns that still remained, a few were overwhelmingly null. Note that I treated the string "#DIV/O", an error string from Excel, as a null value. The figure below show the percentage of null values for each column. Columns that were 97% null were removed from the analysis.

```{r}
percentNA  <- apply(t4,2,function(x) sum(is.na(x) | grepl("DIV\\/0",x) | grepl("$^",x))/length(x)  )
# make a plot showing what's up
```


## Model Generation

data segmentation
formula
method

## Cross Validation

In order to further validate my model, I tested it with 10-fold cross validation.

The overall prediction rate for each fold was over 99%, with an average accuracy of 99.903% and and average Kappa of 99.877%.

Given an average of 99.9% accuracy across 10 folds of 1962 entries each, we can safely assume that our out of sample error rate should be over 99%.

## Figures
full feature plot??
% NA ~ columnindex
Var ~ columnindex
