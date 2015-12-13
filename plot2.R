setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=temp, mode="wb")
m <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header=T, na.strings="?")
unlink(temp)
n <- m[m$Date == "2007-02-01" | m$Date == "2007-02-02",]
n$timestamp <- as.POSIXct(paste(n$Date, n$Time))

Sys.setlocale(category = "LC_ALL", locale = "english")

png(filename = "plot2.png",width = 480, height = 480, units = "px", pointsize = 12)

with(n, plot(Global_active_power ~ timestamp, pch="",ylab="Global Active Power (kilowatts)", xlab=""))
with(n, lines(timestamp, Global_active_power))

dev.off()