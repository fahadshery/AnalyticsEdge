Country = c("Brazil","China","India","Switzerland","USA") #simple vector holding country names
LifeExpectancy = c(74,76,65,83,79) #simple vector which holds numeric values of Life Expectancy in those countries
Country
CombCountryLifeExp = data.frame(Country, LifeExpectancy) #data frame can hold mixture of values
CombCountryLifeExp

#if add additional column population in CombCountryLifeExp data frame 
Population = c(199000, 1390000, 1240000, 7997, 318000)
CombCountryLifeExp = cbind (CombCountryLifeExp, Population) #columnbind function

#add rows to CombCountryLifeExp data frame
Country = c("Australia","Greece")
LifeExpectancy = c(82,81)
Population = c(23050, 11125)
NewRow = data.frame(Country, LifeExpectancy,Population)
CombCountryLifeExp = rbind(CombCountryLifeExp, NewRow)

#check working directory
getwd()

WHO = read.csv("WHO.csv")
str(WHO)
WHO$Country #factors are catagorical i.e. country region, blood group etc.
summary(WHO)

#divide data e.g. get a subset of WHO where region is Europe
WHOEurope = subset(WHO, Region == "Europe")

#Write this subset to a file
write.csv(WHOEurope, "WHO_Europe.csv")

WHO_Europe

#number of variables we have in memory
ls()

#to remove a variable from memory type
rm(WHOEurope)
rm(WHo)

mean(WHO$Under15)

sd(WHO$Under15)

summary(WHO$Under15)

#check which obs have the minimum under 15 so the 86th observation of under15 have the minimum value of under15
which.min(WHO$Under15)
#check which country had the minimum under15 value by passing the array number in the set
WHO$Country[86] #japan

which.max(WHO$Under15)
WHO$Country[124]

#plot GNI Vs FertilityRate
plot(WHO$GNI,WHO$FertilityRate)

#this plot shows that countries with high income have less fertility rate with the exception of two
#lets find out who these countries are by taking a subset of the data 
#we'll use the subset function to identify the countries with GNI greater than 10,000
#and FertilityRate greater than 2.5.

outliers = subset(WHO, GNI > 10000 & FertilityRate > 2.5)
nrow(outliers)

#check a subset of the data by combine function
outliers[c("Country","GNI","FertilityRate")]

#histogram is for one veriable only, create hist for cellelure subscribers
hist(WHO$CellularSubscribers)

#Let's create a box plot of LifeExpectancy sorted by Region.
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab = "Region", ylab = "Life Expectancy", main = "Life expectancy of countries by Region")

#compute some summary tables, This is similar to what we saw in the summary output
#and counts the number of observations in each category of region.
table(WHO$Region)

#You can see nice information about numerical variables by using the function tapply.
tapply(WHO$Over60, WHO$Region, mean)

#This sorts the data, or each of the countries, by the Region
#and then computes the mean of the variable Over60.
#So tapply computes whatever function name you put as the third argument, in our case, mean.

#if there are missing values you wont be able to use tapply, you need further variable
#na.rm = TRUE

tapply(WHO$LiteracyRate, WHO$Region, min, na.rm = TRUE)
#this now shows that minimum literacy rate in Africa is 31.1 and minimum of 95.2 in Europe

mean(WHO$Over60)
min(WHO$Over60)
which.min(WHO$Over60)
WHO$Country[183]
which.max(WHO$LiteracyRate)            
WHO$Country[44]


getwd()

View(variable name) this will show the results in excel type format