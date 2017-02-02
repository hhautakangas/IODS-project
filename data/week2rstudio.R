# read data
setwd("~/Documents/IODS-project")
LEARN <- read.table("data/learning2014sub.txt", as.is=TRUE, header=TRUE)

# attach the data so there is no need to refer to the dataset used
attach(LEARN)
# structure and dimension of the data
dim(LEARN)
str(LEARN)
summary(LEARN)

sum(LEARN$gender == "F")
sum(LEARN$gender == "M")

library(ggplot2)
p1 <- ggplot(LEARN, aes(x = Attitude, y = Points, col = gender))
p1
p2 <- p1 + geom_point()
p2
# add a regression line
p3 <- p2 + geom_smooth(method = "lm")
p3
# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4


pairs(learning2014[-1],col=learning2014$gender)

# access the GGally and ggplot2 libraries
install.packages("GGally")
library(GGally)


# create a more advanced plot matrix with ggpairs()
p <- ggpairs(LEARN, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))

# draw the plot and add title
p
LEARNp <- p + ggtitle("Learning 2014 data summary")
p2


p3 <- p + geom_smooth(method = "lm")
p3
qplot(Attitude, Points, data = LEARN) + geom_smooth(method = "lm")

p4 <- p3 + ggtitle("Student's attitude versus exam points")
p4

## linear regression
# dependent variable Points
# explanatory variables Age, gender and Attitude

lm1 <- lm(Points ~ Age+ gender+ Deep, data=LEARN)
lm1
summary(lm1)

lm1 <- lm(Points ~ Attitude+ gender+ Deep, data=LEARN)
lm1
summary(lm1)

lm3 <- lm(Points ~ Attitude+ Age + Deep, data=LEARN)
lm3
summary(lm3)

lm4 <- lm(Points ~ Attitude+ Stra + Deep, data=LEARN)
lm4
summary(lm4)

lm2 <- lm(Points ~ Attitude, data=LEARN)
lm2
summary(lm2)


plot(Attitude, Points, xlab="Attitude", ylab="Points", main="Attitude vs. Points")
abline(lm2)

## for validation
par(mfrow= c(2,2))
plot(lm2, which=c(1:2,5))

install.packages("knitr")
