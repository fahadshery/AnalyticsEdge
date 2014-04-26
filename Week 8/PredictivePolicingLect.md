Predictive Policing
========================================================

In this lecture, we will discuss how visualization can offer insights in the area of policing in urban environments. The explosion of computerized data affects all parts of society, including policing. In the past, human judgment and experience was the only tool in identifying patterns in criminal behavior. Police forces around the United States and the world are augmenting human judgment with analytics.

Los Angeles police worked for months to catch Manson and his followers. These days the LAPD is on an offensive to prevent crime. Its latest weapon is a computer program that can actually predict where crimes will happen.
And justice correspondent Bob Orr has a first look at the results. In the Foothill Division north of downtown Los Angeles, police are patrolling the largely working-class neighborhoods with specially marked maps. The small red squares are hot spots, where computers project property crimes are most likely. It's called predictive policing.

A program which Captain Sean Malinowski says: puts officers on the scene before crimes occur. 65% of our crimes are burglary, grand theft auto, and burglary for motor vehicle. And that's what these boxes represent. That's a pretty small box, 500 feet by 500 feet. Yes, it is a small area. These crime prediction boxes come from the same kind of mathematical calculation used to predict earthquakes and aftershocks. By analyzing the times, dates, and places of recent crimes computers project hot spots for burglaries, break-ins, and car thefts. LA's Police Chief Charlie Beck says increasing police patrols inside those boxes denies criminals opportunity. The real measure of this is not how many people you catch, it's how much crime you prevent. I love catching people. It's what I live for. But, what I'd rather do is live in a place and work in a place where crime didn't happen.

The LAPD began testing the predictive policing model here in the Foothill Division in November, and the early results are encouraging. Burglaries are down 33%, and violent crime is also down 21%. That success will allow Beck to expand the program to other parts of the city and leverage limited resources.

The analytical tools you have learned in this class can be used to make these predictive policing models possible. However, communicating the results of these models is critical. A linear regression output table will not be of use to a police person on patrol. Visualization bridges the gap between the analytics and the end user.

we'll discuss how we can create visualizations that are used in predictive policing models. In almost every application, before we even consider a predictive model, we should try to understand the historical data. Many cities in the United States and around the world, provide logs of reported crimes, usually the time, location, and nature of the event.

We could display daily crime averages using a line graph, like the one shown here, but this doesn't seem too useful. We can see that crime tends to be higher on Saturday, but when on Saturday, and where? We could replace our x-axis with the hour of the day and have a different line for every day of the week to understand when crime occurs in more detail. But this would be a jumbled mess with seven lines, and probably very hard to read.  We could instead use no visualization at all, and instead present information in a table.

For each hour and day, we have the total number of crimes that occurred. This is a valid representation of the data, but large tables of numbers can be hard to read and understand. So how can we make the table more interesting and usable? A great way to visualize information in a two-dimensional table is with a heat map. Heat maps visualize data using three attributes. Two of the attributes are on the x and y-axes, typically displayed horizontally and verticall . The third attribute is represented by shades of color. For example, the x-axis could be hours of the day, the y-axis could be days of the week, and the colors could correspond to the amount of crime. In a heat map, we can pick different color schemes based on the type of data to convey different messages. In crime, a yellow to red color scheme might be appropriate because it can highlight some of the more dangerous areas in red. Your eye is naturally drawn to the red areas of the plot. In other applications, both high and low values are meaningful, so having a more varied color scheme might be useful. And in other applications, you might only want to see cells with high values, so you could use a gray scale to make the cells with low values white. The x and y-axes in a heat map don't need to be continuous.
In our example, we have a categorical or factor variable -- the day of the week. And we can even combine a heat map with a geographical map, which we'll discuss later in this lecture. This type of heat map is frequently used in predictive policing to show crime hot spots in a city. In this lecture, we'll use Chicago motor vehicle theft data to explore patterns of crime, both over days of the week, and over hours of the day. We're interested in analyzing the total number of car thefts that occur in any particular hour of a day of the week over our whole data set. 

we'll be using the dataset mvt.csv. Please download this dataset before starting this video. This data comes from the Chicago Police Department. 

In this video, we'll create a basic line plot to visualize crime trends. 

Let's start by reading in our data.


```r
mvt = read.csv("C:/Users/Fahad/Documents/R Projects/Data/mvt.csv")
str(mvt)
```

```
## 'data.frame':	191641 obs. of  3 variables:
##  $ Date     : Factor w/ 131680 levels "1/1/01 0:01",..: 42824 42823 42823 42823 42822 42821 42820 42819 42817 42816 ...
##  $ Latitude : num  41.8 41.9 42 41.8 41.8 ...
##  $ Longitude: num  -87.6 -87.7 -87.8 -87.7 -87.6 ...
```

```r
f = as.factor(c("", "no", "yes"))
f = as.numeric(f)  #This converts to number according to the level i.e. yes = 3, ''=1 and no = 2
class(f)
```

```
## [1] "numeric"
```


It read our Date column as a factor so we will reload the data to disable the string being read as a factor:



```r
mvt = read.csv("C:/Users/Fahad/Documents/R Projects/Data/mvt.csv", stringsAsFactors = FALSE)
str(mvt)
```

```
## 'data.frame':	191641 obs. of  3 variables:
##  $ Date     : chr  "12/31/12 23:15" "12/31/12 22:00" "12/31/12 22:00" "12/31/12 22:00" ...
##  $ Latitude : num  41.8 41.9 42 41.8 41.8 ...
##  $ Longitude: num  -87.6 -87.7 -87.8 -87.7 -87.6 ...
```


Now we can see that the Date is a character type now. We have over 190,000 observations of three different variables--the date of the crime, and the location of the crime, in terms of latitude and longitude. We want to first convert the Date variable to a format that R will recognize so that we can extract the day of the week and the hour of the day.

We can do this using the strptime function. So we want to replace our variable, Date, with the output of the strptime function, which takes as a first argument our variable, Date, and then as a second argument the format that the date is in. Here, we can see in the output from the str function that our format is the month slash the day slash the year, and then the hour colon minutes. So our format equals, "%m/%d/%y %H:%M", close the parentheses, and hit Enter:


```r
mvt$Date = strptime(mvt$Date, format = "%m/%d/%y %H:%M")
class(mvt$Date)
```

```
## [1] "POSIXlt" "POSIXt"
```

```r
str(mvt$Date)
```

```
##  POSIXlt[1:191641], format: "2012-12-31 23:15:00" "2012-12-31 22:00:00" ...
```


Or you can use achieve the same result using lubridate library which is really easy to use and works with both factor and character type:


```r
install.packages("lubridate", repos = "http://cran.rstudio.com/")
```

```
## Installing package into 'C:/Users/Fahad/Documents/R/win-library/3.1'
## (as 'lib' is unspecified)
```

```
## package 'lubridate' successfully unpacked and MD5 sums checked
```

```
## Warning: cannot remove prior installation of package 'lubridate'
```

```
## 
## The downloaded binary packages are in
## 	C:\Users\Fahad\AppData\Local\Temp\RtmpADwdOu\downloaded_packages
```

```r
library("lubridate")
```

```
## Error: there is no package called 'lubridate'
```

```r
mvt$Date = mdy_hm(mvt$Date)
```

```
## Error: could not find function "mdy_hm"
```

```r
class(mvt$Date)
```

```
## [1] "POSIXlt" "POSIXt"
```


If our date format was 31/12/2012 23:59:00, we could've used the lubridate's dmy_hms() function to convert it to date format with time in hours:minutes:second.

In this format, we can extract the hour and the day of the week from the Date variable, and we can add these as new variables to our data frame. We can use the lubridate functions to do it easily. You can extract information from date times with the functions like **second(), minute(), hour(), day(), wday(), yday(), week(), month(), year(), and tz()**. 

You can also use each of these to set (i.e, change) the given information. Notice that this will alter the date time. wday() and month() have an optional label argument, which replaces their numeric output with the name of the weekday or month.


```r

mvt$WeekDay = wday(mvt$Date, label = TRUE, abbr = FALSE)
```

```
## Error: could not find function "wday"
```

```r
mvt$Hour = hour(mvt$Date)
```

```
## Error: could not find function "hour"
```

```r
str(mvt)
```

```
## 'data.frame':	191641 obs. of  3 variables:
##  $ Date     : POSIXlt, format: "2012-12-31 23:15:00" "2012-12-31 22:00:00" ...
##  $ Latitude : num  41.8 41.9 42 41.8 41.8 ...
##  $ Longitude: num  -87.6 -87.7 -87.8 -87.7 -87.6 ...
```


**Note**: Weekday is an ordered factor.

Let's start by creating the line plot with just one line and a value for every day of the week. We want to plot as that value the total number of crimes on each day of the week. We can get this information by creating a table of the WeekDay variable.


```r

table(mvt$WeekDay)
```

```
## < table of extent 0 >
```

```r
sort(table(mvt$WeekDay))
```

```
## integer(0)
```


This table gives the total amount of crime on each day of the week. We can see that most of the crimes are happening on Friday. Let's save this table as a data frame so that we can pass it to ggplot as our data.


```r

WeekdayCounts = as.data.frame(table(mvt$WeekDay))
str(WeekdayCounts)
```

```
## 'data.frame':	0 obs. of  1 variable:
##  $ Freq: int
```


We can see that our data frame has seven observations (because we have seven days a week), and two different variables. The first variable, called Var1, gives the name of the day of the week, and the second variable, called Freq, for frequency, gives the total amount of crime on that day of the week.

Now, we're ready to make our plot.


```r

library(ggplot2)
ggplot(WeekdayCounts, aes(x = Var1, y = Freq)) + geom_line(aes(group = 1))
```

```
## Error: object 'Var1' not found
```


paramaters in the geom_line method just groups all of our data into one line, since we want one line in our plot. We can see that this is very close to the plot we want. We have the total number of crime plotted by day of the week.

**Note** If you didn't use the lubridate method to extract the WeekDay and instead used weekdays(mvt$Date) method, you will not get an ordered factor of the Weekdays i.e. Sunday, Monday, Tuesday...Friday. Instead you will get an unordered list i.e. Monday, Friday, Sunday etc. We can convert the Var1 into an ordered factor variable.

This will signal the ggplot that the ordering is meaningful. We can do this by using the factor function. So let's start by the variable we want to convert, and set that equal to the output of the factor function, where the first argument is our variable, WeekdayCounts$Var1, the second argument is ordered = TRUE. This says that we want an ordered factor. And the third argument, which is levels, should be equal to a vector of the days of the week in the order we want them to be in. We'll use the c function to do this. So first, in quotes, type "Sunday" -- we want Sunday first-- and then "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday". Go ahead and close both parentheses and hit Enter.


```r

WeekdayCounts$Var1 = factor(WeekdayCounts$Var1, ordered = TRUE, levels = c("Sunday", 
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
ggplot(WeekdayCounts, aes(x = Var1, y = Freq)) + geom_line(aes(group = 1))
```

```
## Error: Aesthetics must either be length one, or the same length as the
## dataProblems:Var1, Freq
```

But you can see that Lubridate saved us the hassle of converting it to the ordered list at the first instance.

The last thing we'll want to do to our plot is just change the x- and y-axis labels, since they're not very helpful as they are now.


```r
ggplot(WeekdayCounts, aes(x = Var1, y = Freq)) + geom_line(aes(group = 1)) + 
    xlab("Day of the Week") + ylab("Number of Crimes/Total Motor Vehicle Thefts") + 
    ggtitle("Crime Rate Daily View")
```

```
## Error: Aesthetics must either be length one, or the same length as the
## dataProblems:Var1, Freq
```


Try different paramters and create a new line plot, but add the argument "linetype=2"


```r

ggplot(WeekdayCounts, aes(x = Var1, y = Freq)) + geom_line(aes(group = 1), linetype = 2) + 
    xlab("Day of the Week") + ylab("Number of Crimes/Total Motor Vehicle Thefts") + 
    ggtitle("Crime Rate Daily View")
```

```
## Error: Aesthetics must either be length one, or the same length as the
## dataProblems:Var1, Freq
```

We can see that it changes the line type to dashed. Now, change the alpha parameter to 0.3 by replacing "linetype=2" with "alpha=0.3" in the plot command and see what happens:


```r

ggplot(WeekdayCounts, aes(x = Var1, y = Freq)) + geom_line(aes(group = 1), alpha = 0.3) + 
    xlab("Day of the Week") + ylab("Number of Crimes/Total Motor Vehicle Thefts") + 
    ggtitle("Crime Rate Daily View")
```

```
## Error: Aesthetics must either be length one, or the same length as the
## dataProblems:Var1, Freq
```


It made the line lighter in colour.

## Heat Map

Next, we'll add the hour of the day to our line plot, and then create a heat map.

We can do this by creating a line for each day of the week and making the x-axis the hour of the day. We first need to create a counts table for the weekday, and hour.


```r
table(mvt$WeekDay, mvt$Hour)
```

```
## < table of extent 0 x 0 >
```


This table gives, for each day of the week and each hour, the total number of motor vehicle thefts that occurred. For example, on Friday at 4 AM, there were 473 motor vehicle thefts, whereas on Saturday at midnight, there were 2,050 motor vehicle thefts.

Let's save this table to a data frame so that we can use it in our visualizations.


```r

DayHourCounts = as.data.frame(table(mvt$WeekDay, mvt$Hour))
str(DayHourCounts)
```

```
## 'data.frame':	0 obs. of  2 variables:
##  $ Var2: NULL
##  $ Freq: int
```


We can see that we have 168 observations-- one for each day of the week and hour pair, and three different variables. The first variable, Var1, gives the day of the week. The second variable, Var2, gives the hour of the day. And the third variable, Freq for frequency, gives the total crime count. 

**Note** Again Lubridate have given us the ordered list of Weekdays and Hours

Let's convert the second variable, Var2, to actual numbers and call it Hour, since this is the hour of the day, and it makes sense that it's numerical. 


```r
DayHourCounts$Hour = as.numeric(as.character(DayHourCounts$Var2))
str(DayHourCounts)
```

```
## 'data.frame':	0 obs. of  3 variables:
##  $ Var2: NULL
##  $ Freq: int 
##  $ Hour: num
```


This is how we convert a factor variable to a numeric variable.

Now we're ready to create our plot. We just need to change the group to Var1, which is the day of the week. So we'll use the ggplot function where our data frame is DayHourCounts, and then in our aesthetic, we want the x-axis to be Hour this time, the y-axis to be Freq, and then in the geom_line option, we want the aesthetic to have the group equal to Var1, which is the day of the week. 


```r

ggplot(DayHourCounts, aes(x = Hour, y = Freq)) + geom_line(aes(group = Var1))
```

```
## Error: object 'Var1' not found
```


It has seven lines, one for each day of the week. While this is interesting, we can't tell which line is which day, so let's change the colors of the lines to correspond to the days of the week. To do that, change after group = Var1, add color = Var1.


```r

ggplot(DayHourCounts, aes(x = Hour, y = Freq)) + geom_line(aes(group = Var1, 
    color = Var1), size = 2)
```

```
## Error: object 'Var1' not found
```


Now in our plot, each line is colored corresponding to the day of the week. This helps us see that on Saturday and Sunday, for example, the green and the teal lines, there's less motor vehicle thefts in the morning. While we can get some information from this plot, it's still quite hard to interpret. Seven lines is a lot. Let's instead visualize the same information with a heat map. To make a heat map, we'll use our data in our data frame DayHourCounts.

First change the order of the Weekday as shown above if it is not in chronological order. In fact let's put Weekdays first and weekend at the end to reinforce the learning:


```r

DayHourCounts$Var1 = factor(DayHourCounts$Var1, ordered = TRUE, levels = c("Monday", 
    "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
```


## Heat Map

Now let's make our heat map. We'll use the ggplot function like we always do,



```r

ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq))
```

```
## Error: argument is of length zero
```


So how do we read this? For each hour and each day of the week, we have a rectangle in our heat map. The color of that rectangle indicates the frequency, or the number of crimes that occur in that hour and on that day. Our legend tells us that lighter colors correspond to more crime. So we can see that a lot of crime happens around midnight, particularly on the weekends. 

We can change the label on the legend, and get rid of the y label to make our plot a little nicer.


```r

ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq)) + 
    scale_fill_gradient(name = "Total MV Thefts") + theme(axis.title.y = element_blank())
```

```
## Error: argument is of length zero
```

scale_fill_gradient() method defines properties of the legend, and we want name = "Total MV Thefts", for total motor vehicle thefts. Then we added, in the theme(axis.title.y = element_blank()). This is what you can do if you want to get rid of one of the axis labels.

We can also change the color scheme.



```r

ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq)) + 
    scale_fill_gradient(name = "Total MV Thefts", low = "white", high = "red") + 
    theme(axis.title.y = element_blank())
```

```
## Error: argument is of length zero
```

White and Red is a common color scheme in policing. It shows the hot spots, or the places with more crime, in red. So now the most crime is shown by the red spots and the least crime is shown by the lighter areas. It looks like Friday night is a pretty common time for motor vehicle thefts. We saw something that we didn't really see in the heat map before. It's often useful to change the color scheme depending on whether you want high values or low values to pop out, and the feeling you want the plot to portray. 

For practice: Let's flip the axis to have days on x-axis and hours on y-axis


```r
ggplot(DayHourCounts, aes(x = Var1, y = Hour)) + geom_tile(aes(fill = Freq)) + 
    scale_fill_gradient(name = "Total MV Thefts", low = "white", high = "red") + 
    theme(axis.title.y = element_blank())
```

```
## Error: argument is of length zero
```


Let's get back to the first heat map and change the colour to black and white:


```r

ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq)) + 
    scale_fill_gradient(name = "Total MV Thefts", low = "white", high = "black") + 
    theme(axis.title.y = element_blank())
```

```
## Error: argument is of length zero
```


## A Geographical Hot Spot Map

