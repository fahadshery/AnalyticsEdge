getwd()

AnonymityPoll = read.csv("AnonymityPoll.csv")

str(AnonymityPoll)
summary(AnonymityPoll)

table(AnonymityPoll$Smartphone)

summary(AnonymityPoll$Smartphone)

table(AnonymityPoll$Sex, AnonymityPoll$Region)

table(AnonymityPoll$State, AnonymityPoll$Region)

#Another way to approach these problems would have been to subset the data frame and then use table on 
#the limited data frame. For instance, to find which states are in the Midwest region we could have used:

MidwestInterviewees = subset(AnonymityPoll, Region=="Midwest")

MidwestInterviewees$State = factor(MidwestInterviewees$State)
table(MidwestInterviewees$State)

summary(AnonymityPoll$Smartphone)
summary(AnonymityPoll$Internet.Use)

table(AnonymityPoll$Internet.Use, AnonymityPoll$Smartphone)

limited = subset(AnonymityPoll, AnonymityPoll$Internet.Use ==1 | AnonymityPoll$Smartphone ==1)
table(limited$Internet.Use, limited$Smartphone)

nrow(limited)

summary(limited)

table(limited$Info.On.Internet)

table(limited$Worry.About.Info)

386/(404+386)

table(limited$Tried.Masking.Identity)
128/(656+128)

hist(limited$Age, col="red")

plot(limited$Age, limited$Info.On.Internet)

max(table(limited$Info.On.Internet, limited$Age))

jitter(c(1,2,3))

plot(jitter(limited$Age), jitter(limited$Info.On.Internet))


# tapply(Summary Variable, Group Variable, Function)
tapply(limited$Info.On.Internet, limited$Smartphone, summary)
#We can read the average for non-smartphone users from the summary output labeled with `0` and
#the average for smartphone users from the summary output labeled with `1`

#another example is to break down the Tried.Masking.Identity variable for smartphone and non-smartphone users.
#using tapply()

tapply(limited$Tried.Masking.Identity, limited$Smartphone, summary)
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)
