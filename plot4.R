library(lubridate)
library(plyr)

power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F, na.strings = "?")
power <- mutate(power, Date = dmy(Date))
power <- filter(power, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
power <- mutate(power, DateTimeSeconds = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

par(mfrow = c(2,2), oma = c(2,0,0,0), mar = c(4,4,4,2), bg = "transparent")
plot(power$DateTimeSeconds, y = power$Global_active_power, type = "l", pch = 20, ylab = "Global Active Power", xlab = "")

plot(power$DateTimeSeconds, y = power$Voltage, type = "l", pch = 20, ylab = "Voltage", xlab = "datetime")

plot(power$DateTimeSeconds, y = power$Sub_metering_1, type = "l", pch = 20, ylab = "Energy sub metering", xlab = "")
lines(power$DateTimeSeconds, y = power$Sub_metering_2, col = "red")
lines(power$DateTimeSeconds, y = power$Sub_metering_3, col = "blue")

width = strwidth("Sub_metered_1") * 3.5
legend("topright",box.lwd = 0, y.intersp = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, text.width = width)

plot(power$DateTimeSeconds, y = power$Global_reactive_power, type = "l", pch = 20, ylab = "Global_reactive_power", xlab = "datetime")

screen <- dev.cur()
png(width = 480, height = 480, filename = "plot4.png")
png <- dev.cur()
dev.set(screen)
dev.copy(which = png)
dev.off(which = png)