#load libraries
library(quantmod)

#variables to use
interestrates <- vector(mode="numeric", length=c(8))
names(interestrates) <- c("DGS3MO", "DGS1", "DGS2", "DGS5", "DGS7", "DGS10", "DGS20", "DGS30")

#Establish environment
env=globalenv()

#Get the data
getSymbols("DGS3MO", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS1", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS2", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS5", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS7", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS10", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS20", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("DGS30", src = "FRED", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)
getSymbols("^GSPC", from = as.Date("2000-12-01"), to = Sys.Date(), env = env)

#Clean the data
DGS3MO<-na.approx(DGS3MO)
DGS1<-na.approx(DGS1)
DGS2<-na.approx(DGS2)
DGS5<-na.approx(DGS5)
DGS7<-na.approx(DGS7)
DGS10<-na.approx(DGS10)
DGS20<-na.approx(DGS20)
DGS30<-na.approx(DGS30)
GSPC<-na.approx(GSPC)


#Calculate basic info from file
marketopendays<-time(GSPC)
interestratesdays<-time(DGS1)
firstday<-min(marketopendays)
lastday<-max(marketopendays)-1
lastdayir<-max(interestratesdays)
maxclose<-max(GSPC[,6])
minclose<-min(GSPC[,6])
