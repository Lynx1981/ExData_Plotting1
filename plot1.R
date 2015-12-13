setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
m <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header=T, na.strings="?")
n <- m[m$Date == "2007-02-01" | m$Date == "2007-02-02"]
n$timestamp <- as.POSIXct(paste(n$Date, n$Time))

Sys.setlocale(category = "LC_ALL", locale = "english")

png(filename = "plot1.png",width = 480, height = 480, units = "px", pointsize = 12)

with(n, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowats)"))

dev.off()