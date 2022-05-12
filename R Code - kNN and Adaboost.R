df <- read.csv("/Users/nitinfern/Downloads/Data Mining/Project 2/imdb_top_1000.csv")
summary(df)
df$Gross <- gsub(",","",as.character(df$Gross))
df$Gross <- as.numeric(as.character(df$Gross))
df$Runtime <- gsub(" min","",as.character(df$Runtime))
df$Runtime <- as.numeric(as.character(df$Runtime))
df$Released_Year <- as.numeric(as.character(df$Released_Year))

install.packages("visdat")
library(visdat)

vis_miss(df)
df <- na.omit(df)

install.packages('plyr')
library(plyr)

count(df,"Runtime")
Median_Gross <- median(df$Gross)
Median_Gross

boxplot(df$IMDB_Rating, main="IMDB_Rating Boxplot",ylab="IMDB_Rating")
boxplot(df$Meta_score, main="Meta_score Boxplot",ylab="Meta_score")
boxplot(df$Runtime, main="Runtime Boxplot",ylab="Runtime")
boxplot(df$No_of_Votes, main="No_of_Votes Boxplot",ylab="No_of_Votes")
boxplot(df$Released_Year, main="Released_Year Boxplot",ylab="Released_Year")
boxplot(df$Gross, main="Gross Boxplot",ylab="Gross")


normalize <- function(x, na.rm = TRUE) {
    return((x- min(x)) /(max(x)-min(x)))
}

df$Gross <- normalize(df$Gross)
df$IMDB_Rating <- normalize(df$IMDB_Rating)
df$Meta_score <- normalize(df$Meta_score)
df$Runtime <- normalize(df$Runtime)
df$No_of_Votes <- normalize(df$No_of_Votes)
df$Released_Year <- normalize(df$Released_Year)

df1 <- df[,c("Runtime", "IMDB_Rating", "Meta_score", "Released_Year", "No_of_Votes", "Gross")]

x <- df1[1:5]
y <- df1[6]
cor(x, y, method= 'pearson') 

df1 <- df1[,c("Runtime", "IMDB_Rating", "Released_Year", "No_of_Votes", "Gross")]

x <- df1[1:4]
y <- df1[5]
cor(x, y, method= 'pearson')

install.packages("dplyr")
library(dplyr)

Median_Gross <- median(df1$Gross)
Median_Gross

df1 <- df1 %>%
mutate(Gross = ifelse(Gross < Median_Gross,
"0","1"))

df1$Gross = factor(df1$Gross)

plot <- table(df1$Gross)

barplot(plot, main="Gross Revenue", xlab="0 - Below Median, 1 - Equal To or Above Median", ylab="Gross")

df1 <- df1[,c("Runtime", "IMDB_Rating", "Released_Year", "No_of_Votes", "Gross")]

x <- df1[,c("Runtime", "IMDB_Rating", "Released_Year", "No_of_Votes")]

set.seed(123)
train <- sample(1:nrow(df1), 0.75 * nrow(df1)) 
df1_train <- x[train,] 
df1_test <- x[-train,]
target <- df1[train,5]
target_test <- df1[-train,5]

library(class)
knn_model <- knn(df1_train, df1_test,cl=target,k=29)

confusedmatrix <- table(knn_model, target_test)
confusedmatrix

accuracy <- (66+77)/(66+77+21+24)
accuracy
recall <- 66/(66+21)
recall
precision <- 66/(66+24)
precision


install.packages('adabag')
library('caret')
library(adabag)
library(caret)

set.seed(123)
indexes=createDataPartition(df1$Gross, p=.75, list = F)
df1_train <- df1[indexes, ]
df1_test = df1[-indexes, ]

adb_model <- boosting(Gross~., data=df1_train, boos=TRUE, mfinal=10)
result = predict(adb_model, df1_test)
print(result$confusion)

accuracy <- (78+79)/(78+79+15+14)
accuracy
recall <- 79/(79+14)
recall
precision <- 79/(79+15)
precision




