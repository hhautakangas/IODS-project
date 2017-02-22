# DATA WRANGLING weeks 4 and 5
# Heidi Hautakangas
# Human data, original sources:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv






# DATA WRANGLING week 4
# read both datas to R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

## structure, dimension and summary
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

#check names and rename variables to both data
names(hd)

names(hd)[1]<-"HDIrank"
names(hd)[3]<-"HDI"
names(hd)[4]<-"life-expectancy"
names(hd)[5]<-"education_exp"
names(hd)[6]<-"education_mean"
names(hd)[7]<-"GNIperCapita"
names(hd)[8]<-"GNIindex"

names(gii)[1]<-"GIIrank"
names(gii)[3]<-"GII"
names(gii)[4]<-"MaternalMort"
names(gii)[5]<-"BirthRate"
names(gii)[6]<-"ParliamentRep"
names(gii)[7]<-"SecEduF"
names(gii)[8]<-"SecEduM"
names(gii)[9]<-"LabourPartF"
names(gii)[10]<-"LabourPartM"

# Mutate new variables 
# the ratio of Female and Male populations with secondary education
gii <- mutate(gii, edu2_ratio = (SecEduF/SecEduM))
#the ratio of labour force participation of females and males
gii <- mutate(gii, labourP_ratio = (LabourPartF/LabourPartM))

library(dplyr)

# join the data set and save it to data folder
BOTH <- inner_join(hd, gii, by = "Country", suffix=c(".hd",".gii"))
head(BOTH)
write.table(BOTH,"data/human.txt", quote=FALSE, row.names=FALSE)

## DATA WRANGLING week 5

#rename data
HUM <- BOTH
head(HUM)
str(HUM)
library(stringr)

## mutate GNI to numeric
HUM$GNI <- as.numeric(HUM$GNIindex)

# I rename again the variables to match names in exercise instructions
names <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

names(HUM)[18]<-"Edu2.FM"
names(HUM)[17]<-"Labo.FM"
names(HUM)[5]<-"Edu.Exp"                                                                                                                                                                        
names(HUM)[4]<-"Life.Exp"
names(HUM)[11]<-"Mat.Mor"
names(HUM)[12]<-"Ado.Birth"
names(HUM)[13]<-"Parli.F"
names(HUM)

## create a subset that contains only variables: "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
HUM2<- select(HUM, one_of(names))
head(HUM2)
names(HUM2)
## remove NA??s
# i prefer to use na.omit command,  because it does the same thing in one step as we did in the data camp exercises 
# all incomplete cases are filtered out and only complete cases left
HUM2b<-na.omit(HUM2)
str(HUM2b)
tail(HUM2b)

# next there were asked to remove all observations which relate to regions instead of countries
# but there is no such observations in my data, since they were filtered all ready in the previous steps because of
# containing missing values (7 last observations in the HUM data)

# Next set country as a row name and then remove the country variable
rownames(HUM2b) <- HUM2b$Country
HUM2b<- HUM2b[,2:9]
dim(HUM2b)
# data has now 155 observations and 8 variables instead of 9 as the exercise info says,
# because the country column was removed (and the original subset was supposed to contain only those 9 columns listed)
# (and also already mutated data provided for the analysis contains 8 variables instead of 9)

# save data
write.table(HUM2b, "data/human.txt", quote=F, row.names = T, col.names = T)

