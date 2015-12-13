setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
m <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header=T, na.strings="?")
n <- m[m$Date == "2007-02-01" | m$Date == "2007-02-02"]
n$timestamp <- as.POSIXct(paste(n$Date, n$Time))

Sys.setlocale(category = "LC_ALL", locale = "english")

png(filename = "plot3.png",width = 480, height = 480, units = "px", pointsize = 12)
with(n, plot(timestamp, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(n, lines(timestamp, Sub_metering_1))
with(n, points(timestamp, Sub_metering_2, pch=""))
with(n, lines(timestamp, Sub_metering_2, col="red"))
with(n, points(timestamp, Sub_metering_3, pch=""))
with(n, lines(timestamp, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()