## Heidi Hautakangas
## 5.2.2017
## Introduction to Open Data Science Week 3: Data wrangling 
## This week we are learning to combine different datasets
## Data source: https://archive.ics.uci.edu/ml/machine-learning-databases/00356/

# set working directory
setwd("~/Documents/IODS-project")

# read data sets into R
MAT <- read.csv("data/student-mat.csv", header = T, as.is=T, sep=";")
POR <- read.csv("data/student-por.csv", as.is=T, header=T, sep=";")

# check the data: structures, dimensions, names etc.
head(MAT)
head(POR)
str(MAT)
dim(MAT)
str(POR)
dim(POR)

install.packages("dplyr")
library(dplyr)

#Join datasets together by using following colums as student identifier:
# "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" 
# and differentiate source of a variable with either .MAT or .POR
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

BOTH <- inner_join(MAT, POR, by = join_by, suffix=c(".MAT",".POR"))

# check colnames and dimension of the joined data
colnames(BOTH)
dim(BOTH)

# combine duplicated answers

#  first create a new data frame with only the joined columns
ALC <- select(BOTH, one_of(join_by))
names(ALC)
head(ALC)
#  and collect the names of the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(MAT)[!colnames(MAT) %in% join_by]
notjoined_columns

# Then by using the R script from the data camp:
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(BOTH, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    ALC[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    ALC[column_name] <- first_column
  }
}

# glimpse data
glimpse(ALC)
head(ALC)

# new column alc_use: an average of weekday and weekend alcohol use
ALC <- mutate(ALC, alc_use = (Dalc + Walc) / 2)

# a new logical column 'high_use' ( TRUE when more than 2)
ALC <- mutate(ALC, high_use = alc_use > 2)
# glimpse the data and check that the dimeonsion is right (382  35)
head(ALC)
dim(ALC)
glimpse(ALC)

# save data
write.table(ALC, "data/alcohol.txt", quote=FALSE, row.names = FALSE, col.names = T)
