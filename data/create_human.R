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
                                                                                                                                                                                                                                                                    