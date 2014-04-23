#USDA Example
#read csv
USDA = read.csv("USDA.csv")
rm(WHO)
rm(outliers)

str(USDA)
summary(USDA)

which.min(USDA$VitaminD)
USDA$Description[13]

which.max(USDA$Cholesterol)
USDA$Description[3534]

summary(USDA$Sodium)
which.max(USDA$Sodium)
USDA$Description[265]

#check the names of the columns in a variable
names(USDA)

#check the food with sodium level greater than 10000
HighSodium = subset(USDA, Sodium > 10000)

HighSodium$Description
#suppose you thought Caviar should have been in top 10 with high sodium but it doesnt appear in the list
#you can ask R to give you the index of Caviar by match function as below

match("CAVIAR",USDA$Description)

#you can wrap this up in one function like
USDA$Sodium[match("CAVIAR", USDA$Description)]
#it gives you the answer 1500
#Now, the value 1,500 milligrams seems to be very small compared to 10,000 milligrams or 38,000
#milligrams, which are the values that we worked with so far with respect to sodium levels.
#But this doesn't seem to be a fair comparison. Maybe the best way to figure out how big this value is,
#is by comparing it to the mean and the standard deviation of the sodium levels across the data set.

summary(USDA$Sodium)
#mean is 322.1

sd(USDA$Sodium, na.rm = TRUE)
#sd is 1045.417

#Note that, if we sum the mean and the standard deviation,we obtain around 1,400 milligrams, which
#is still smaller than the amount of sodium in 100 grams of caviar.
#well, this means that caviar is pretty rich in sodium compared to most of the foods in our data set.

#VISUALISATION
#scatter plots are great! Let us first create a scatterplot with Protein
#on the x-axis and Fat on the y-axis.

plot(USDA$Protein, USDA$TotalFat, xlab = "Protein", ylab = "Total Fat", main = "Protein Vs Total Fat", col = "red")

#we can also check the distributions of a variable by histograms
hist(USDA$VitaminC, xlab="Vitamin C", ylab="Frequency", col = "green")

#we know that the max Vitamin C we have is 2400 but mostly our data (over 6000) is up to 200
#we can zoom in by simply adding additional option of xlim (x limit)

hist(USDA$VitaminC, xlab="Vitamin C", ylab="Frequency", col = "green", xlim=c(0,100))

#It seems that R only zoomed into the area, but it didn't break that huge cell,
#and this doesn't give us any additional information. we can break the cell by:

hist(USDA$VitaminC, xlab="Vitamin C", ylab="Frequency", col = "green", xlim=c(0,100), breaks = 2000)

boxplot(USDA$Sugar, main = "Box plot of Sugar level", ylab = "Sugar in gm")

summary(USDA$VitaminC)

#adding a new variable in the dataframe
#suppose if we want to see if the sodium level is greater then the mean then add 0 or 1 otherwise

USDA$Sodium [1] > mean(USDA$Sodium, na.rm=TRUE)
#this shows the answers in true of false...the best way is to store in an additional variable

HighSodium = USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE)
str(HighSodium)
#this shows the results in true or false but we want 0 or 1
HighSodium = as.numeric(USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE))
#now add this to the existing dataframe by:
USDA$HighSodium = as.numeric(USDA$Sodium > mean(USDA$Sodium, na.rm=TRUE))
str(USDA)
#similarly we can add more columns like:
USDA$HighProtein = as.numeric(USDA$Protein > mean(USDA$Protein, na.rm=TRUE))
USDA$HighCarbs=as.numeric(USDA$Carbohydrate > mean(USDA$Carbohydrate, na.rm=TRUE))
USDA$HighFat=as.numeric(USDA$TotalFat > mean(USDA$TotalFat, na.rm=TRUE))
#if we want to check the relationships among the variables we can use tables and tapply functions
#To figure out how many foods have higher sodium level than average, we want to look at the HighSodium variable
#and count the foods that have values 1.We can do this using the table function, and give it as an input the HighSodium vector.

table(USDA$HighSodium)
#this shows that 4884 have less sodium than mean and 2090 have more sodium than mean

#we can now see how many foods have both high sodium and high fat
#to do this we can also use the table function,but instead of giving it one input, now
#we can give it two inputs.

table(USDA$HighSodium,USDA$HighFat)

#The rows belong to the first input, which is HighSodium,and the columns correspond to the second 
#input,which is HighFat.So from the table we see that we have 3,529 foods with low sodium and low fat,
#1,355 foods with low sodium and high fat, 1,378foods with high sodium but low fat,
#and finally 712 foods with both high sodium and high fat.

#Now, what if we want to compute the average amount of iron sorted by high and low protein?
#Well, to do this we can use the tapply function.

