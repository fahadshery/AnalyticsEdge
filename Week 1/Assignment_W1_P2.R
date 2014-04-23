getwd()

#Read files into R
IBM = read.csv("IBMStock.csv")
GE = read.csv("GEStock.csv")
ProcterGamble = read.csv("ProcterGambleStock.csv")
CocaCola = read.csv("CocaColaStock.csv")
Boeing = read.csv("BoeingStock.csv")

#change all the dates into R format
IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
str(IBM)
summary(IBM)
lines(IBM$Date[301:432],IBM$StockPrice[301:432], col="purple")

Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")
str(Boeing)
summary(Boeing)
lines(Boeing$Date[301:432],Boeing$StockPrice[301:432],col="black")

CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
str(CocaCola)
summary(CocaCola)
plot(CocaCola$Date, CocaCola$StockPrice, type="l", col = "red")
plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
sort(tapply(CocaCola$StockPrice, months(CocaCola$Date),mean))


GE$Date = as.Date(GE$Date, "%m/%d/%y")
str(GE)
summary(GE)
lines(GE$Date[301:432],GE$StockPrice[301:432],col="Orange")
sort(tapply(GE$StockPrice, months(GE$Date),mean))


ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
str(ProcterGamble)
sd(ProcterGamble$StockPrice, na.rm = TRUE)
lines(ProcterGamble$Date, ProcterGamble$StockPrice, col="blue")
lines(ProcterGamble$Date[301:432], ProcterGamble$StockPrice[301:432], col="blue")
abline(v=as.Date(c("1995-01-01")),lwd=2)
abline(v=as.Date(c("2005-01-01")),lwd=2)
abline(v=as.Date(c("1997-09-01")),lwd=2)
abline(v=as.Date(c("1997-11-01")),lwd=2)
abline(v=as.Date(c("2004-01-01")),lwd=2)
abline(v=as.Date(c("2005-01-01")),lwd=2)
sort(tapply(ProcterGamble$StockPrice, months(ProcterGamble$Date),mean))

mean(IBM$StockPrice)
sort(tapply(IBM$StockPrice,months(IBM$Date),mean))
