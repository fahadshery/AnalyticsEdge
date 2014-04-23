#Read the dataset mvtWeek1.csv into R, using the read.csv function, and call the data frame "mvt". 
#Remember to navigate to the directory on your computer containing the file mvtWeek1.csv first. 
#It may take a few minutes to read in the data, since it is pretty large. Then, use the str and 
#summary functions to answer the following questions.

mvt = read.csv("mvtWeek1.csv")

str(mvt)
summary(mvt)
getwd()
mvt$Date[1]

DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)

mvt$Month = months(DateConvert)
str(mvt$Month)

mvt$Weekday = weekdays(DateConvert)
str(mvt$Weekday)

mvt$Date = DateConvert
str(mvt)
table(mvt$Month)
mvt$LocationDescription
table(mvt$Month)
match("VEHICLE %", mvt$LocationDescription)
mvt$LocationDescription[22]

table(mvt$Month, mvt$LocationDescription)

table(mvt$LocationDescription, mvt$Month)

tapply(mvt$ID, na.rm= TRUE, mean)
table(mvt$Weekday)

table(mvt$Month, mvt$Arrest)
table(mvt$Arrest, mvt$Month)

jpeg('rplot.jpg')
hist(mvt$Date, breaks=100)
dev.off()

boxplot(mvt$Date ~ mvt$Arrest, main = "Box plot of Date")
#a boxplot, the bold horizontal line is the median value of the data, 
#the box shows the range of values between the first quartile and third quartile, 
#and the whiskers (the dotted lines extending outside the box) show the minimum and maximum values.

sort(table(mvt$LocationDescription))

table(mvt$Year,mvt$Arrest)
2152/(18517+2152)
table(mvt$Arrest, mvt$Year)
1212/(13068+1212)
550/(13542+550)
Top5 = subset(mvt, mvt$LocationDescription == 'PARKING LOT/GARAGE(NON.RESID.)' | mvt$LocationDescription == 'STREET' | mvt$LocationDescription == 'GAS STATION' | mvt$LocationDescription == 'DRIVEWAY - RESIDENTIAL' | mvt$LocationDescription == 'ALLEY')
str(Top5)

#Another way of doing this would be to use the %in% operator in R. 
#This operator checks for inclusion in a set. You can create the same subset by typing 
#the following two lines in your R console:

TopLocations = c("STREET", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", "GAS STATION", "DRIVEWAY - RESIDENTIAL")

Top5 = subset(mvt, LocationDescription %in% TopLocations)

table(Top5$LocationDescription) 

Top5$LocationDescription = factor(Top5$LocationDescription)
str(Top5)

sort(table(Top5$LocationDescription))
sort(table(Top5$LocationDescription, Top5$Arrest))

table(Top5$LocationDescription)

arrest_pct = Top5$Arrest.TRUE / sum(Top5$Arrest.Count)
table(Top5$Year, Top5$Arrest)
table(arrest_pct)

table(Top5)

test = table(Top5$LocationDescription, Top5$Arrest)
str(test)

table(Top5$Weekday, Top5$LocationDescription)

tapply(test, mean)
