library(lubridate)
library(plyr)

power <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F, na.strings = "?")
power <- mutate(power, Date = dmy(Date))
power <- filter(power, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
power <- mutate(power, DateTimeSeconds = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

par(mfrow = c(1,1), bg = "transparent", oma = c(0,0,0,0), mar = c(5.1, 4.1, 4.1, 2.1)) 
plot(power$DateTimeSeconds, y = power$Global_active_power, type = "l", pch = 20, ylab = "Global Active Power (kilowatts)", xlab = "")

screen <- dev.cur()
png(width = 480, height = 480, filename = "plot2.png")
png <- dev.cur()
dev.set(screen)
dev.copy(which = png)
dev.off(which = png)