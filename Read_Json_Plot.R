# read json
path = 'C:/R/data.json'
data = fromJSON(path)
data1=data['chartData']
temp=data1$chartData$main

# convert timestamp to date
date=as.Date(as.POSIXct(temp[,1]/1000, origin="1970-01-01"))
# plot
plot(date,temp[,2],type = 'b',xlab = "Date",ylab='Price',xaxt='n')
axis.Date(1,at=date,labels=format(date,"%y/%m"),las=2) 
abline(lm(temp[,2]~date),col='gray',lty=2)



# read json
path = 'C:/Users/Student/notebooks/wine.json'
wine = fromJSON(path)
winedata = wine$chartData$main

# convert timestamp to date
date=as.Date(as.POSIXct(winedata[,1]/1000, origin="1970-01-01"))
# plot
plot(date,winedata[,2],type = 'b',xlab = "Date",ylab='Price',las=1,xaxt='n')
axis.Date(1,at=date,labels=format(date,"%y/%m"),las=2) 
abline(lm(winedata[,2]~date),col='darkgray',lty=2)
