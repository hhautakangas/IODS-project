## Heidi Hautakangas, 29.01.2017
## Week 2: Regression and model validation

# DATA WRANGLING

# 2. Read data 

LEARN <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", as.is=T, header=T)
dim(LEARN)
str(LEARN)

attach(LEARN)
# Data contains 183 observations and 60 variables. 59 variables are integers and one variable is character.

# 3. Subsetting data gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data
# check names
names(LEARN)

# create new variable Deep (back to original scale divide by 12)
d_sm <- D03+D11+D19+D27
d_ri <- D07+D14+D22+D30
d_ue <- D06+D15+D23+D31

LEARN$Deep <- (d_sm+d_ri+d_ue)/12

# create new variable Surf (back to original scale divide by 12)
su_lp <- SU02+SU10+SU18+SU26
su_um <- SU05+SU13+SU21+SU29
su_sb <- SU08+SU16+SU24+SU32

LEARN$Surf <- (su_lp+su_um+su_sb)/12

#create new variable Stra (back to original scale divide by 8)
st_os <- ST01+ST09+ST17+ST25
st_tm <- ST04+ST12+ST20+ST28

LEARN$Stra <- (st_os+st_tm)/8

# create subset that contains following variables: gender, Age, Attitude, Points, Deep, Stra, Surf
# and exclude observations where points is zero
LEARNsub <- subset(LEARN, Points != 0, select=c(gender, Age, Attitude, Points, Deep, Stra, Surf))

# check subset dimension, should be 166 obs and 7 variables
dim(LEARNsub)

# 3. Set iods folder as working directory
setwd("~/Documents/IODS-project")

# write subset as a new file in the data folder
write.table(LEARNsub, "~/Documents/IODS-project/data/learning2014sub.txt", quote=FALSE, row.names = FALSE, col.names = TRUE)

# read data again
LEARNsub2 <- read.table("data/learning2014sub.txt", as.is=TRUE, header=TRUE)

# check that the structure is ok
str(LEARNsub2)
head(LEARNsub2)
