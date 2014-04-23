#Load the dataset from CPSData.csv into a data frame called CPS, and view the dataset with the summary() 
#and str() commands.

# Problem 1.5 - Loading and Summarizing the Dataset

#Q:How many interviewees are in the dataset? 
ANS: 131302

CPS = read.csv("CPSData.csv")
str(CPS) 
nrow(CPS)

#Q: Among the interviewees with a value reported for the Industry variable, 
#what is the most common industry of employment? Please enter the name exactly how you see it.
ANS: Educational and health services

max(table(CPS$Industry))
sort(table(CPS$Industry))

#Q: Which state has the fewest interviewees? Using sort function
ANS: New Mexico 

names(CPS)
sort(table(CPS$State))

#Q: Which state has the largest number of interviewees?
ANS: California

sort(table(CPS$State))

#Q: What proportion of interviewees are citizens of the United States?
ANS: 0.9421943

names(CPS)

table(CPS$Citizenship)

#EXPLANATION: From table(CPS$Citizenship), we see that 123,712 of the 131,302 interviewees are 
#citizens of the United States (either native or naturalized). This is a proportion of 123712/131302=0.942. 

(116639+7073)/(116639+7073+7590)

#Q: The CPS differentiates between race (with possible values American Indian, Asian, Black, Pacific Islander
#, White, or Multiracial) and ethnicity. A number of interviewees are of Hispanic ethnicity, 
#as captured by the Hispanic variable. For which races are there at least 250 interviewees in the 
#CPS dataset of Hispanic ethnicity?
ANS: American Indian, Black, Multiracial, White

table(CPS$Race, CPS$Hispanic)

#Problem 2.1 - Evaluating Missing Values

#Q: Which variables have at least one interviewee with a missing (NA) value?
ANS: MetroAreaCode, Married, Education, EmploymentStatus, Industry

summary(CPS)

#Q: Often when evaluating a new dataset, we try to identify if there is a pattern in the missing values in the 
#dataset. We will try to determine if there is a pattern in the missing values of the Married variable. 
#The function is.na(CPS$Married) returns a vector of TRUE/FALSE values for whether the Married variable 
#is missing. We can see the breakdown of whether Married is missing based on the reported value of the Region
#variable with the function table(CPS$Region, is.na(CPS$Married)). Which is the most accurate:
The Married variable being missing is related to the Region value for the interviewee. 
The Married variable being missing is related to the Sex value for the interviewee. 
The Married variable being missing is related to the Age value for the interviewee. 
The Married variable being missing is related to the Citizenship value for the interviewee. 
The Married variable being missing is not related to the Region, Sex, Age, or Citizenship value for the interviewee. 

ANS:The Married variable being missing is related to the Age value for the interviewee. 

table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))
table(CPS$Citizenship, is.na(CPS$Married))

#EXPLATION: For each possible value of Region, Sex, and Citizenship, there are both interviewees 
#with missing and non-missing Married values. However, Married is missing for all interviewees Aged 0-14 and
#is present for all interviewees aged 15 and older. This is because the CPS does not ask about marriage status
#for interviewees 14 and younger. 

#Q: As mentioned in the variable descriptions, MetroAreaCode is missing if an interviewee does not live in a 
#metropolitan area. Using the same technique as in the previous question, answer the following questions about 
#people who live in non-metropolitan areas.

#How many states had all interviewees living in a non-metropolitan area
#(aka they have a missing MetroAreaCode value)? For this question, treat the District of Columbia as a state 
#(even though it is not technically a state).
ANS: 2

names(CPS)
table(CPS$State, is.na(CPS$MetroAreaCode))

#Q: How many states had all interviewees living in a metropolitan area? Again, treat the District 
#of Columbia as a state.
ANS: 3

table(CPS$State, is.na(CPS$MetroAreaCode))

#EXPLANATION: The breakdown of missing MetroAreaCode by State can be obtained with 
#table(CPS$State, is.na(CPS$MetroAreaCode)). Alaska and Wyoming have no interviewees living in a metropolitan
#area, and the District of Columbia, New Jersey, and Rhode Island have all interviewees living in a metro area. 

#Q: Which region of the United States has the largest proportion of interviewees living in a non-metropolitan area?
ANS: South

table(CPS$Region, is.na(CPS$MetroAreaCode))
max(10674/(20010+10674),
5609/(20330+5609),
9871/(9871+31631),
8084/(25093+8084))

#EXPLANATION: To evaluate the number of interviewees not living in a metropolitan area, broken down by region, 
#we can run table(CPS$Region, is.na(CPS$MetroAreaCode)). We can then compute the proportion of interviewees in
#each region that live in a non-metropolitan area: 34.8% in the Midwest, 21.6% in the Northeast, 23.8% in the 
#South, and 24.4% in the West. 

#While we were able to use the table() command to compute the proportion of interviewees from each region not 
#living in a metropolitan area, it was somewhat tedious (it involved manually computing the proportion for 
#each region) and isn't something you would want to do if there were a larger number of options. It turns out
#there is a less tedious way to compute the proportion of values that are TRUE. 
#The mean() function, which takes the average of the values passed to it, will treat TRUE as 1 and FALSE as 0, 
#meaning it returns the proportion of values that are true.
#For instance, mean(c(TRUE, FALSE, TRUE, TRUE)) returns 0.75. Knowing this, use tapply() with the mean function
#to answer the following questions:

#Q:Which state has a proportion of interviewees living in a non-metropolitan area closest to 30%?

sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))

#EXPLANATION: From this output, we can see that Wisconsin is the state closest to having 30% of its interviewees from a 
#non-metropolitan area (it has 29.933% non-metropolitan interviewees) and Montana is the state with highest 
#proportion of non-metropolitan interviewees without them all being non-metropolitan, at 83.608%.

# Problem 3.1 - Integrating Metropolitan Area Data

#Codes like MetroAreaCode and CountryOfBirthCode are a compact way to encode factor variables with text as their possible values, and they are therefore quite common in survey datasets. In fact, all but one of the variables in this dataset were actually stored by a numeric code in the original CPS datafile.

#When analyzing a variable stored by a numeric code, we will often want to convert it into the values the codes
#represent. To do this, we will use a dictionary, which maps the the code to the actual value of the variable. 
#We have provided dictionaries MetroAreaCodes.csv and CountryCodes.csv, which respectively map MetroAreaCode 
#and CountryOfBirthCode into their true values. 
#Read these two dictionaries into data frames MetroAreaMap and CountryMap.

MetroAreaMap = read.csv("MetroAreaCodes.csv")
CountryMap = read.csv("CountryCodes.csv")

#Q: How many metropolitan areas are stored in MetroAreaMap?
ANS: 271 (Levels in MetroArea Factor Variable)

str(MetroAreaMap)

#How many countries are stored in CountryMap?
ANS: 149 (149 levels in the factor variable 'Country')

str(CountryMap)

#Problem 3.2 - Integrating Metropolitan Area Data

#To merge in the metropolitan areas, we need to connect the field MetroAreaCode from the CPS data frame with 
#the field 'Code' in MetroAreaMap. The following command merges the two data frames on these columns, 
#overwriting the CPS data frame with the result:

#Variable to overwrite = merge(DataFrame1 to be merged, DataFrame2 to be merged, )
CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code",all.x=TRUE)

#The first two arguments determine the data frames to be merged (they are called "x" and "y", respectively, 
#in the subsequent parameters to the merge function).
#by.x="MetroAreaCode" means we're matching on the MetroAreaCode variable from the CPS dataframe.
#while by.y="Code" means we're matching on the 'Code' variable from the MetroAreaMap data frame.
#Finally, all.x=TRUE means we want to keep all rows from the CPS data frame, even if some of the rows
#' MetroAreaCode doesn't match any codes in MetroAreaMap
# (for those familiar with database terminology, this parameter makes the operation a left outer join 
#instead of an inner join).

#Q: Review the new version of the CPS data frame with the summary() and str() functions. 
#What is the name of the variable that was added to the data frame by the merge() operation?
ANS: MetroArea

summary(CPS)
str(CPS)

#Q: Which of the following metropolitan areas has the largest number of interviewees?
ANS:  Boston-Cambridge-Quincy, MA-NH 

#Explanation said you can use this but this doesnt give answer so I had to extract the data for those and then check
table(CPS$MetroArea)

MetroAreas = c("Atlanta-Sandy Springs-Marietta, GA", "Baltimore-Towson, MD", "Boston-Cambridge-Quincy, MA-NH", "San Francisco-Oakland-Fremont, CA")
MetroAreasSub = subset(CPS, MetroArea %in% MetroAreas)
MetroAreasSub$MetroArea = factor(MetroAreasSub$MetroArea)
sort(table(MetroAreasSub$MetroArea))

str(MetroAreasSub)
names(CPS)
sort(table(CPS$MetroArea))

#Q: Which metropolitan area has the highest proportion of interviewees of Hispanic ethnicity? 
#Hint: Use tapply() with mean, as in the previous subproblem. Calling sort() on the output of tapply() 
#could also be helpful here.

sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))

#Remembering that CPS$Race == "Asian" returns a TRUE/FALSE vector of whether an interviewee is Asian, 
#determine the number of metropolitan areas in the United States from which at least 20% of interviewees 
#are Asian
ANS: 4

table(CPS$MetroArea, CPS$Race == "Asian")

sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

#Normally, we would look at the sorted proportion of interviewees from each metropolitan area 
#who have not received a high school diploma with the command:

sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, na.rm=TRUE, mean))

#Problem 4.1 - Integrating Country of Birth Data

#Q: Just as we did with the metropolitan area information, 
#merge in the country of birth information from the CountryMap data frame, 
#replacing the CPS data frame with the result. If you accidentally overwrite CPS with the wrong values, 
#remember that you can restore it by re-loading the data frame from CPSData.csv and then merging in the 
#metropolitan area information using the command provided in the previous subproblem.

names(CountryMap)
names(CPS)
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)

str(CPS)
sort(summary(CPS$Country))
str(CPS$Country)

#Q: Among all interviewees born outside of North America, which country was the most common place of birth?
ANS: Philippines

names(CPS)
sort(summary(CPS$Country))

#Q: What proportion of the interviewees from the "New York-Northern New Jersey-Long Island, NY-NJ-PA" 
#metropolitan area have a country of birth that is not the United States? 
#For this computation, don't include people from this metropolitan area who have a missing country of birth.

table(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country != "United States")
1668/(3736+1668)

#Q: Which metropolitan area has the largest number (note -- not proportion) of interviewees with a country of 
#birth in India?
#Hint -- remember to include na.rm=TRUE if you are using tapply() to answer this question.

sort(tapply(CPS$Country == "India", CPS$MetroArea,na.rm=TRUE, sum))

#In Brazil

sort(tapply(CPS$Country == "Brazil", CPS$MetroArea,na.rm=TRUE, sum))

#In Somalia
sort(tapply(CPS$Country == "Somalia", CPS$MetroArea,na.rm=TRUE, sum))
