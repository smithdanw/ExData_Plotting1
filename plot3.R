library(lubridate)
library(plyr)

power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F, na.strings = "?")
power <- mutate(power, Date = dmy(Date))
power <- filter(power, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
power <- mutate(power, DateTime = paste(Date, Time, sep = "-"), type="o")
power <- mutate(power, DateTimeObject = ymd_hms(DateTime), type="o")
power <- mutate(power, DateTimeSeconds = unclass(as.POSIXct(DateTimeObject)))

min <- min(power$DateTimeSeconds)
max <- max(power$DateTimeSeconds)
fri <- min +  ((max - min) / 2)
par(xaxt = "n", mfrow = c(1,1))

plot(power$DateTimeSeconds, y = power$Sub_metering_1, type = "l", pch = 20, xlim = c(min, max), ylab = "Energy sub metering", xlab = "")
lines(power$DateTimeSeconds, y = power$Sub_metering_2, col = "red")
lines(power$DateTimeSeconds, y = power$Sub_metering_3, col = "blue")

width = strwidth("Sub_metered_1") * 1.5
legend("topright", border = "black", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, text.width = width)
par(xaxt = "l")
axis(1, labels = c("Thur", "Fri", "Sat"), at = c(min, fri, max), tick = T)

screen <- dev.cur()
png(width = 480, height = 480, filename = "plot3.png")
png <- dev.cur()
dev.set(screen)
dev.copy(which = png)
dev.off(which = png)