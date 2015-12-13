setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile=temp, mode="wb")
m <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", colClasses=c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), header=T, na.strings="?")
unlink(temp)
n <- m[m$Date == "2007-02-01" | m$Date == "2007-02-02",]
n$timestamp <- as.POSIXct(paste(n$Date, n$Time))

Sys.setlocale(category = "LC_ALL", locale = "english")

png(filename = "plot4.png",width = 480, height = 480, units = "px", pointsize = 12)

par(mfrow=c(2,2))
with(n, 
{
plot(Global_active_power ~ timestamp, pch="",ylab="Global Active Power (kilowatts)", xlab="")
lines(timestamp, Global_active_power)
plot(Voltage ~ timestamp, pch="",ylab="Voltage", xlab="datetime")
lines(timestamp, Voltage)
plot(timestamp, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(timestamp, Sub_metering_1)
points(timestamp, Sub_metering_2, pch="")
lines(timestamp, Sub_metering_2, col="red")
points(timestamp, Sub_metering_3, pch="")
lines(timestamp, Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
plot(Global_reactive_power ~ timestamp, xlab="datetime", pch="")
lines(timestamp, Global_reactive_power)
})

dev.off()